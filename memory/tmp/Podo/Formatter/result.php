<?php
require_once 'XML/Unserializer.php';

class ContainerAPI
{
	const SORT_BY_CREATE_DT  = 0;
	const SORT_BY_COMMENT_DT = 1;

	const LIST_TYPE_SENT    = 0;
	const LIST_TYPE_RECIEVE = 1;
	const LIST_TYPE_ALL     = 2;

	const LIST_SORT_ALL          = 1;
	const LIST_SORT_MINE         = 2;
	const LIST_SORT_FRIEND       = 3;
	const LIST_SORT_COMMENT      = 4;
	const LIST_SORT_MINE_COMMENT = 5;
	const LIST_SORT_TWITTER      = 6;
	const LIST_SORT_TIMELINE     = 7;

	const CHECK_OK           = 200;
	const CHECK_TEMP         = 501;
	const CHECK_ROUTIN       = 500;
	const CHECK_FORBID_WORD  = 273;
	const CHECK_USER_DAYS    = 464;
	const CHECK_USER_FOREVER = 465;

	const FORBID_WORD_TEXT  = 'CONTAINS_FORBID_WORD';
	const BAN_USER_DAYS     = 'BAN_USER_DAYS';
	const BAN_USER_FORERVER = 'BAN_USER_FORERVER';

	/**
	 * Container 서버에 요청한다.
	 * 
	 * @param string $url 요청할 URL, PATH(ex. /message/list.nate)만 넘긴다.
	 * @param array $params {key: value, ...} 형식으로 전달한다.
	 * @param array $forceEnum 한 개짜리 Element 라도 array 로 반환할 태그를 반환한다.
	 * 
	 * @return array XML을 array로 변환하여 반환한다. 에러가 발생할 경우는 false를 반환한다.
	 */
	private static function _sendRequest($url, array $params, array $forceEnum = array(), $isTextPlain = false) /*{{{*/
	{
		// HTTP Request
		$request = new HTTP_Request($url);
		$request->setMethod(HTTP_REQUEST_METHOD_POST);
		foreach ($params as $key=>$val) {
			$request->addPostData($key, $val);
		}

		$request->sendRequest();

		if (self::CHECK_OK != $request->getResponseCode()) {
			trigger_error('ContainerAPI::getMessageList() - API 통신 에러', E_USER_WARNING);
			return false;
		}

		// XML Parsing
		$xml = $request->getResponseBody();
		if ($isTextPlain) {
			return $xml;
		}

		$options      = array(XML_UNSERIALIZER_OPTION_FORCE_ENUM => $forceEnum);
		$unserializer = new XML_Unserializer($options);
		$status       = $unserializer->unserialize($xml);
		if (PEAR::isError($status)) {
			trigger_error('ContainerAPI::getMessageList() - XML 파싱 에러', E_USER_WARNING);
			return false;
		}

		$result = $unserializer->getUnserializedData();

		if (in_array($result['code'], array(self::CHECK_ROUTIN, self::CHECK_TEMP))) {
			$result['inspection_start'] = isset($result['inspection_start']) ? strtotime($result['inspection_start']) : '';
			$result['inspection_stop']  = isset($result['inspection_stop']) ? strtotime($result['inspection_stop']) : '';
		}

		if (self::CHECK_ROUTIN == $result['code']) {
			self::displayRoutinCheck($result['inspection_start'], $result['inspection_stop']);
		}

		if (self::CHECK_TEMP == $result['code']) {
			self::displayTemperCheck($result['inspection_start'], $result['inspection_stop']);
		}

		// 트위터는 연동 없는 경우 438 처리
		if (isset($result['code'])) {
			if ($result['code'] == '438') {
				return false;
			}
		}

		if (isset($result['code']) && $result['code'] != '100') {
			return false;
		}

		// Return Result
		return $result;
	} /*}}}*/

	/**
	 * ********************************************************************************
	 * ************ 메시지 관련 I/F ****************************************************
	 * *********************************************************************************/
	/**
	 * 메시지 목록을 얻어온다.
	 * 
	 * @param User $user 조회하려는 사용자 객체
	 * @param string $startIdx 다음 페이지 시작 ID
	 * @param int $sortType 정렬 타입
	 * @param int $sourceType SOURCE_TYPE_XXX 조회할 소스 타입
	 * @param User $sender 조회할 메시지를 보낸 사용자 객체
	 * @param int $rows 전달 받을 데이터 개수
	 * 
	 * @return array of {messages: array of Messages, nextStartIdx: string}
	 */
	public static function getMessages(User $user, $startIdx = '', $sortType = '', $sourceType = '', $sender = null, $rows = 10) /*{{{*/
	{
		static $sCache = array();

		$key = $user->getUserId() . ':' . $startIdx . ':' . $sortType . ':' . $sourceType . ':' .($sender ? $sender->getUserId() : '') . ':' . $rows;

		if (isset($sCache[$key]) === false) {
			$retval = array(
			    'messages' => array(),
			    'nextStartIdx' => null,
			);

			try {
				// Validate Parameters
				if (in_array($sourceType, array('', Message::SOURCE_TYPE_CONNECT, Message::SOURCE_TYPE_NATEON_CHATNAME, Message::SOURCE_TYPE_EXTERNAL_BLOG, Message::SOURCE_TYPE_CLIPPED)) === false) {
					trigger_error('ContainerAPI::getMessageList() - $sourceType 값이 올바른지 확인 바랍니다.', E_USER_WARNING);
				}

				// Generate Post Data
				$params             = array();
				$params             = self::getSortType($sortType);
				$params['svc_id']   = ConfigManager::get('connecting.container.id');
				$params['svc_pwd']  = ConfigManager::get('connecting.container.pwd');
				$params['user_cmn'] = $user->getUserId();

				if ($startIdx !== '') {
					$params['start_idx'] = $startIdx;
				}
				if ($sourceType !== '') {
					$params['source_type'] = $sourceType;
				}
				if ($sender !== null) {
					$params['sender_cmn'] = $sender->getUserId();
				}

				$params['domain']     = $user->getDomain();
				$params['rows']       = $rows;
				$params['viewer_cmn'] = $user->getUserId();

				// Send Request
				$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/message/list.nate', $params, array('post'));

				if ($result === false) {
					throw new Exception();
				}

				// Generate Return Value
				if (isset($result['next_start_idx'])) {
					$retval['nextStartIdx'] = $result['next_start_idx'];
				}
				if (isset($result['posts']) && isset($result['posts']['post'])) {
					$messages = array();
					foreach ($result['posts']['post'] as $post) {
						$message = Message::instance($post['message_key']);
						$message->setMessageId($post['message_id']);
						$message->setMessage($post['message']);
						$message->setSender(User::instance($post['sender_cmn']));
						$message->setWriterNm($post['writer_nm']);
						$message->setWriteDt(strtotime($post['write_d']));
						$message->setCommentCnt($post['comment_cnt']);
						$message->setCommentDt($post['comment_d'] ? strtotime($post['comment_d']) : 0);
						$message->setProfileType($post['profile_type']);
						$message->setProfileUrl($post['profile_url']);
						$message->setProfileTitle($post['profile_title']);
						$message->setSourceType($post['source_type']);
						$message->setSourceTitle($post['source_title']);
						$message->setSourceUrl($post['source_url']);
						$message->setAttachType($post['attach_type']);
						$message->setAttachUrl($post['attach_url']);
						$message->setFrom($post['from']);
						$message->setOpenYN($post['open_yn']);
						$message->setDomain($post['domain']);
						$message->setNickname($post['nickname']);
						$message->setTwitId($post['twit_id']);
						$message->setMessageKey($post['message_key']);
						$message->setReconnectKey($post['reconnect_key']);
						$message->setOriginMsgId($post['origin_msg_id']);
						$message->setOriginMsgCmn($post['origin_msg_cmn']);
						$message->setOriginMsgWriterNm($post['origin_msg_writer_nm']);


						$originMessage = '';
						if ($post['origin_message'] != '') {
							$originMessage = Message::instance($post['origin_msg_id']);
							$originMessage->setWriterNm($post['origin_message']['writer_nm']);
							$originMessage->setNickname($post['origin_message']['nickname']);
							$originMessage->setDomain($post['origin_message']['domain']);
							$originMessage->setProfileType($post['origin_message']['profile_type']);
							$originMessage->setProfileTitle($post['origin_message']['profile_title']);
							$originMessage->setProfileUrl($post['origin_message']['profile_url']);
							$originMessage->setAttachType($post['origin_message']['attach_type']);
							$originMessage->setAttachUrl($post['origin_message']['attach_url']);
							$originMessage->setSourceTitle($post['origin_message']['source_title']);
							$originMessage->setSourceUrl($post['origin_message']['source_url']);
							$originMessage->setFrom($post['origin_message']['from']);

							if (isset($post['origin_message']['attach_type'])) {
								$message->setAttachType($post['origin_message']['attach_type']);
								$message->setAttachUrl($post['origin_message']['attach_url']);
								$message->setProfileUrl($post['origin_message']['profile_url']);
								$message->setFrom($post['origin_message']['from']);
								$message->setSourceTitle($post['origin_message']['source_title']);
								$message->setSourceUrl($post['origin_message']['source_url']);
							}
						}

						$message->setOriginMessage($originMessage);

						if ($post['attach_type'] == Message::ATTACH_TYPE_CLIPPED_NEWS) {
							$newsInfo = self::getNewsInfo($post['attach_url']);
							$message->setMessage($newsInfo['message']);
							$message->setSourceUrl($newsInfo['source_url']);
							$message->setAttachUrl($newsInfo['attach_url']);
						}

						$messages[] = $message;
					}

					$retval['messages'] = $messages;
				}
			} catch (Exception $e) {
			}

			$sCache[$key] = $retval;
		}

		return $sCache[$key];
	} /*}}}*/

	/**
	 * 전체공개 메시지 목록을 얻어온다
	 * 
	 * @param User $user 조회하려는 사용자 객체
	 * @param string $startIdx 다음 페이지 시작 ID
	 * @param int $rows 전달 받을 데이터 개수
	 * 
	 * @return array of {messages: array of Messages, nextStartIdx: string}
	 */
	public static function getMessagesTimeline(User $user, $startIdx = '', $rows = 10) /*{{{*/
	{
		static $sCache = array();

		$key = $user->getUserId() . ':' . $startIdx . ':' . $rows;

		if (isset($sCache[$key]) === false) {
			$retval = array(
			    'messages' => array(),
			    'nextStartIdx' => null,
			);

			try {
				// Generate Post Data
				$params             = array();
				$params['svc_id']   = ConfigManager::get('connecting.container.id');
				$params['svc_pwd']  = ConfigManager::get('connecting.container.pwd');
				$params['user_cmn'] = $user->getUserId();

				if ($startIdx !== '') {
					$params['start_idx'] = $startIdx;
				}

				$params['rows'] = $rows;

				// Send Request
				$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/message/timeline.nate', $params, array('post'));

				if ($result === false) {
					throw new Exception();
				}

				// Generate Return Value
				if (isset($result['next_start_idx'])) {
					$retval['nextStartIdx'] = $result['next_start_idx'];
				}
				if (isset($result['posts']) && isset($result['posts']['post'])) {
					$messages = array();
					foreach ($result['posts']['post'] as $post) {
						$message = Message::instance($post['message_key']);
						$message->setMessageId($post['message_id']);
						$message->setMessage($post['message']);
						$message->setSender(User::instance($post['sender_cmn']));
						$message->setWriterNm($post['writer_nm']);
						$message->setWriteDt(strtotime($post['write_d']));
						$message->setCommentCnt($post['comment_cnt']);
						$message->setCommentDt($post['comment_d'] ? strtotime($post['comment_d']) : 0);
						$message->setProfileType($post['profile_type']);
						$message->setProfileUrl($post['profile_url']);
						$message->setProfileTitle($post['profile_title']);
						$message->setSourceType($post['source_type']);
						$message->setSourceTitle($post['source_title']);
						$message->setSourceUrl($post['source_url']);
						$message->setAttachType($post['attach_type']);
						$message->setAttachUrl($post['attach_url']);
						$message->setFrom($post['from']);
						$message->setOpenYN($post['open_yn']);
						$message->setDomain($post['domain']);
						$message->setNickname($post['nickname']);
						$message->setTwitId($post['twit_id']);
						$message->setMessageKey($post['message_key']);
						$message->setReconnectKey($post['reconnect_key']);
						$message->setOriginMsgId($post['origin_msg_id']);
						$message->setOriginMsgCmn($post['origin_msg_cmn']);
						$message->setOriginMsgWriterNm($post['origin_msg_writer_nm']);

						$originMessage = '';
						if ($post['origin_message'] != '') {
							$originMessage = Message::instance($post['origin_msg_id']);
							$originMessage->setWriterNm($post['origin_message']['writer_nm']);
							$originMessage->setNickname($post['origin_message']['nickname']);
							$originMessage->setDomain($post['origin_message']['domain']);
							$originMessage->setProfileType($post['origin_message']['profile_type']);
							$originMessage->setProfileTitle($post['origin_message']['profile_title']);
							$originMessage->setProfileUrl($post['origin_message']['profile_url']);
							$originMessage->setAttachType($post['origin_message']['attach_type']);
							$originMessage->setAttachUrl($post['origin_message']['attach_url']);
							$originMessage->setFrom($post['origin_message']['from']);
							$originMessage->setSourceTitle($post['origin_message']['source_title']);
							$originMessage->setSourceUrl($post['origin_message']['source_url']);

							if ($post['origin_message']['attach_type']) {
								$message->setAttachType($post['origin_message']['attach_type']);
								$message->setAttachUrl($post['origin_message']['attach_url']);
								$message->setProfileUrl($post['origin_message']['profile_url']);
								$message->setFrom($post['origin_message']['from']);
								$message->setSourceTitle($post['origin_message']['source_title']);
								$message->setSourceUrl($post['origin_message']['source_url']);
							}
						}

						$message->setOriginMessage($originMessage);

						if ($post['attach_type'] == Message::ATTACH_TYPE_CLIPPED_NEWS) {
							$newsInfo = self::getNewsInfo($post['attach_url']);
							$message->setMessage($newsInfo['message']);
							$message->setSourceUrl($newsInfo['source_url']);
							$message->setAttachUrl($newsInfo['attach_url']);
						}

						$messages[] = $message;
					}

					$retval['messages'] = $messages;
				}
			} catch (Exception $e) {
			}

			$sCache[$key] = $retval;
		}

		return $sCache[$key];
	} /*}}}*/

	/**
	 * 정렬 타입에 따른 파라미터 셋팅
	 * @param string $sortType 리스트 정렬 타입
	 * 
	 * @return array Params
	 */
	public static function getSortType($sortType) /*{{{*/
	{
		$retval = array();

		switch ($sortType) {
			case self::LIST_SORT_ALL:
				$retval['list_type'] = Message::LIST_TYPE_ALL;
				break;

			case self::LIST_SORT_MINE:
				$retval['list_type'] = Message::LIST_TYPE_SENT;
				break;

			case self::LIST_SORT_FRIEND:
				$retval['list_type'] = Message::LIST_TYPE_RECIEVE;
				break;

			case self::LIST_SORT_COMMENT:
				$retval['sort'] = Message::SORT_BY_COMMENT_DT;
				break;

			case self::LIST_SORT_MINE_COMMENT:
				$retval['sort']      = Message::SORT_BY_COMMENT_DT;
				$retval['list_type'] = Message::LIST_TYPE_SENT;
				break;

			case self::LIST_SORT_TWITTER:
				break;

			default:
				break;
		}

		return $retval;
	} /*}}}*/


	/**
	 * 트위터 메시지를 가져온다
	 * @param int $maxId maxid 부터 데이터를 가져온다
	 * @param int $rows  한번에 가져올 데이터 수
	 * 
	 * @return array of twitter data (XML)
	 */
	public static function getTwitterMessages(User $myUser, $maxId = '', $rows = 11) /*{{{*/
	{
		static $sCache = array();

		$key = $myUser->getUserId() . ':' . $maxId . ':' . $rows;

		if (isset($sCache[$key]) === false) {
			$retval = array(
			    'messages' => array(),
			    'nextStartIdx' => null,
			);

			try {
				// Generate Post Data
				$params             = array();
				$params['svc_id']   = ConfigManager::get('connecting.container.id');
				$params['svc_pwd']  = ConfigManager::get('connecting.container.pwd');
				$params['user_cmn'] = $myUser->getUserId();

				if ($maxId !== '') {
					$params['max_id'] = $maxId;
				}
				$params['rows'] = $rows;

				// Send Request
				$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/twitter/homeTimeLine.nate', $params, array());
				if ($result === false) {
					throw new Exception();
				}

				if (isset($result['statuses']) && isset($result['statuses']['status'])) {
					$messages = array();

					foreach ($result['statuses']['status'] as $post) {
						if (strlen($post['id'] < 10)) {
							continue;
						}
						$message = Message::instance($post['id'].','.$post['id']);
						$message->setMessageId($post['id']);
						$message->setMessage($post['text']);
						$message->setSender(User::instance($myUser->getUserId()));
						$message->setWriterNm($post['user_name']);
						$message->setWriteDt(strtotime($post['created_d'])-60*60);
						$message->setCommentCnt($post['comment_cnt']);
						$message->setCommentDt(0);
						$message->setProfileType(9);
						$message->setProfileUrl($post['profile_image']);
						$message->setSourceType('');
						$message->setSourceTitle('');
						$message->setSourceUrl('');
						$message->setAttachType('');
						$message->setAttachUrl('');
						$message->setFrom(Message::FROM_TWITTER);
						$message->setOpenYN('y');
						$message->setDomain($myUser->getDomain());
						$message->setNickname($myUser->getNickname());
						$message->setTwitId($post['twitter_url']);
						$message->setReconnectKey($post['id'].','.$post['id']);
						$message->setOriginMsgId('');
						$message->setOriginMsgCmn('');
						$message->setOriginMsgWriterNm('');

						$retval['nextStartIdx'] = $post['id'];
						$messages[]             = $message;
					}

					$retval['messages'] = $messages;

					if ($maxId && count($messages)) {
						array_shift($messages);
						$retval['messages'] = $messages;
					}

					if (strlen($post['id'] < 10)) {
						$retval['nextStartIdx'] = '';
					}
				}
			} catch (Exception $e) {
			}

			$sCache[$key] = $retval;
		}

		return $sCache[$key];
	} /*}}}*/

	/**
	 * 메시지를 등록한다.
	 * 
	 * @param Message $message 등록할 메시지 객체
	 * 
	 * @return bool 성공할 경우 true 를 반환한다.
	 */
	public static function addMessage(User $myUser, Message $message, $sendTwitter, $msgOpenDefault = Message::MSG_OPEN_DEFAULT_Y) /*{{{*/
	{
		// Generate Post Data
		$params                     = array();
		$params['svc_id']           = ConfigManager::get('connecting.container.id');
		$params['svc_pwd']          = ConfigManager::get('connecting.container.pwd');
		$params['user_cmn']         = $myUser->getUserId();
		$params['sender_cmn']       = $myUser->getUserId();
		$params['message']          = $message->getMessage();
		$params['profile_type']     = $message->getProfileType();
		$params['open_yn']          = $message->getOpenYN();
		$params['msg_open_default'] = $msgOpenDefault;
		$params['send_twitter']     = $sendTwitter;

		// Send Request
		$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/message/add.nate', $params, array(), true);
		if ($result === false) {
			return $retval;
		}

		if (trim($result) == '100 SUCCESS') {
			return true;
		} elseif (eregi(self::CHECK_FORBID_WORD, $result)) {
			return trim($result);
		} elseif (eregi(self::CHECK_USER_DAYS, $result)) {
			return self::CHECK_USER_DAYS;
		} elseif (eregi(self::CHECK_USER_FOREVER, $result)) {
			return self::CHECK_USER_FOREVER;
		} else {
			return false;
		}
	} /*}}}*/

	/**
	 * 메시지를 삭제한다.
	 * 
	 * @param Message $message 삭제할 메시지 객체
	 * 
	 * @return bool 성공할 경우 true 를 반환한다.
	 */
	public static function deleteMessage(Message $message) /*{{{*/
	{
		// Generate Post Data
		$params                = array();
		$params['svc_id']      = ConfigManager::get('connecting.container.id');
		$params['svc_pwd']     = ConfigManager::get('connecting.container.pwd');
		$params['message_key'] = $message->getMessageKey();
		$params['user_cmn']    = $message->getSender()->getUserId();

		// Send Request
		$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/message/delete.nate', $params, array(), true);
		if ($result === false) {
			return $retval;
		}

		if (trim($result) == '100 SUCCESS') {
			return true;
		}
		else {
			return false;
		}
	} /*}}}*/

	/**
	 * 메시지 리커넥팅.
	 * 
	 * @param Message $message 삭제할 메시지 객체
	 * 
	 * @return bool 성공할 경우 true 를 반환한다.
	 */
	public static function reconnect(User $user, Message $message) /*{{{*/
	{
		// Generate Post Data
		$params                  = array();
		$params['svc_id']        = ConfigManager::get('connecting.container.id');
		$params['svc_pwd']       = ConfigManager::get('connecting.container.pwd');
		$params['reconnect_key'] = $message->getReconnectKey();
		$params['comment']       = $message->getComment();
		$params['user_cmn']      = $user->getUserId();
		$params['nate_id']       = $user->getNateId();
		$params['sender_name']   = $user->getRealname();

		// Send Request
		$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/message/reconnect.nate', $params, array(), true);

		if ($result === false) {
			return $retval;
		}

		if (trim($result) == '100 SUCCESS') {
			return true;
		} elseif (eregi(self::CHECK_FORBID_WORD, $result)) {
			return trim($result);
		} elseif (eregi(self::CHECK_USER_DAYS, $result)) {
			return self::CHECK_USER_DAYS;
		} elseif (eregi(self::CHECK_USER_FOREVER, $result)) {
			return self::CHECK_USER_FOREVER;
		} else {
			return false;
		}
	} /*}}}*/

	/**
	 * 댓글 목록을 읽어온다.
	 * 
	 * @param Message $message 이 메시지의 댓글을 읽어온다.
	 * @param string $mode 등록 방식 - 일반 댓글/재댓글, 트위터 댓글
	 * @param int $page 페이지 번호
	 * 
	 * @return array of {comments: array of Comment, totalPages: int, totalComments: int}
	 */
	public static function getComments(Message $message, User $myUser, $mode = Comment::COMMENT_TYPE_RECOMMENT, $page = -1) /*{{{*/
	{
		$retval = array(
		    'comments' => array(),
		    'totalPages' => 1,
		    'totalComments' => 0,
		);

		// Validate Parameters
		if ($page <= 0 && $page != -1) {
			$page = -1;
		}

		// 기본값은 재댓글
		if ($mode == '') {
			$mode = Comment::COMMENT_TYPE_RECOMMENT;
		}

		// Generate Post Data
		$params                = array();
		$params['svc_id']      = ConfigManager::get('connecting.container.id');
		$params['svc_pwd']     = ConfigManager::get('connecting.container.pwd');
		$params['user_cmn']    = $myUser->getUserId();
		$params['message_key'] = $message->getMessageKey();
		$params['page']        = $page;
		$params['mode']        = $mode;
		$params['rows']        = 30;

		// Send Request
		$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/comment/list.nate', $params, array('comment'));

		if ($result === false) {
			return $retval;
		}

		// Generate Return Value
		if (isset($result['totalPages'])) {
			$retval['totalPages'] = $result['totalPages'];
		}
		if (isset($result['totalComments'])) {
			$retval['totalComments'] = $result['totalComments'];
		}
		if (isset($result['comments']) && isset($result['comments']['comment'])) {
			$comments = array();
			foreach ($result['comments']['comment'] as $item) {
				$comment = Comment::instance($item['comment_key']);
				$comment->setCommentId($item['comment_id']);
				$comment->setContent($item['content']);
				$comment->setMessage($message);
				$comment->setWriter(User::instance($item['cmn']));
				$comment->setWriteDt(strtotime($item['write_d']));
				$comment->setWriterNm($item['writer_nm']);
				$comment->setNickname($item['nickname']);
				$comment->setIsSecret($item['is_secret']);
				$comment->setDomain($item['domain']);
				$comment->setNickname($item['nickname']);
				$comment->setParentId($item['parent_id']);
				$comment->setDeletedYN($item['deleted_yn']);
				$comment->setVisible($item['visible']);
				$comment->setProfileTitle($item['profile_title']);

				$comments[] = $comment;
			}

			$retval['comments'] = $comments;
		}

		return $retval;
	} /*}}}*/

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
	 * 댓글을 삭제한다.
	 * 
	 * @param Comment $comment 삭제할 댓글 객체
	 * @param User $myUser 삭제 요청한 사용자의 객체
	 * @param string $mode 트위터 댓글 삭제, 일반 댓글 삭제 모드
	 * 
	 * @return bool 성공할 경우 true 를 반환한다.
	 */
	public static function deleteComment(Comment $comment, User $myUser, $mode) /*{{{*/
	{
		// Generate Post Data
		$params                = array();
		$params['svc_id']      = ConfigManager::get('connecting.container.id');
		$params['svc_pwd']     = ConfigManager::get('connecting.container.pwd');
		$params['user_cmn']    = $myUser->getUserId();
		$params['message_key'] = $comment->getMessage()->getMessageKey();
		$params['comment_key'] = $comment->getCommentKey();
		$params['mode']        = $mode;

		// Send Request
		$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/comment/delete.nate', $params, array(), true);
		if ($result === false) {
			return $retval;
		}

		if (trim($result) == '100 SUCCESS') {
			return true;
		}
		else {
			return false;
		}
	} /*}}}*/

	/**
	 * 댓글을 추가한다.
	 * 
	 * @param Message $message 댓글을 추가할 커넥팅 객체
	 * @param User $user 유저 객체
	 * @param string $content 댓글 내용
	 * @param int $isSecret 비밀글 여부
	 * @param string $mode 등록 방식 - 일반 댓글/재댓글, 트위터 댓글
	 * @param int $parentId 재댓글 등록시 키값 
	 * @param string $twitId 트위터 댓글 등록시 사용하는 스크린 네임 
	 * 
	 * @return bool 성공할 경우 true 를 반환한다.
	 */
	public static function addComment(Message $message, User $myUser, $content, $isSecret, $mode, $twitId = '', $parentId) /*{{{*/
	{
		// Generate Post Data
		$params                = array();
		$params['svc_id']      = ConfigManager::get('connecting.container.id');
		$params['svc_pwd']     = ConfigManager::get('connecting.container.pwd');
		$params['message_key'] = $message->getMessageKey();
		$params['user_cmn']    = $myUser->getUserId();
		$params['is_secret']   = $isSecret ? '1' : '0';
		$params['comment']     = $content;
		$params['sender_cmn']  = $myUser->getUserId();
		$params['sender_name'] = $myUser->getRealname();
		$params['parent_id']   = $parentId;
		$params['mode']        = $mode;
		$params['twit_id']     = $twitId;

		// Send Request
		$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/comment/add.nate', $params, array(), true);

		if ($result === false) {
			return false;
		}

		if (trim($result) == '100 SUCCESS') {
			return true;
		} elseif (eregi(self::CHECK_FORBID_WORD, $result)) {
			return trim($result);
		} elseif (eregi(self::CHECK_USER_DAYS, $result)) {
			return self::CHECK_USER_DAYS;
		} elseif (eregi(self::CHECK_USER_FOREVER, $result)) {
			return self::CHECK_USER_FOREVER;
		}
		else {
			return false;
		}
	} /*}}}*/

	/**
	 * 유저 정보 v 2.0
	 * 
	 * @param User   $user		유저 객체
	 * 
	 * @return data 컨테이너 응답 xml
	 */
	public static function getUserInfo(User $user) /*{{{*/
	{
		static $sCache = array();
		if (isset($sCache[$user->getUserId()]) === false) {
			try {
				// Generate Post Data
				$params             = array();
				$params['svc_id']   = ConfigManager::get('connecting.container.id');
				$params['svc_pwd']  = ConfigManager::get('connecting.container.pwd');
				$params['user_cmn'] = $user->getUserId();
				$params['domain']   = $user->getDomain();
				$params['nickname'] = $user->getNickname();

				// Send Request
				$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/member/show.nate', $params, array(), false);

				if ($result === false) {
					throw new Exception();
				}

				$profile = $result['profile'];
				$user->setUserId($user->getUserId());
				$user->setDomain($profile['domain']);
				$user->setNickname($profile['nickname']);
				$user->setProfileImage($profile['profile_image']);
				$user->setProfileImageUrl($profile['profile_image_url']);
				$user->setProfileThumbnailUrl($profile['profile_thumbnail_url']);
				$user->setFollowerCnt($profile['follower_cnt']);
				$user->setFollowingCnt($profile['following_cnt']);
				$user->setFriendCnt($profile['friend_cnt']);
				$user->setReverseFriendCnt($profile['r_friend_cnt']);
				$user->setMsgCnt($profile['msg_cnt']);
				$user->setToastYN($profile['toast_yn']);
				$user->setMsgOpenDefault($profile['msg_open_default']);
				$user->setCreatDt($profile['create_d']);
				$user->setIsTempDomain($profile['is_temp_domain']);
				$user->setIsDomainOwner($profile['is_domains_owner']);
				$user->setIsShowTwits($profile['is_show_twits']);
				$user->setShowNickname($profile['show_nickname']);
				$user->setPrivateMsgCnt($profile['private_msg_cnt']);
				$user->setIntroduce($profile['introduce']);
			} catch (Exception $e) {
			}

			$sCache[$user->getUserId()] = $user;
		}

		return $sCache[$user->getUserId()];
	} /*}}}*/

	/**
	 * 사용자 토스트 사용여부  업데이트
	 */
	public static function updateToast(User $myUser) /*{{{*/
	{
		try {
			$params             = array();
			$params['svc_id']   = ConfigManager::get('connecting.container.id');
			$params['svc_pwd']  = ConfigManager::get('connecting.container.pwd');
			$params['user_cmn'] = $myUser->getUserId();
			$params['id']       = $myUser->getNateId();
			$params['name']     = $myUser->getRealname();
			$params['toast_yn'] = $myUser->getToastYN();

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/member/updateToast.nate', $params, array('post'), true);

			if ($result === false) {
				return false;
			}

			if (trim($result) == '100 SUCCESS') {
				return true;
			} else {
				return false;
			}
		} catch (Exception $e) {
			return false;
		}
	} /*}}}*/

	/**
	 * 사용자 정보 업데이트
	 */
	public static function updateUserInfo(User $myUser) /*{{{*/
	{
		try {
			$params                  = array();
			$params['svc_id']        = ConfigManager::get('connecting.container.id');
			$params['svc_pwd']       = ConfigManager::get('connecting.container.pwd');
			$params['user_cmn']      = $myUser->getUserId();
			$params['id']            = $myUser->getNateId();
			$params['domain']        = $myUser->getDomain();
			$params['nickname']      = $myUser->getNickname();
			$params['name']          = $myUser->getRealname();
			$params['profile_image'] = $myUser->getProfileImage();
			$params['toast_yn']      = $myUser->getToastYN();
			$params['introduce']     = $myUser->getIntroduce();
			$params['show_nickname'] = $myUser->getShowNickname();

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/member/update.nate', $params, array('post'), true);

			if ($result === false) {
				return false;
			}

			if (trim($result) == '100 SUCCESS') {
				return true;
			} else {
				return false;
			}
		} catch (Exception $e) {
			return false;
		}
	} /*}}}*/

	/**
	 * 첫방문 여부
	 */
	public static function isFirstVisit(User $user) /*{{{*/
	{
		static $sCache = array();
		if (isset($sCache[$user->getUserId()]) === false) {
			try {
				// Generate Post Data
				$params             = array();
				$params['svc_id']   = ConfigManager::get('connecting.container.id');
				$params['svc_pwd']  = ConfigManager::get('connecting.container.pwd');
				$params['user_cmn'] = $user->getUserId();
				$params['mode']     = 2;

				// Send Request
				$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/member/status.nate', $params, array(), true);
				if ($result === false) {
					throw new Exception();
				}

				$firstVisit = explode(chr(10), $result);

				if (trim($firstVisit[0]) == '100 SUCCESS') {
					return $firstVisit[1] ? 0 : 1;
				}

				return false;
			} catch (Exception $e) {
			}

			$sCache[$user->getUserId()] = $result;
		}

		return $sCache[$user->getUserId()];
	} /*}}}*/


	/**
	 * 블로그 연동 리스트
	 * 
	 * @param User $user 유저객체
	 * 
	 * @return  결과 블로그 연동리스트
	 */
	public static function getLinkedBlogs(User $user) /*{{{*/
	{
		try {
			$params             = array();
			$params['svc_id']   = ConfigManager::get('connecting.container.id');
			$params['svc_pwd']  = ConfigManager::get('connecting.container.pwd');
			$params['user_cmn'] = $user->getUserId();

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/twitter/check.nate', $params, array('post'));

			if ($result === false) {
				return false;
			}

			if ($result['code'] != '100') {
				return false;
			}
			else {
				if ($result['memberBlog'] == false) {
					return false;
				}

				$extBlogs = array();

				if ($result['totalCounts'] > 1) {
					foreach ($result['memberBlog']['row'] as $row) {
						$extBlog = ExtBlog::instance($row['blog_id']);
						$extBlog->setBlogNm($row['blog_name']);

						$extBlogs[] = $extBlog;
					}
				} elseif (count($result['totalCounts']) == 1) {
					$extBlog = ExtBlog::instance($result['memberBlog']['row']['blog_id']);
					$extBlog->setBlogNm($result['memberBlog']['row']['blog_name']);

					$extBlogs[] = $extBlog;
				} else {
					return false;
				}

				return $extBlogs;
			}
		} catch (Exception $e) {
			return false;
		}
	} /*}}}*/

	/**
	 * 최근 3일 나의 친구, 역친구, follower 수 조회 - 말풍선 보기
	 * @param User $user 유저객체
	 * 
	 * @return xml data
	 */
	public static function balloonView(User $user) /*{{{*/
	{
		// Generate Post Data
		$params             = array();
		$params['svc_id']   = ConfigManager::get('connecting.container.id');
		$params['svc_pwd']  = ConfigManager::get('connecting.container.pwd');
		$params['user_cmn'] = $user->getUserId();

		// Send Request
		$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/balloon/view.nate', $params, array(), false);

		if ($result === false) {
			throw new Exception();
		}


		if ($result['code'] != '100') {
			return false;
		}

		if ($result['balloon']['follower_cnt'] == false) {
			$result['balloon']['follower_cnt'] = 0;
		}
		if ($result['balloon']['r_friend_cnt'] == false) {
			$result['balloon']['r_friend_cnt'] = 0;
		}

		return $result['balloon'];
	} /*}}}*/

	/**
	 * 말풍선 확인
	 * 
	 * @param User $user 유저객체
	 * @param int $balloonType follower, 역친구 옵션
	 * 
	 * @return plain text 결과 텍스트
	 */
	public static function balloonCheck(User $user, $balloonType) /*{{{*/
	{
		try {
			$params                 = array();
			$params['svc_id']       = ConfigManager::get('connecting.container.id');
			$params['svc_pwd']      = ConfigManager::get('connecting.container.pwd');
			$params['user_cmn']     = $user->getUserId();
			$params['balloon_type'] = $balloonType;

			$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/v2/balloon/check.nate', $params, array('post'), true);

			if ($result === false) {
				return false;
			}

			if (trim($result) == '100 SUCCESS') {
				return true;
			}
			else {
				return false;
			}
		} catch (Exception $e) {
			return false;
		}
	} /*}}}*/

	/**
	 * 단축 URL
	 * @param string $url URL
	 * 
	 * @return xml data
	 */
	public static function shortenUrl(User $user, $url) /*{{{*/
	{
		// Generate Post Data
		$params             = array();
		$params['svc_id']   = ConfigManager::get('connecting.container.id');
		$params['svc_pwd']  = ConfigManager::get('connecting.container.pwd');
		$params['user_cmn'] = $user->getUserId();
		$params['url']      = $url;
		$params['service']  = 'zulim';

		// Send Request
		$result = self::_sendRequest(ConfigManager::get('connecting.container.url').'/url/shorten.nate', $params, array(), true);

		if ($result === false) {
			throw new Exception();
		}

		if (strstr($result, '100 SUCCESS')) {
			$string = str_replace("100 SUCCESS\n", '', $result);
			return $string;
		}
		else {
			return false;
		}
	} /*}}}*/
	/**
	 * 정기점검 페이지
	 */
	public static function displayRoutinCheck($startDt, $endDt) /*{{{*/
	{
		echo "<script>
				top.location.replace('/routinCheck?startTime=" . $startDt . '&endTime=' . $endDt . "');
			  </script>";
		exit;
	} /*}}}*/

	/**
	 * 임시점검 페이지
	 */
	public static function displayTemperCheck($startDt, $endDt) /*{{{*/
	{
		echo "<script>
				top.location.replace('/temperCheck?startTime=" . $startDt . '&endTime=' . $endDt . "');
			  </script>";
		exit;
	} /*}}}*/
}
?>