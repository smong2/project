<?php
class FileUploader
{
	// HTTP_Request #2
	public static function upload($upfile, $userid, $imageExt) /*{{{*/
	{
		// 디렉토리 명 만들기
		$wholepath = "/data/fs/memory/profile/";

		$dirname = ConfigUserPeer::directoryName($userid);

		$fileNm = date("Ymd_his").".".$imageExt;
		$dirpath = $wholepath . $dirname."/".$fileNm;

 		if (file_exists(dirname($dirpath)) === false) {
            $createResult = mkdir(dirname($dirpath), 0777, true);
            //Logger::debug("생성 성공 실패여부 : " . $cresult);
            if(!$createResult) {
            	echo('<br>Create directory error<br>'.dirname($dirpath));
					exit;
            }
      }

		$url = "http://".ConfigManager::get('FileUploader.host');
		$req = new HTTP_Request("$url/uploader/put", array('timeout' => 10, 'readTimeout' => array(5, 0)));
		$req->setMethod(HTTP_REQUEST_METHOD_POST);

		$result = $req->addFile('file00', $upfile["tmp_name"]); // temperary filename
		$req->addPostData("dirpath",$dirpath,true); // fullpath
		$req->addPostData("fileNm",$fileNm,true); // 시간으로 정의된 파일명

		$response = $req->sendRequest();

		// 정상적으로 업로드 되고 리턴이 왔다면?
		if($response) {
			echo "<script>opener.$('pre_profile_img').value='$fileNm';self.close();</script>";
			return $fileNm;
		} else {
			echo "<script>self.close();</script>";
			return 0;
		}
	}
}
?>
