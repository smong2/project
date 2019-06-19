<?php
require_once 'XML/Unserializer.php';

class ContainerAPI
{
	const SORT_BY_CREATE_DT  = 0;
	const SORT_BY_COMMENT_DT = 1;

	const LIST_TYPE_SENT     = 0;
	const LIST_TYPE_RECIEVED = 1;
	const LIST_TYPE_ALL      = 2;

	const FORBID_WORD = 'CONTAINS_FORBID_WORD';
	const FORBID_CODE = 273;

	/**
	 * Container 서버에 요청한다.
	 * 
	 * @param string $url 요청할 URL, PATH(ex. /message/list.nate)만 넘긴다.
	 * @param array $params {key: value, ...} 형식으로 전달한다.
	 * @param array $forceEnum 한 개짜리 Element 라도 array 로 반환할 태그를 반환한다.
	 * 
	 * @return array XML을 array로 변환하여 반환한다. 에러가 발생할 경우는 false를 반환한다.
	 */
	private function _sendRequest($url, array $params, array $forceEnum = array(), $isTextPlain = false) /*{{{*/
	{
		// HTTP Request
		$request = new HTTP_Request($url);
		$request->setMethod(HTTP_REQUEST_METHOD_POST);
		foreach ($params as $key=>$val) {
			$request->addPostData($key, $val);
		}

		$request->sendRequest();

		Logger::log('all', 9, 'remote_addr : '.$_SERVER['HTTP_X_FORWARDED_FOR']);
		Logger::log('all', 9, date('Y.m.d').' '.$request->getUrl().' - '.$request->getResponseCode());
		Logger::log('all', 9, $request->_postData);

		if ($request->getResponseCode() != '200') {
			Logger::log('request', 9, 'response err : '.date('Y.m.d').' '.$request->getUrl().' - '.$request->getResponseCode());
			Logger::log('request', 9, $request->_postData);
			return self::_returnConnectionErr();
		}

		// XML Parsing
		$xml = $request->getResponseBody();

		// retrieve or get 이 아닌 경우
		if ($isTextPlain) {
			$msg = self::_codeGenerator($xml);
			return self::xmlGenerator($msg);
		}

		$options      = array(XML_UNSERIALIZER_OPTION_FORCE_ENUM => $forceEnum);
		$unserializer = new XML_Unserializer($options);

		$status = $unserializer->unserialize($xml);

		if (PEAR::isError($status)) {
			Logger::log('rcode', 9, 'pear err : '.date('Y.m.d').' '.$request->getUrl().' - '.$request->getResponseCode());
			Logger::log('rcode', 9, $request->_postData);
			return self::_returnUnknownErr();
		}
		return $xml;
	} /*}}}*/

	/**
	 * plain text 일 때 사용
	 */
	private static function _codeGenerator($result) /*{{{*/
	{
		$tmpResult = explode(' ', $result);
		return array('code' => $tmpResult[0], 'codeMsg' => str_replace($tmpResult[0], '', $result));
	} /*}}}*/

	/**
	 * XML Form 생성
	 */
	public static function xmlGenerator($result) /*{{{*/
	{
		$xml = '<?xml version="1.0" encoding="utf-8" ?>
				<NateConnect>
					<rcode>_code_</rcode>
					<rmsg>_message_</rmsg>
				</NateConnect>';

		return str_replace(array('_code_', '_message_'), array($result['code'], $result['codeMsg']), $xml);
	} /*}}}*/

	/**
	 * ===================================================================
	 * =========    커넥팅 메시지 관련 메소드   ==========================
	 * ===================================================================*/

	/**
	 * 메시지 공개여부 Default 값을 가져온다
	 * 
	 * @param User $user 사용자 객체
	 * @param Service $service 서비스 계정
	 */
	public function getMessageDefault(User $user, Service $service) /*{{{*/
	{
		try {
			$params             = array();
			$params['svc_id']   = $service->getServiceId();
			$params['svc_pwd']  = $service->getServiceKey();
			$params['user_cmn'] = $user->getUserId();

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/member/showAddDefault.nate', $params, array('post'), true);

			if ($result === false) {
				return $this->_returnConnectionErr();
			}


			$simpleXML = simplexml_load_string($result);

			if (Code::MSG_SUCCESS == $simpleXML->rcode) {
				// 메시지와 URL 분리
				$messageArr         = explode("\n", $simpleXML->rmsg);
				$simpleXML->rmsg    = trim($messageArr[0]);
				$simpleXML->default = $messageArr[1];

				return $simpleXML->asXML();
			}
			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 메시지 목록을 얻어온다.
	 * 
	 * @param User $user 조회하려는 사용자 객체
	 * @param string $startIdx 다음 페이지 시작 ID
	 * @param int $sort SORT_BY_XXX 정렬 타입
	 * @param int $sourceType SOURCE_TYPE_XXX 조회할 소스 타입
	 * @param int $listType LIST_TYPE_XXX 조회할 전송 대상
	 * @param User $sender 조회할 메시지를 보낸 사용자 객체
	 * @param int $rows 전달 받을 데이터 개수
	 * @param string $openYN 
	 * @param string $domain 사용자 도메인 정보
	 * @param string $viewerCmn 조회자 cmn
	 * @param Service $service 서비스 계정
	 * 
	 * @return array of (Container's response Data)
	 */
	public static function getMessages(User $user, $startIdx = '', $sort = '', $sourceType = '', $listType = '', $sender = null, $rows = 10, $openYN, $domain = '', $viewerCmn, Service $service) /*{{{*/
	{
		static $sCache = array();

		$key = $user->getUserId() . ':' . $startIdx . ':' . $sort . ':' . $sourceType . ':' . $listType . ':' .($sender ? $sender->getUserId() : '') . ':' . $rows;

		if (isset($sCache[$key]) === false) {
			try {
				// Generate Post Data
				$params             = array();
				$params['svc_id']   = $service->getServiceId();
				$params['svc_pwd']  = $service->getServiceKey();
				$params['user_cmn'] = $user->getUserId();
				if ($sort !== '') {
					$params['sort'] = $sort;
				}
				else {
					$params['sort'] = self::SORT_BY_CREATE_DT;
				}
				if ($startIdx !== '') {
					$params['start_idx'] = $startIdx;
				}
				if ($sourceType !== '') {
					$params['source_type'] = $sourceType;
				}

				$params['list_type'] = $listType;

				if ($sender !== null) {
					$params['sender_cmn'] = $sender->getUserId();
					$params['list_type']  = self::LIST_TYPE_SENT;
				}
				$params['rows']       = $rows;
				$params['open_yn']    = $openYN;
				$params['domain']     = $domain;
				$params['viewer_cmn'] = $viewerCmn;

				$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/message/list.nate', $params, array('post'));
				if ($result === false) {
					return self::_returnConnectionErr();
				}

				return $result;
			} catch (Exception $e) {
				return self::_returnUnknownErr();
			}

			$sCache[$key] = $retval;
		}

		return $sCache[$key];
	} /*}}}*/

	public static function getMessagesV1(User $user, $startIdx = '', $sort = '', $sourceType = '', $listType = '', $sender = null, $rows = 10, Service $service) /*{{{*/
	{
		static $sCache = array();

		$key = $user->getUserId() . ':' . $startIdx . ':' . $sort . ':' . $sourceType . ':' . $listType . ':' .($sender ? $sender->getUserId() : '') . ':' . $rows;

		if (isset($sCache[$key]) === false) {
			try {
				// Generate Post Data
				$params             = array();
				$params['svc_id']   = $service->getServiceId();
				$params['svc_pwd']  = $service->getServiceKey();
				$params['user_cmn'] = $user->getUserId();
				if ($sort !== '') {
					$params['sort'] = $sort;
				}
				else {
					$params['sort'] = self::SORT_BY_CREATE_DT;
				}
				if ($startIdx !== '') {
					$params['start_idx'] = $startIdx;
				}
				if ($sourceType !== '') {
					$params['source_type'] = $sourceType;
				}

				$params['list_type'] = $listType;

				if ($sender !== null) {
					$params['sender_cmn'] = $sender->getUserId();
					$params['list_type']  = self::LIST_TYPE_SENT;
				}
				$params['rows'] = $rows;

				$result = self::_sendRequest(ConfigManager::get('connecting.container.url_prev').'/message/list.nate', $params, array('post'));
				if ($result === false) {
					return self::_returnConnectionErr();
				}

				return $result;
			} catch (Exception $e) {
				return self::_returnUnknownErr();
			}

			$sCache[$key] = $retval;
		}

		return $sCache[$key];
	} /*}}}*/
	/**
	 * Home 메시지 목록을 얻어온다.
	 * 
	 * @param User $user 조회하려는 사용자 객체
	 * @param string $startIdx 다음 페이지 시작 ID
	 * @param int $sort SORT_BY_XXX 정렬 타입
	 * @param int $sourceType SOURCE_TYPE_XXX 조회할 소스 타입
	 * @param int $listType LIST_TYPE_XXX 조회할 전송 대상
	 * @param User $sender 조회할 메시지를 보낸 사용자 객체
	 * @param int $rows 전달 받을 데이터 개수
	 * @param Service $service 서비스 계정
	 * 
	 * @return array of (Container's response Data)
	 */
	public static function getHomeMessages(User $user, $startIdx = '', $sort = '', $sourceType = '', $listType = '', $sender = null, $rows = 10, Service $service) /*{{{*/
	{
		static $sCache = array();

		$key = $user->getUserId() . ':' . $startIdx . ':' . $sort . ':' . $sourceType . ':' . $listType . ':' .($sender ? $sender->getUserId() : '') . ':' . $rows;

		if (isset($sCache[$key]) === false) {
			try {
				// Generate Post Data
				$params             = array();
				$params['svc_id']   = $service->getServiceId();
				$params['svc_pwd']  = $service->getServiceKey();
				$params['user_cmn'] = $user->getUserId();
				if ($sort !== '') {
					$params['sort'] = $sort;
				}
				else {
					$params['sort'] = self::SORT_BY_CREATE_DT;
				}
				if ($startIdx !== '') {
					$params['start_idx'] = $startIdx;
				}
				if ($sourceType !== '') {
					$params['source_type'] = $sourceType;
				}

				$params['list_type'] = $listType;

				if ($sender !== null) {
					$params['sender_cmn'] = $sender->getUserId();
					$params['list_type']  = self::LIST_TYPE_SENT;
				}
				$params['rows'] = $rows;

				$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/message/home.nate', $params, array('post'));
				if ($result === false) {
					return self::_returnConnectionErr();
				}

				return $result;
			} catch (Exception $e) {
				return self::_returnUnknownErr();
			}

			$sCache[$key] = $retval;
		}

		return $sCache[$key];
	} /*}}}*/

	/**
	 * 메시지 목록을 얻어온다. -  전체 공개 커넥팅
	 * 
	 * @param User $user 조회하려는 사용자 객체
	 * @param string $startIdx 다음 페이지 시작 ID
	 * @param int $rows 전달 받을 데이터 개수
	 * @param Service $service 서비스 계정
	 * 
	 * @return array of (Container's response Data)
	 */
	public static function getMessagesTimeline(User $user, $startIdx = '', $rows = 10, Service $service) /*{{{*/
	{
		static $sCache = array();

		$key = $user->getUserId() . ':' . $startIdx . ':' . $rows;

		if (isset($sCache[$key]) === false) {
			try {
				// Generate Post Data
				$params             = array();
				$params['svc_id']   = $service->getServiceId();
				$params['svc_pwd']  = $service->getServiceKey();
				$params['user_cmn'] = $user->getUserId();
				if ($startIdx !== '') {
					$params['start_idx'] = $startIdx;
				}
				$params['rows'] = $rows;

				$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/message/timeline.nate', $params, array('post'));
				if ($result === false) {
					return self::_returnConnectionErr();
				}

				return $result;
			} catch (Exception $e) {
				return self::_returnUnknownErr();
			}

			$sCache[$key] = $retval;
		}

		return $sCache[$key];
	} /*}}}*/

	/**
	 * 단일 메시지를 조회한다.
	 * 
	 * @param User $user 조회하려는 사용자 객체
	 * @param Message $message 메시지 정보를 담은 객체
	 * @param sring $clearAlarm 알람초기화 여부
	 * @param Service $service 컨테이너 계정 정보
	 * 
	 * @return array of (Container's response Data)
	 */
	public static function viewMessage(User $user, Message $message, $clearAlarm, Service $service) /*{{{*/
	{
		try {
			// Generate Post Data
			$params                = array();
			$params['svc_id']      = $service->getServiceId();
			$params['svc_pwd']     = $service->getServiceKey();
			$params['user_cmn']    = $user->getUserId();
			$params['message_key'] = $message->getMessageKey();
			$params['message_id']  = $message->getMessageId();
			$params['clear_alarm'] = $clearAlarm;

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/message/view.nate', $params, array('post'));

			if ($result === false) {
				return self::_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 메시지 등록
	 * 
	 * @param Message	$message		메시지 내용
	 * @param Service $service		컨테이너 계정 정보
	 * 
	 * @return array of (Container's response Data)
	 */
	public static function addMessage(Message $message, Service $service) /*{{{*/
	{
		try {
			$params                     = array();
			$params['svc_id']           = $service->getServiceId();
			$params['svc_pwd']          = $service->getServiceKey();
			$params['message']          = $message->getMessage();
			$params['sender_cmn']       = $message->getSender()->getUserId();
			$params['profile_type']     = $message->getProfileType();
			$params['comment']          = $message->getComment();
			$params['open_yn']          = $message->getOpenYn();
			$params['from_url']         = $message->getFromUrl();
			$params['from_title']       = $message->getFromTitle();
			$params['send_twitter']     = $message->getSendTwitter();
			$params['msg_open_default'] = $message->getMsgOpenDefault();


			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/message/add.nate', $params, array('post'), true);


			if ($result === false) {
				return self::_returnConnectionErr();
			}

			// forbid_word XML Data
			$simpleXML = simplexml_load_string($result);
			if ($simpleXML->rcode == self::FORBID_CODE) {
				$simpleXML->forbidWord = trim(str_replace(self::FORBID_WORD, '', $simpleXML->rmsg));
				$simpleXML->rmsg       = self::FORBID_WORD;

				$result = $simpleXML->asXML();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 메시지를 삭제한다.
	 * 
	 * @param Message $message 삭제할 메시지 객체
	 * @param Service $service 컨테이너 계정 정보
	 * user_cmn 은 메시지 내에 있는 sender 에 저장해서 넘기므로 파라미터 필요없음 
	 * @return bool 성공할 경우 true 를 반환한다.
	 */
	public static function deleteMessage(Message $message, Service $service) /*{{{*/
	{
		try {
			// Generate Post Data
			$params                = array();
			$params['svc_id']      = $service->getServiceId();
			$params['svc_pwd']     = $service->getServiceKey();
			$params['message_key'] = $message->getMessageKey();
			$params['user_cmn']    = $message->getSender()->getUserId();

			// Send Request
			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/message/delete.nate', $params, array(), true);


			if ($result === false) {
				return self::_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 메시지 알람
	 * 
	 * @param User $user 사용자 객체
	 * @param Service $service 컨테이너 계정 정보
	 * 
	 * @return array of  (container's response Data)
	 */
	public static function getAlarmMessage(User $user, Service $service) /*{{{*/
	{
		try {
			$params             = array();
			$params['svc_id']   = $service->getServiceId();
			$params['svc_pwd']  = $service->getServiceKey();
			$params['user_cmn'] = $user->getUserId();

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/message/newAlarm.nate', $params, array(), false);

			if ($result === false) {
				return self::_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 리커넥팅 하기
	 * 
	 * @param User $user 사용자 객체
	 * @param Message $message 삭제할 메시지 객체
	 * @param Service $service 컨테이너 계정 정보
	 * 
	 * @return bool 성공할 경우 true 를 반환한다.
	 */
	public static function reconnect(User $user, Message $message, Service $service) /*{{{*/
	{
		try {
			// Generate Post Data
			$params                  = array();
			$params['svc_id']        = $service->getServiceId();
			$params['svc_pwd']       = $service->getServiceKey();
			$params['user_cmn']      = $user->getUserId();
			$params['reconnect_key'] = $message->getReconnectKey();
			$params['comment']       = $message->getComment();

			// Send Request
			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/message/reconnect.nate', $params, array(), true);


			if ($result === false) {
				return self::_returnConnectionErr();
			}

			// forbid_word XML Data
			$simpleXML = simplexml_load_string($result);
			if ($simpleXML->rcode == self::FORBID_CODE) {
				$simpleXML->forbidWord = trim(str_replace(self::FORBID_WORD, '', $simpleXML->rmsg));
				$simpleXML->rmsg       = self::FORBID_WORD;

				$result = $simpleXML->asXML();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * ===================================================================
	 * ================    커넥팅 댓글 관련 메소드   =====================
	 * ===================================================================*/

	/**
	 * 댓글 목록을 읽어온다.
	 * 
	 * @param User $usre 조회하려는 사용자 객체
	 * @param Message $message 이 메시지의 댓글을 읽어온다.
	 * @param int $page 페이지 번호
	 * @param int $rows 페이지당 목록 출력 수
	 * @param string $mode 재댓글 출력시 사용 (mode=re), 트위터 댓글 추가 (mode=twit)
	 * @param Service $service 서비스 계정
	 * 
	 * @return array of {comments: array of Comment, totalPages: int, totalComments: int}
	 */
	public static function getComments(User $user, Message $message, $page = 1, $rows = 10, $mode, Service $service) /*{{{*/
	{
		try {
			// Validate Parameters
			$page = $page <= 0 ? 1 : $page;
			$rows = $rows <= 0 ? 10 : $rows;

			// Generate Post Data
			$params                = array();
			$params['svc_id']      = $service->getServiceId();
			$params['svc_pwd']     = $service->getServiceKey();
			$params['user_cmn']    = $user->getUserId();
			$params['message_key'] = $message->getMessageKey();
			$params['page']        = $page;
			$params['rows']        = $rows;
			$params['mode']        = $mode;

			// Send Request
			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/comment/list.nate', $params, array('comment'));

			if ($result === false) {
				return self::_returnConnectionErr();
			}
			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	public static function getCommentsV1(User $user, Message $message, $page = 1, $rows = 10, Service $service) /*{{{*/
	{
		try {
			// Validate Parameters
			$page = $page <= 0 ? 1 : $page;
			$rows = $rows <= 0 ? 10 : $rows;

			// Generate Post Data
			$params                = array();
			$params['svc_id']      = $service->getServiceId();
			$params['svc_pwd']     = $service->getServiceKey();
			$params['user_cmn']    = $user->getUserId();
			$params['message_id']  = $message->getMessageId();
			$params['message_cmn'] = $message->getSender()->getUserId();
			$params['page']        = $page;
			$params['rows']        = $rows;

			// Send Request
			$result = self::_sendRequest(ConfigManager::get('connecting.container.url_prev').'/comment/list.nate', $params, array('comment'));

			if ($result === false) {
				return self::_returnConnectionErr();
			}
			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/
	/**
	 * 댓글을 추가한다.
	 * 
	 * @param Message $message 댓글을 추가할 커넥팅 객체
	 * @param User $user 댓글 추가할 유저 객체
	 * @param Comment $comment 댓글 객체
	 * @param string $mode 트위터 댓글(twit)/일반 댓글
	 * @param Service $service 서비스 계정
	 * 
	 * @return array XML
	 */
	public static function addComment(User $user, Comment $comment, $mode, $twitId = '', Service $service) /*{{{*/
	{
		try {
			// Generate Post Data
			$params                = array();
			$params['svc_id']      = $service->getServiceId();
			$params['svc_pwd']     = $service->getServiceKey();
			$params['user_cmn']    = $user->getUserId();
			$params['message_key'] = $comment->getMessage()->getMessageKey();
			$params['sender_cmn']  = $comment->getWriter()->getUserId();
			$params['comment']     = $comment->getContent();
			$params['is_secret']   = $comment->getIsSecret();
			$params['parent_id']   = $comment->getParentId();
			$params['mode']        = $mode;
			$params['twit_id']     = $twitId;

			// Send Request
			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/comment/add.nate', $params, array(), true);

			if ($result === false) {
				return self::_returnConnectionErr();
			}

			// forbid_word XML Data
			$simpleXML = simplexml_load_string($result);
			if ($simpleXML->rcode == self::FORBID_CODE) {
				$simpleXML->forbidWord = trim(str_replace(self::FORBID_WORD, '', $simpleXML->rmsg));
				$simpleXML->rmsg       = self::FORBID_WORD;

				$result = $simpleXML->asXML();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 댓글을 삭제한다.
	 * 
	 * @param Comment $comment 삭제할 댓글 객체
	 * @param User $user 삭제 요청한 사용자의 객체
	 * @param string $mode 트위터 댓글(twit)/일반 댓글
	 * @param Service $service 서비스 계정
	 * 
	 * @return array XML
	 */
	public static function deleteComment(Comment $comment, User $user, $mode = '', Service $service) /*{{{*/
	{
		try {
			// Generate Post Data
			$params                = array();
			$params['svc_id']      = $service->getServiceId();
			$params['svc_pwd']     = $service->getServiceKey();
			$params['user_cmn']    = $user->getUserId();
			$params['message_key'] = $comment->getMessage()->getMessageKey();
			$params['comment_key'] = $comment->getCommentKey();
			$params['mode']        = $mode;

			// Send Request
			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/comment/delete.nate', $params, array(), true);

			if ($result === false) {
				return self::_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 댓글 알림 - 처리 객체
	 * @param User $user 유저 객체
	 * @param Service $service 서비스 계정
	 * 
	 * @return array XML
	 */
	public function getCommentAlarm(User $user, Service $service) /*{{{*/
	{
		try {
			// Generate Post Data
			$params             = array();
			$params['user_cmn'] = $user->getUserId();
			$params['svc_id']   = 'nateontab';
			$params['svc_pwd']  = 'spdlxmdhsxoq!';


			// Send Request
			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/comment/newAlarm.nate', $params, array('post'));

			// alarm XML Data
			$simpleXML = simplexml_load_string($result);

			$key = null;
			if (trim($simpleXML->alarm->message_id)) {
				$key = $simpleXML->alarm->cmn . ',' . $simpleXML->alarm->message_id;
			}

			$content = null;
			if ($key) {
				$message = Message::instance($key);
				$message->setSender(User::instance($user->getUserId()));
				$message->setMessageId($simpleXML->alarm->message_id);

				// total comment cnt
				$one                       = $message->viewMessage($user, 'n', $service);
				$simpleXMLforOneConnecting = simplexml_load_string($one);

				// comments Data for alarm
				$comments             = self::getComments($user, $message, null, intval($simpleXMLforOneConnecting->post->comment_cnt), Comment::COMMENT_TYPE_RECOMMENT, $service);
				$simpleXMLforComments = simplexml_load_string($comments);

				// fetch oneContent
				if (isset($simpleXMLforComments->comments->comment)) {
					foreach ($simpleXMLforComments->comments->comment as $comment) {
						if (strval($simpleXML->alarm->writer_cmn) != strval($comment->cmn)) {
							continue;
						}

						$content = $comment->content;
					}
				}
			}

			$simpleXML->alarm->content = $content;

			return $simpleXML->asXML();
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * ====================================================================
	 * ======================    유저 정보    =============================
	 * ====================================================================*/

	/**
	 * 사용자 프로필 이미지 조회
	 */
	public static function profileImgs(User $user, Service $service) /*{{{*/
	{
		$result = array('code' => Code::MSG_SUCCESS, 'codeMsg' => Code::$errmsg[Code::MSG_SUCCESS]);

		try {
			$params             = array();
			$params['svc_id']   = $service->getServiceId();
			$params['svc_pwd']  = $service->getServiceKey();
			$params['user_cmn'] = $user->getUserId();
			$userInfo           = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/member/show.nate', $params, array('post'));

			if ($userInfo === false) {
				$userImg = null;
			} else {
				$simpleXMLImg = simplexml_load_string($userInfo, 'simpleXMLElement', LIBXML_NOCDATA);
				$userImg      = $simpleXMLImg->profile->profile_thumbnail_url;
			}

			$imgs      = $user->getProfileImgs();
			$xml       = self::xmlGenerator($result);
			$simpleXML = simplexml_load_string($xml);

			foreach ($imgs as $key=>$img) {
				$simpleXML->profile_imgs->profile_img[$key]->type = $key;
				$simpleXML->profile_imgs->profile_img[$key]->url  = $img;
			}

			if (isset($userImg)) {
				$uimg = $user->generateProfileImageUrl(0, $userImg);
			} else {
				$uimg = $user->generateProfileImageUrl(1, '');
			}

			$simpleXML->profile_imgs->profile_img[0]->type = '0';
			$simpleXML->profile_imgs->profile_img[0]->url  = $uimg;

			return $simpleXML->asXML();
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 나의 커넥팅 상태 조회 (최근 3일간 댓글 등록 여부, 최초 커넥팅 여부, 댓글 정보 초기화
	 * 
	 * @param User       $user 유저 객체
	 * @param string     $mode 모드 0:댓글 정보 초기화, 1:최근 3일간 댓글 등록 여부
	 *                          2:최초 커넥팅 여부, 3:1+2
	 * @param Service $service 컨테이너 계정 정보
	 * 
	 * @return array of (container's response Data)
	 */
	public static function getUserStatus(User $user, $mode, Service $service) /*{{{*/
	{
		try {
			$params             = array();
			$params['svc_id']   = $service->getServiceId();
			$params['svc_pwd']  = $service->getServiceKey();
			$params['user_cmn'] = $user->getUserId();
			$params['mode']     = $mode;

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/member/status.nate', $params, array('post'), true);

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			$simpleXML = simplexml_load_string($result);

			if (Code::MSG_SUCCESS == $simpleXML->rcode) {
				// 메시지와 URL 분리
				$messageArr      = explode("\n", $simpleXML->rmsg);
				$simpleXML->rmsg = trim($messageArr[0]);

				// 3일 내 댓글
				if (1 == $mode) {
					$simpleXML->comment3days = $messageArr[1];
				} else if (2 == $mode) {
					// 커넥팅 여부
					$simpleXML->isConnecting = $messageArr[1];
				} else if (3 == $mode) {
					$responseStatus = explode(',', $messageArr[1]);

					$simpleXML->comment3days = $responseStatus[0];
					$simpleXML->isConnecting = $responseStatus[1];
				}

				return $simpleXML->asXML();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 사용자 정보 조회
	 */
	public static function getUserInfo(User $user, Service $service) /*{{{*/
	{
		try {
			$params             = array();
			$params['svc_id']   = $service->getServiceId();
			$params['svc_pwd']  = $service->getServiceKey();
			$params['user_cmn'] = $user->getUserId();

			if ($user->getDomain()) {
				$params['domain'] = $user->getDomain();
			}

			if ($user->getNickname() != null) {
				$params['nickname'] = $user->getNickname();
			}

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/member/show.nate', $params, array('post'));

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 도메인/닉네임 존재여부 확인
	 */
	public static function checkExistDomainOrNickname(User $user, Service $service) /*{{{*/
	{
		try {
			$params             = array();
			$params['svc_id']   = $service->getServiceId();
			$params['svc_pwd']  = $service->getServiceKey();
			$params['user_cmn'] = $user->getUserId();
			$params['domain']   = $user->getDomain();
			$params['nickname'] = $user->getNickname();

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/member/exist.nate', $params, array('post'));

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 사용자 정보 업데이트
	 */
	public static function updateUserInfo(User $user, Service $service) /*{{{*/
	{
		try {
			$params                  = array();
			$params['svc_id']        = $service->getServiceId();
			$params['svc_pwd']       = $service->getServiceKey();
			$params['user_cmn']      = $user->getUserId();
			$params['id']            = $user->getNateId();
			$params['domain']        = $user->getDomain();
			$params['nickname']      = $user->getNickname();
			$params['name']          = $user->getRealname();
			$params['profile_image'] = $user->getProfileImage();
			$params['thome_tl_yn']   = $user->getTHomeTlYn();
			$params['tuser_tl_yn']   = $user->getTUserTlYn();
			$params['toast_yn']      = $user->getToastYn();
			$params['introduce']     = $user->getIntroduce();
			$params['show_nickname'] = $user->getShowNickname();

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/member/update.nate', $params, array('post'), true);

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			// forbid_word XML Data
			$simpleXML = simplexml_load_string($result);
			if ($simpleXML->rcode == self::FORBID_CODE) {
				$simpleXML->forbidWord = trim(str_replace(self::FORBID_WORD, '', $simpleXML->rmsg));
				$simpleXML->rmsg       = self::FORBID_WORD;

				$result = $simpleXML->asXML();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 사용자 토스트 사용여부  업데이트
	 */
	public static function updateToast(User $user, Service $service) /*{{{*/
	{
		try {
			$params             = array();
			$params['svc_id']   = $service->getServiceId();
			$params['svc_pwd']  = $service->getServiceKey();
			$params['user_cmn'] = $user->getUserId();
			$params['id']       = $user->getNateId();
			$params['name']     = $user->getRealname();
			$params['toast_yn'] = $user->getToastYn();

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/member/updateToast.nate', $params, array('post'), true);

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 말풍선 조회
	 */
	public static function balloonView(User $user, Service $service) /*{{{*/
	{
		try {
			$params             = array();
			$params['svc_id']   = $service->getServiceId();
			$params['svc_pwd']  = $service->getServiceKey();
			$params['user_cmn'] = $user->getUserId();

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/balloon/view.nate', $params, array('post'));

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 말풍선 확인
	 */
	public static function balloonCheck(User $user, $balloonType, Service $service) /*{{{*/
	{
		try {
			$params                 = array();
			$params['svc_id']       = $service->getServiceId();
			$params['svc_pwd']      = $service->getServiceKey();
			$params['user_cmn']     = $user->getUserId();
			$params['balloon_type'] = $balloonType;

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/balloon/check.nate', $params, array('post'), true);

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 블로그 연동 정보
	 */
	public static function getLinkedBlogs(User $user, $page, $rows, Service $service) /*{{{*/
	{
		try {
			$params             = array();
			$params['svc_id']   = $service->getServiceId();
			$params['svc_pwd']  = $service->getServiceKey();
			$params['user_cmn'] = $user->getUserId();
			$params['page']     = $page;
			$params['rows']     = $rows;

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/twitter/check.nate', $params, array('post'));

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * ====================================================================
	 * ======================    버디 정보    =============================
	 * ====================================================================*/

	/**
	 * 내가 추가한 친구 리스트
	 * 
	 * @param User $user 유저 객체
	 * @param int	$rows 페이지 당 목록 수
	 * @param int   $page 페이지
	 * @param string $sortType 정렬 타입
	 * @param string $schType
	 * @param string $schValue
	 * @param string $blockYN
	 * @param string $mInfoYn
	 * @param Service $service
	 * 
	 * @resutn List
	 */
	public static function getFriendList(User $user, $rows, $page, $sortType, $selectType, $schType, $schValue, $mInfoYn, Service $service) /*{{{*/
	{
		try {
			$params                = array();
			$params['svc_id']      = $service->getServiceId();
			$params['svc_pwd']     = $service->getServiceKey();
			$params['user_cmn']    = $user->getUserId();
			$params['rows']        = $rows;
			$params['page']        = $page;
			$params['sort_type']   = $sortType;
			$params['select_type'] = $selectType;
			$params['sch_type']    = $schType;
			$params['sch_value']   = $schValue;
			$params['m_info_yn']   = $mInfoYn;

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/buddy/fList.nate', $params, array('post'));

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 나를 추가한 친구 리스트
	 * 
	 * @param User $user 유저 객체
	 * @param int	$rows 페이지 당 목록 수
	 * @param int   $page 페이지
	 * @param string $sortType 정렬 타입
	 * @param string $selectType 조회 출처
	 * @param string $schType
	 * @param string $schValue
	 * @param string $blockYN
	 * @param Service $service
	 * 
	 * @resutn List
	 */
	public static function getReverseFriendList(User $user, $rows, $page, $sortType, $selectType, $schType, $schValue, $blockYN, Service $service) /*{{{*/
	{
		try {
			$params                = array();
			$params['svc_id']      = $service->getServiceId();
			$params['svc_pwd']     = $service->getServiceKey();
			$params['user_cmn']    = $user->getUserId();
			$params['rows']        = $rows;
			$params['page']        = $page;
			$params['sort_type']   = $sortType;
			$params['block_yn']    = $blockYN;
			$params['sch_type']    = $schType;
			$params['sch_value']   = $schValue;
			$params['select_type'] = $selectType;

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/buddy/rFList.nate', $params, array('post'));

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 친구 삭제
	 * 
	 * @param User $user 유저 객체
	 * @param Buddy $buddy 친구 객체
	 * @param Service $service
	 * 
	 * @return XML
	 */
	public static function deleteFriend(User $user, Buddy $buddy, Service $service) /*{{{*/
	{
		try {
			$params             = array();
			$params['svc_id']   = $service->getServiceId();
			$params['svc_pwd']  = $service->getServiceKey();
			$params['user_cmn'] = $user->getUserId();
			$params['f_cmn']    = $buddy->getFCmn();

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/buddy/delete.nate', $params, array('post'), true);

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 친구 추가
	 * 
	 * @param User $user 유저 객체
	 * @param Buddy $buddy 친구 객체
	 * @param Service $service
	 */
	public static function addFriend(Buddy $buddy, User $user, Service $service) /*{{{*/
	{
		try {
			$params               = array();
			$params['svc_id']     = $service->getServiceId();
			$params['svc_pwd']    = $service->getServiceKey();
			$params['user_cmn']   = $user->getUserId();
			$params['name']       = $buddy->getName();
			$params['nate_id']    = $buddy->getNateId();
			$params['f_name']     = $buddy->getFName();
			$params['f_nate_id']  = $buddy->getFNateId();
			$params['f_cmn']      = $buddy->getFCmn();
			$params['f_tid']      = $buddy->getFTid();
			$params['reg_source'] = $buddy->getRegSource();
			$params['user_ip']    = $buddy->getUserIp();

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/buddy/add.nate', $params, array('post'), true);

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 친구 수신 거부 업데이트
	 * 
	 * @param User $user 유저 객체
	 * @param Buddy $buddy 친구 객체
	 * @param Service $service
	 * 
	 * @cmn 정보가 네이밍으로 인해 혼란됨 user_cmn 이 로그인한 사용자가 아니라 업데이트 대상자
	 *  f_cmn이 로그인한 요청자가 됨. open api 정책에 따라 아래와 같이 mapping 됨
	 *  request  i/f
	 *   cmn     f_cmn
	 *   f_cmn   user_cmn
	 */
	public static function updateRecieve(User $user, Buddy $buddy, Service $service) /*{{{*/
	{
		try {
			$params             = array();
			$params['svc_id']   = $service->getServiceId();
			$params['svc_pwd']  = $service->getServiceKey();
			$params['user_cmn'] = $buddy->getFCmn();
			$params['f_cmn']    = $user->getUserId();
			$params['block_yn'] = $buddy->getBlockYn();

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/buddy/block.nate', $params, array('post'), true);

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 친구 여부 확인
	 * @param User $user 객체
	 * @param string $cmnList , 로 나열된 cmn 정보
	 * @param Service $service SVC 계정
	 * 
	 * @return XML
	 */
	public static function isFriend(User $user, $cmnList, Service $service) /*{{{*/
	{
		try {
			$params             = array();
			$params['svc_id']   = $service->getServiceId();
			$params['svc_pwd']  = $service->getServiceKey();
			$params['user_cmn'] = $user->getUserId();
			$params['cmn_list'] = $cmnList;

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/buddy/isFriend.nate', $params, array('post'));

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * ====================================================================
	 * ======================    Follow 정보    =============================
	 * ====================================================================*/

	/**
	 * Follow 목록 조회
	 */
	public static function getFollowerList(User $user, $domain, $page, $rows, $sortType, $schType, $schValue, Service $service) /*{{{*/
	{
		try {
			$params              = array();
			$params['svc_id']    = $service->getServiceId();
			$params['svc_pwd']   = $service->getServiceKey();
			$params['user_cmn']  = $user->getUserId();
			$params['domain']    = $domain;
			$params['page']      = $page;
			$params['rows']      = $rows;
			$params['sort_type'] = $sortType;
			$params['sch_type']  = $schType;
			$params['sch_value'] = $schValue;

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/follow/followerList.nate', $params, array('post'), false);

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * Following 목록 조회
	 */
	public static function getFollowingList(User $user, $domain, $page, $rows, $sortType, $schType, $schValue, Service $service) /*{{{*/
	{
		try {
			$params              = array();
			$params['svc_id']    = $service->getServiceId();
			$params['svc_pwd']   = $service->getServiceKey();
			$params['user_cmn']  = $user->getUserId();
			$params['domain']    = $domain;
			$params['page']      = $page;
			$params['rows']      = $rows;
			$params['sort_type'] = $sortType;
			$params['sch_type']  = $schType;
			$params['sch_value'] = $schValue;

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/follow/followingList.nate', $params, array('post'));

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * following 맺기
	 */
	public static function addFollow(User $user, $userName, $userNateId, $followingCmn, Service $service) /*{{{*/
	{
		try {
			$params                  = array();
			$params['svc_id']        = $service->getServiceId();
			$params['svc_pwd']       = $service->getServiceKey();
			$params['user_cmn']      = $user->getUserId();
			$params['user_name']     = $userName;
			$params['user_nate_id']  = $userNateId;
			$params['following_cmn'] = $followingCmn;

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/follow/add.nate', $params, array('post'), true);

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * following 끊기
	 */
	public static function deleteFollow(User $user, $followingCmn, Service $service) /*{{{*/
	{
		try {
			$params                  = array();
			$params['svc_id']        = $service->getServiceId();
			$params['svc_pwd']       = $service->getServiceKey();
			$params['user_cmn']      = $user->getUserId();
			$params['following_cmn'] = $followingCmn;

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/follow/delete.nate', $params, array('post'), true);

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * follow 여부 확인
	 * @param User $user 객체
	 * @param string $cmnList , 로 나열된 cmn 정보
	 * @param Service $service SVC 계정
	 * 
	 * @return XML
	 */
	public static function isFollowing(User $user, $cmnList, Service $service) /*{{{*/
	{
		try {
			$params             = array();
			$params['svc_id']   = $service->getServiceId();
			$params['svc_pwd']  = $service->getServiceKey();
			$params['user_cmn'] = $user->getUserId();
			$params['cmn_list'] = $cmnList;

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/follow/isFollowing.nate', $params, array('post'));

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * ====================================================================
	 * ======================    트위터 연동    =============================
	 * ====================================================================*/

	/**
	 * 트위터 연동
	 */
	public static function linkAtTwitter(User $user, $token, $tokenSecret, $screenName, Service $service) /*{{{*/
	{
		try {
			$params                 = array();
			$params['svc_id']       = $service->getServiceId();
			$params['svc_pwd']      = $service->getServiceKey();
			$params['user_cmn']     = $user->getUserId();
			$params['name']         = $user->getRealname();
			$params['nate_id']      = $user->getNateId();
			$params['token']        = $token;
			$params['token_secret'] = $tokenSecret;
			$params['screen_name']  = $screenName;

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/twitter/linked.nate', $params, array('post'), true);

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 트위터 연동해제
	 */
	public static function unlinkAtTwitter(User $user, $blogUrl, Service $service) /*{{{*/
	{
		try {
			$params             = array();
			$params['svc_id']   = $service->getServiceId();
			$params['svc_pwd']  = $service->getServiceKey();
			$params['user_cmn'] = $user->getUserId();
			$params['blog_url'] = $blogUrl;

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/twitter/unlinked.nate', $params, array('post'), true);

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 트위터 홈타임라인 가져오기
	 */
	public static function getHomeTimelineAtTwitter(User $user, $page, $rows, $sinceId, $maxId, Service $service) /*{{{*/
	{
		try {
			$params             = array();
			$params['svc_id']   = $service->getServiceId();
			$params['svc_pwd']  = $service->getServiceKey();
			$params['user_cmn'] = $user->getUserId();
			$params['page']     = $page;
			$params['rows']     = $rows;
			$params['since_id'] = $sinceId;
			$params['max_id']   = $maxId;

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/twitter/homeTimeLine.nate', $params, array('post'));

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/

	/**
	 * 트위터 사용자 타임라인 가져오기
	 */
	public static function getUserTimelineAtTwitter(User $user, $page, $rows, $sinceId, $maxId, Service $service) /*{{{*/
	{
		try {
			$params             = array();
			$params['svc_id']   = $service->getServiceId();
			$params['svc_pwd']  = $service->getServiceKey();
			$params['user_cmn'] = $user->getUserId();
			$params['page']     = $page;
			$params['rows']     = $rows;
			$params['since_id'] = $sinceId;
			$params['max_id']   = $maxId;

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/twitter/userTimeLine.nate', $params, array('post'));

			if ($result === false) {
				return $this->_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/


	/**
	 * -------------------------------------------------------------------
	 *     기타 Util
	 * -------------------------------------------------------------------*/

	/**
	 * 단축 URL return 결과가 code message \n shorten_url 이므로 추가 처리 필요
	 * @param User $user 유저 객체
	 * @param String $url url 정보
	 * @param String $type 이미지용/비디오용 등 타입 정보
	 * @param String $serviceType 단축 URL 서비스를 어떤 것을 사용할지 결정 bitly, zulim
	 * @param Service $service 서비스 계정
	 * 
	 * @return array XML
	 */
	public static function shorten(User $user, $url, $type, $serviceType, Service $service) /*{{{*/
	{
		try {
			$params             = array();
			$params['svc_id']   = $service->getServiceId();
			$params['svc_pwd']  = $service->getServiceKey();
			$params['user_cmn'] = $user->getUserId();
			$params['url']      = $url;
			$params['type']     = $type;
			$params['service']  = $serviceType;

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/url/shorten.nate', $params, array(), true);

			if ($result === false) {
				return self::_returnConnectionErr();
			}

			$simpleXML = simplexml_load_string($result);

			if (Code::MSG_SUCCESS == $simpleXML->rcode) {
				// 메시지와 URL 분리
				$messageArr             = explode("\n", $simpleXML->rmsg);
				$simpleXML->rmsg        = trim($messageArr[0]);
				$simpleXML->url         = $url;
				$simpleXML->shorten_url = $messageArr[1];

				return $simpleXML->asXML();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/


	/**
	 * -------------------------------------------------------------------
	 *     return 정보
	 * -------------------------------------------------------------------*/

	/** 
	 * 코드 리턴 결과 출력 - 컨테이너 연결 오류
	 */
	private static function _returnConnectionErr() /*{{{*/
	{
		$result = array('code' => Code::MSG_CONNECTION, 'codeMsg' => Code::$errmsg[Code::MSG_CONNECTION]);
		return self::xmlGenerator($result);
	} /*}}}*/

	/** 
	 * 코드 리턴 결과 출력 - Unknown  오류
	 */
	private static function _returnUnknownErr() /*{{{*/
	{
		$result = array('code' => Code::MSG_UNKNOWN, 'codeMsg' => Code::$errmsg[Code::MSG_UNKNOWN]);
		return self::xmlGenerator($result);
	} /*}}}*/

	/** 
	 * 코드 리턴 결과 출력 - DB Data 없음  오류
	 */
	private static function _returnNoneDataErr() /*{{{*/
	{
		$result = array('code' => Code::MSG_NONE_DATA, 'codeMsg' => Code::$errmsg[Code::MSG_NONE_DATA]);
		return self::xmlGenerator($result);
	} /*}}}*/

	//  ----- Deprecated -------- //
	/**
	 * 뉴스 정보를 읽어온다.
	 * 
	 * @param string $xk 뉴스 아이디, Message.attach_url 에 저장되어 있다.
	 * 
	 * @param array of {source_url: 뉴스 URL, attach_url: 썸네일 URL, message: 타이틀}
	 */
	public static function getNewsInfo($xk) /*{{{*/
	{
		$retval = array(
		    'source_url' => '',
		    'attach_url' => '',
		    'message' => '',
		);

		// Generate Post Data
		$params          = array();
		$params['xk']    = $xk;
		$params['scode'] = 'B';

		// Send Request
		$result = self::_sendRequest('http://xmlcontainer.skcomms.co.kr/openscrap/post/get/v1', $params);
		if ($result === false) {
			return $retval;
		}

		// Generate Return Value
		if (isset($result['Post']['Url'])) {
			$retval['source_url'] = $result['Post']['Url'];
		}
		if (isset($result['Post']['OriginPhotoLink01']['Url'])) {
			$retval['attach_url'] = $result['Post']['OriginPhotoLink01']['Url'];
		}
		if (isset($result['Post']['Subject'])) {
			$retval['message'] = $result['Post']['Subject'];
		}

		return $retval;
	} /*}}}*/

	/**
	 * 귓속말을 비밀글로 변경한다.   -- deprecated
	 * 
	 * @param Comment $comment 비밀글로 변경할 댓글 객체
	 * @param Service $service 서비스 계정
	 * 
	 * @return array XML
	 */
	public static function secretComment(User $user, Comment $comment, Service $service) /*{{{*/
	{
		try {
			// Generate Post Data
			$params                = array();
			$params['svc_id']      = $service->getServiceId();
			$params['svc_pwd']     = $service->getServiceKey();
			$params['user_cmn']    = $user->getUserId();
			$params['message_id']  = $comment->getMessage()->getMessageId();
			$params['message_cmn'] = $comment->getMessage()->getSender()->getUserId();
			$params['comment_id']  = $comment->getCommentId();
			$params['is_secret']   = $comment->getIsSecret();

			// Send Request
			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/comment/update.nate', $params, array(), true);

			if ($result === false) {
				return self::_returnConnectionErr();
			}

			return $result;
		} catch (Exception $e) {
			return self::_returnUnknownErr();
		}
	} /*}}}*/
}
?>
