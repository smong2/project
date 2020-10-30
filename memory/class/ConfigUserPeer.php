<?php
class ConfigUserPeer
{
	public static $perPage = array('5', '10', '20', '30'); // 페이지별 리스트 수 배열 값

	/**
	 * 닉네임 중복 체크 (닉네임, NateId)
	 */
	public static function duplicateCheck($nick_name, $userId) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT COUNT(nickname) AS nickcnt
					 FROM user WHERE user_id <> :user_id AND
					 					  nickname = :nickname';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':user_id',  $userId, PDO::PARAM_STR);
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

	/**
	 * 디렉토리명 결정 12-/34-/56-/78-/90-/1234567890
	*/
	public static function directoryName($userId) {
		$dirname="";
		for($i=1;$i<=10;$i++) {
			$dirname.= $userId[($i-1)];
			if(($i%2)==0) {
				$dirname .=	"-/";
			}
		}

		return $dirname.$userId;
	}

	/*{{{*/
	/*
	public function modifyProfileImage()

	{
		// 1. 새로운 프로필 사진을 업로드
		$img = $_FILES['file00'];

		//  사진이 있다면 업로드
		if ($img['size'] > 0) {
			// 확장자 가져오기 $fileType
			$fileType = explode(".",$img["name"]);
			$fileType = $fileType[1];

		// 사진 파일명 - 일단 올리면 tmp header가 붙는다. 최종 확인 버튼 클릭시 tmp header가 빠져서 DB에 Update된다.
			$upfileResult = move_uploaded_file($img['tmp_name'], ConfigManager::get('common.basedir').'/docroot/imgProfile/'.iconv('euc-kr', 'utf-8', "tmp".$this->myUser->getUserId().".$fileType"));

			// 업로드 성공시 임시 파일명 Return 실패시 0 return
			if($upfileResult) {
				return "tmp".$this->myUser->getUserId().".".$fileType;
			} else {
				return 0;
			}
		} else {
			return 0;
		}
	}
	*/
	/*}}}*/

}
?>
