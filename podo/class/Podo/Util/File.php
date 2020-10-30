<?php
class Podo_Util_File
{
	/**
	 * create temporary file and put contents into it, then move to $filename
	 * when contetns is put, file mode is set.
	 * 
	 * @param string $strFileName
	 * @param text $txtData
	 * @param int $intMode
	 */
	public static function file_put_contents($strFileName, $txtData, $intMode = 0644) /*{{{*/
	{
		$strTempName = tempnam(dirname($strFileName), 'tmp_');

		if (file_put_contents($strTempName, $txtData) === false) {
			return false;
		}

		@umask(0000);
		@chmod($strTempName, $intMode);

		if (file_exists($strFileName)) {
			if (@unlink($strFileName) === false) {
				@file_put_contents($strFileName, $txtData);
				@unlink($strTempName);
				return false;
			}
		}

		@rename($strTempName, $strFileName);

		return true;
	} /*}}}*/

	/**
	 * @desc return if time to live is expired or not
	 * 
	 * @param mixed $mixSrcFile source file
	 * @param string $strDesFile created file
	 * @param int $intTtl time to live, second
	 * @return bool If it is expired, than return false
	 */
	public static function checkTimeToLive($mixSrcFile, $strDesFile, $intTtl) /*{{{*/
	{
		// 파일이 없다면 무조건 재생성
		if (file_exists($strDesFile) === false) {
			return false;
		}

		// ttl 이 0 보다 작다면 무조건 무시
		if ($intTtl < 0) {
			return true;
		}

		// ttl 이 아직 안 지났다면 무조건 무시
		if ($intTtl > 0 && filemtime($strDesFile)+$intTtl > time()) {
			return true;
		}

		// 소스가 없는 경우 재생성
		if ($mixSrcFile === null || $mixSrcFile === '' || $mixSrcFile === array()) {
			return false;
		}

		if (is_array($mixSrcFile) === false) {
			$arrSrcFile = array($mixSrcFile);
		}
		else {
			$arrSrcFile = $mixSrcFile;
		}

		foreach ($arrSrcFile as $strSrcFile) {
			// 소스가 업데이트 되었다면 재생성
			if (filemtime($strSrcFile) >= filemtime($strDesFile)) {
				return false;
			}
		}

		// ttl 이 0 이 아닌 경우 touch
		if ($intTtl != 0) {
			touch($strDesFile);
		}
		return true;
	} /*}}}*/

	public static function touch($strFile, $intFileMode = 0644, $intDirMode = 0755) /*{{{*/
	{
		if (file_exists($strFile)) {
			return;
		}

		@umask(0000);

		if (file_exists(dirname($strFile)) === false) {
			mkdir(dirname($strFile), $intDirMode, true);
		}

		@touch($strFile);
		@chmod($strFile, $intFileMode);
	} /*}}}*/
}
?>
