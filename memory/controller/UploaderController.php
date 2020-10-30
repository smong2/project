<?php
class UploaderController extends Podo_Controller_Base
{
	public function __preProcessor() /*{{{*/
	{
		if (Podo_Util_String::startsWith($_SERVER['REMOTE_ADDR'], array('124.136.', '192.168.', '172.18.', '10.131.','127.0.0')) === false) {
			echo $_SERVER['REMOTE_ADDR'];
			exit;
		}
	} /*}}}*/

	// HTTP_Request #3 <- 프로필 이미지 업로드
	public function doPut() /*{{{*/
	{
		$r_f = $this->request->getFile('file00');

		$result = move_uploaded_file($r_f['tmp_name'], $this->request->dirpath);

		if($result) {
			chmod($this->request->dirpath, 0766);  // File 권한
		}
		exit;
	} /*}}}*/

}
?>
