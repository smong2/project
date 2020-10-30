<?php
class ConfigUserPeer
{
	/*}}}*/
	// 기본설정에 저장된 사용자 정보 가져오기
	public function retrieveUserById() /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT user_id, insert_dt, nick_enable_fl, nickname, homepage_link_fl, homepage, view_per_page, profile_image
					 FROM user WHERE user_id = :user_id';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':user_id', $this->myUser->getUserId(), PDO::PARAM_STR);
		$stmt->execute();

		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			// 값이 있다면 가져오고
			$retvals = ConfigUser::instance($row['user_id']);
			$retvals->setInsertDt(date('Y년 m월 d일', strtotime($row['insert_dt'])));

			$datediff = floor((time()-strtotime($row['insert_dt']))/86400); // 기억일을 기준으로 몇일째인지 찾자

			if ($datediff) {
				$datediff = '(오늘은 ' . $datediff . '일째)';
			} // 포맷을 만들고
			else {
				$datediff = '(오늘)';
			} // 값이 없으면 공란

			$retvals->setDateDiff($datediff); // 완성된 데이터를 넘긴다
			$retvals->setNickEnableFl($row['nick_enable_fl']);
			$retvals->setNickName($row['nickname']);
			$retvals->setHomepageLinkFl($row['homepage_link_fl']);
			$retvals->setHomepage($row['homepage']);
			$retvals->setViewPerPage($row['view_per_page']);
			$retvals->setProfileImage($row['profile_image']);
		} else {
			// 저장된 값이 없다면 초기값을 넣어서 불러온다
			$retvals = ConfigUser::instance($this->myUser->getUserId());
			$retvals->setInsertDt('기억한 데이터가 없습니다');
			$retvals->setDateDiff('');
			$retvals->setNickEnableFl('');
			$retvals->setNickName($this->myUser->getRealName());
			$retvals->setHomepageLinkFl('');
			$retvals->setHomepage('');
			$retvals->setviewPerPage(5);
			$retvals->setProfileImage('about:blank');
		}
		return $retvals;
	} /*}}}*/

	// 닉네임 중복 체크
	public function duplicateCheck($nick_name) /*{{{*/
	{
		if (!strlen($nick_name)) {
			echo "<script>alert(\"닉네임을 입력해주십시오\");opener.$(\"nick_name\").focus();self.close();</script>";
			return 0;
		}

		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT COUNT(nickname) AS nickcnt
					 FROM user WHERE user_id <> :user_id AND
					 					  nickname = :nickname';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':user_id',  $this->myUser->getUserId(), PDO::PARAM_STR);
		$stmt->bindValue(':nickname', $nick_name,                 PDO::PARAM_STR);

		$stmt->execute();

		// 없으면 알아서 $cnt에 0을 찍어주므로 초기화 안함
		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$cnt = $row['nickcnt'];
		}

		if (!$cnt) {
			return 1;
		} else {
			return 0;
		}
	} /*}}}*/

	// 기본 설정 데이터 추가/수정
	public function modifyBasic($nickFl, $nickName, $homepageLinkFl, $homepageText, $perPage) /*{{{*/
	{
		// Data Insert를 위한 initializing
		if ($nickFl == 'on') {
			$nickFl = 1;
		} else {
			$nickFl = 0;
		}

		if ($homepageLinkFl == 'on') {
			$homepageLinkFl = 1;
		} else {
			$homepageLinkFl = 0;
		}

		// 닉네임을 사용하지 않거나 닉네임 필드가 공백이라면 실명으로 넣는다
		if (!$nickFl || !strlen($nickName)) {
			$nickName = $this->myUser->getRealName();
		}

		$pdo = PDO_Manager::getMemoryDB();

		// 우선 insert된 데이터가 있는지 확인 - count로 세지 않고 ID로 세도록 했음
		$query = 'SELECT user_id
					 FROM user
					 WHERE user_id = :user_id';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':user_id', $this->myUser->getUserId(), PDO::PARAM_STR);
		$stmt->execute();

		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			// 자료가 있으면 Update
			$query = 'UPDATE user
						 SET nick_enable_fl = :nick_enable_fl,
						 	  nickname = :nickname,
						 	  homepage = :homepage,
						 	  homepage_link_fl = :homepage_link_fl,
						 	  view_per_page = :view_per_page
						 WHERE user_id= :user_id';
		} else {
			// 자료가 없으면 Insert
			$query = 'INSERT INTO user
					 		(user_id, homepage, homepage_link_fl, nickname, nick_enable_fl,
					 		 view_per_page)
					 	 VALUES
					 		(:user_id, :homepage, :homepage_link_fl, :nickname, :nick_enable_fl, :view_per_page)';
		}

		$stmt = $pdo->prepare($query);
		$stmt->bindValue(':nick_enable_fl',   $nickFl,                    PDO::PARAM_INT);
		$stmt->bindValue(':nickname',         $nickName,                  PDO::PARAM_STR);
		$stmt->bindValue(':homepage_link_fl', $homepageLinkFl,            PDO::PARAM_INT);
		$stmt->bindValue(':homepage',         $homepageText,              PDO::PARAM_STR);
		$stmt->bindValue(':view_per_page',    $perPage,                   PDO::PARAM_INT);
		$stmt->bindValue(':user_id',          $this->myUser->getUserId(), PDO::PARAM_STR);
		$stmt->execute();
	} /*}}}*/

	public function modifyProfileImage()
	{
		/*
		Process
		1. 기존 프로필 사진이 있는지 검사
		   -> 기존 프로필 사진은 tid-사용자파일명.(jpg, gif, png) 로 구성
		2. 있다면 기존 프로필 사진을 삭제
		3. 새로운 프로필 사진을 업로드
		4. 부모 페이지 새로고침 그리고 팝업창 닫기 */

		// 1. 기존 프로필 사진이 있는지 검사
		$usrIdStr = ConfigUserPeer::retrieveUserById();
		$imgFileName = $usrIdStr->getProfileImage();

		// 2.만일 이미지 파일이 있다면 삭제해야지
		if(strcmp($imgFileName,"about:blank") && strlen($imgFileName)>0) {
			$fileDelOk=1; //파일이 존재하지 않는 경우 unlink의 값은 0이다. 따라서 기본값을 1로 준다.

			// 파일이 존재한다면 삭제 프로세스를 작동시키고
			if(file_exists(ConfigManager::get("common.basedir")."/docroot/imgProfile/".trim($imgFileName))) {
				$fileDelOk = unlink(ConfigManager::get("common.basedir")."/docroot/imgProfile/".trim($imgFileName));
			}

			// 삭제 프로세스에서 파일 삭제 실패시 실패라는 안내 메시지가 출력된다.
			// 이 항목은 User들에게 보여주지 말고 로그로 남겨두면 편리할 듯
			if(!$fileDelOk) {
				echo "<script>alert('기존 파일 삭제 실패');</script>";
			}
		}

		// 3. 새로운 프로필 사진을 업로드
		$img = $_FILES['file00'];

		//  사진이 있다면 업로드 하고 Table에 파일명 입력
		if($img['size']>0){
			move_uploaded_file($img['tmp_name'], ConfigManager::get("common.basedir").'/docroot/imgProfile/'.iconv("euc-kr","utf-8",$this->myUser->getUserId()."-".$img['name']));
			ConfigUserPeer::modifyProfileImageProc(iconv("euc-kr","utf-8",$this->myUser->getUserId()."-".$img["name"]));
		}

		// 4.부모 페이지 새로고침 그리고 팝업창 닫기
			echo "<script>
						opener.location.reload();
						self.close();
					</script>";
	}

	public function modifyProfileImageProc($profile_image)
	{
		$pdo = PDO_Manager::getMemoryDB();

		// 우선 insert된 데이터가 있는지 확인 -	 count로 세지 않고 ID로 세도록 했음
		$query = 'UPDATE user
					 SET profile_image = :profile_image
					 WHERE user_id = :user_id';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':user_id', $this->myUser->getUserId(), PDO::PARAM_STR);
		$stmt->bindValue(':profile_image', $profile_image, PDO::PARAM_STR);
		$stmt->execute();
	}

	// 페이지별 리스트 수 배열 값
	public static $perPage = array('5', '10', '20', '30');
}
?>
