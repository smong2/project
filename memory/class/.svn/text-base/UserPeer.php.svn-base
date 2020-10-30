<?php
class UserPeer
{
	/**
	 * Nate ID 를 가지고 Nate 회원정보를 가져온 후 User 객체를 반환한다.
	 */
	public static function retrieveNateInfoByUserId($nateId) /*{{{*/
	{
		if (Podo_Util_String::endsWith($nateId, '@nate.com')) {
			$nateId = substr($nateId, 0, -9);
		}

		$req = new Memory_HTTP_Request('http://192.168.193.93/nate/getNateInfo.jsp');
		$req->setMethod(HTTP_REQUEST_METHOD_GET);
		$req->addQueryString('keytype',   'ID');
		$req->addQueryString('key',       $nateId);
		$req->addQueryString('cp_code',   'memory');
		$req->addQueryString('cp_passwd', 'dourmb');
		$req->sendRequest();

		$resCode = $req->getResponseCode();
		if ($resCode != 200) {
			return null;
		}

		$resBody = $req->getResponseBody();

		$dom = new DOMDocument;
		if ($dom->loadXML($resBody) === false) {
			return null;
		}

		$xpath = new DOMXPath($dom);
		$nodes = $xpath->query('//ResultInfo/@error_code');

		if ($nodes->item(0)->value != 1) {
			return null;
		}

		$nodes = $xpath->query('//ResultInfo/UserInfo');
		$userInfoNode = $nodes->item(0);

		$nateInfo = array();
		foreach ($userInfoNode->childNodes as $childNode) {
			$nateInfo[$childNode->tagName] = $childNode->textContent;
		}

		$user = User::instance($nateInfo['SVC_INST_NO']);
		$user->nate->setNateId($nateInfo['SVC_ID']);
		$user->nate->setMail($nateInfo['EMAIL_ADDR']);
		$user->setGender($nateInfo['SEX_CD']);
		$user->setBirthday($nateInfo['BIRTHDAY']);
		$user->setlunar($nateInfo['BIRTHDAY_TYPE']);
		$user->setRealName($nateInfo['CUST_NM']);

		return $user;
	} /*}}}*/

	public function retrieveUser() /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT user_id, insert_dt, nick_enable_fl, nickname, homepage_link_fl, homepage, view_per_page, profile_image
					 FROM user WHERE user_id = :user_id';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':user_id', $this->myUser->getUserId(), PDO::PARAM_STR);
		$stmt->execute();

		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			// 값이 있다면 가져오고
			$retval = ConfigUser::instance($row['user_id']);
			$retval->setInsertDt(date('Y년 m월 d일', strtotime($row['insert_dt'])));

			$datediff = floor((time()-strtotime($row['insert_dt']))/86400); // 기억일을 기준으로 몇일째인지 찾자

			if ($datediff) {
				$datediff = '(오늘은 ' . $datediff . '일째)';
			} // 포맷을 만들고
			else {
				$datediff = '(오늘)';
			} // 값이 없으면 공란

			$retval->setDateDiff($datediff); // 완성된 데이터를 넘긴다
			$retval->setNickEnableFl($row['nick_enable_fl']);
			$retval->setNickName($row['nickname']);
			$retval->setHomepageLinkFl($row['homepage_link_fl']);
			$retval->setHomepage($row['homepage']);
			$retval->setViewPerPage($row['view_per_page']);
			$retval->setProfileImage($row['profile_image']);
		} else {
			// 저장된 값이 없다면 초기값을 넣어서 불러온다
			$retval = ConfigUser::instance($this->myUser->getUserId());
			$retval->setInsertDt('기억한 데이터가 없습니다');
			$retval->setDateDiff('');
			$retval->setNickEnableFl('');
			$retval->setNickName($this->myUser->getRealName());
			$retval->setHomepageLinkFl('');
			$retval->setHomepage('');
			$retval->setviewPerPage(5);
			$retval->setProfileImage('about:blank');
		}
		return $retval;
	} /*}}}*/
}
?>
