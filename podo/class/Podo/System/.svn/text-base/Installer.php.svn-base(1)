<?php
if (class_exists('Podo_Util_File', false) === false) {
	require_once dirname(__FILE__).'/../Util/File.php';
}

/**
 * @desc Installer
 * 
 * @author Jonghun Shin <teeroz@nate.com>
 */
class Podo_System_Installer
{
	// directory where temporary file is saved (relative to base directory)
	protected $_strTempDir = 'tmp';

	// template files
	protected $_arrTemplateFile = array(
	    'config/template/common_base.inc.php' => 'config/common_base.inc.php',
	    'config/template/dev.cfg' => 'config/dev.cfg',
	);

	// require files when auto configuration
	// if this file is modified, then it is need to install
	protected $_arrInstallFile = array(
	    'config/Installer.class.php',
	    'config/template/common_base.inc.php',
	    'config/template/dev.cfg',
	);

	// created files after install
	// this files may not include in VCS repository
	protected $_arrCreatedFile = array(
	    'config/common_base.inc.php',
	    'config/dev.cfg',
	);

	private $_isLive = false;

	const MERGE_COPIED       = 1;
	const MERGE_BY_BASE      = 2;
	const MERGE_NON_BASEFILE = 3;

	/**
	 * @desc replace reserved keyword of text to the value
	 * 
	 * @param text $txtContent original text
	 * @param array $dictMacro reserved keywords and the values
	 * @return text replaced text
	 */
	protected function _replaceMacro($txtContent, array $dictMacro) /*{{{*/
	{
		$arrSearch  = array();
		$arrReplace = array();
		foreach ($dictMacro as $strKey=>$strValue) {
			$arrSearch[] = '{'.$strKey.'}';
			if ($strValue === true) {
				$strValue = 'true';
			}
			else if ($strValue === false) {
				$strValue = 'false';
			}
			$arrReplace[] = $strValue;
		}

		return str_replace($arrSearch, $arrReplace, $txtContent);
	} /*}}}*/

	/**
	 * @desc return recent modified time of files
	 * 
	 * @param array $arrFile array of file names
	 * @return int recent modified time
	 */
	protected function _getMaxFileModifiedTime(array $arrFile) /*{{{*/
	{
		$intMaxFileModifiedTime = 0;

		foreach ($arrFile as $strFile) {
			$strFilePath = $strFile;
			if ($strFilePath[0] !== '/') {
				$strFilePath = $this->_getBaseDir().DIRECTORY_SEPARATOR.$strFile;
			}

			if (file_exists($strFilePath) === false) {
				continue;
			}

			$intFileModifiedTime = filemtime($strFilePath);
			if ($intFileModifiedTime > $intMaxFileModifiedTime) {
				$intMaxFileModifiedTime = $intFileModifiedTime;
			}
		}

		return $intMaxFileModifiedTime;
	} /*}}}*/

	/**
	 * @desc return recent modified time of files
	 * 
	 * @param array $arrFile array of file names
	 * @return int recent modified time
	 */
	protected function _getMinFileModifiedTime(array $arrFile) /*{{{*/
	{
		$intMinFileModifiedTime = time();

		foreach ($arrFile as $strFile) {
			$strFilePath = $strFile;
			if ($strFilePath[0] !== '/') {
				$strFilePath = $this->_getBaseDir().DIRECTORY_SEPARATOR.$strFile;
			}

			if (file_exists($strFilePath) === false) {
				return 0;
			}

			$intFileModifiedTime = filemtime($strFilePath);
			if ($intFileModifiedTime < $intMinFileModifiedTime) {
				$intMinFileModifiedTime = $intFileModifiedTime;
			}
		}

		return $intMinFileModifiedTime;
	} /*}}}*/

	/**
	 * @param string $strDestFile merge 한 내용이 저장되는 파일
	 * @param string $strBaseFile svn up 하기 전 생성된 파일
	 * @param string $strNewFile svn up 한 후 생성된 파일
	 * @param string $strBakFile svn up 하기 전 생성된 내용을 보관해두는 파일
	 */
	private function _mergeFile($strDestFile, $strBaseFile, $strNewFile, $strBakFile) /*{{{*/
	{
		if (file_exists($strDestFile) === false) {
			copy($strNewFile, $strDestFile);
			rename($strNewFile, $strBaseFile);

			return self::MERGE_COPIED;
		}
		else if (file_exists($strBaseFile) === false) {
			rename($strDestFile, $strBakFile);
			copy($strNewFile, $strDestFile);
			rename($strNewFile, $strBaseFile);

			return self::MERGE_NON_BASEFILE;
		}
		else {
			copy($strDestFile, $strBakFile);
			system("merge '".$strDestFile."' '".$strBaseFile."' '".$strNewFile."'");
			rename($strNewFile, $strBaseFile);

			return self::MERGE_BY_BASE;
		}
	} /*}}}*/

	/**
	 * @desc do install
	 */
	public function install($isDisplay = false) /*{{{*/
	{
		$strBaseDir = $this->_getBaseDir();
		$arrMacro   = $this->_getMacro();

		umask(0000);

		// create temporary directory
		$strTempDir = $strBaseDir.DIRECTORY_SEPARATOR.$this->_strTempDir;
		if (file_exists($strTempDir) === false) {
			mkdir(str_replace('/', DIRECTORY_SEPARATOR, $strTempDir), 0777, true);

			if ($isDisplay) {
				echo 'The Temporary Directory is created : '.$strTempDir."\n";
			}
		}

		// set write permision to tmp/
		$this->_setWritePerm($strTempDir);
		if ($isDisplay) {
			echo "The permission of tmp/ is changed.\n";
		}

		// create temporary installer directory
		$strInstallTempDir = str_replace('/', DIRECTORY_SEPARATOR, $strTempDir.'/Podo/System/Installer');
		if (file_exists($strInstallTempDir) === false) {
			mkdir($strInstallTempDir, 0777, true);
			/*
			if ($isDisplay) {
			echo 'Temporary Directory for Installer is created : '.$strInstallTempDir."\n";
			}
			*/
		}

		// create config files
		foreach ($this->_arrTemplateFile as $strTemplateFile=>$strCreatedFile) {
			$strSourceFile  = $strBaseDir.DIRECTORY_SEPARATOR.$strTemplateFile;
			$strDestFile    = $strBaseDir.DIRECTORY_SEPARATOR.$strCreatedFile;
			$strDestFileGen = $strInstallTempDir.DIRECTORY_SEPARATOR.str_replace(array(DIRECTORY_SEPARATOR, '/', '\\'), '_', $strCreatedFile);

			Podo_Util_File::file_put_contents($strDestFileGen, $this->_replaceMacro(file_get_contents($strSourceFile), $arrMacro), 0666);

			$strDestFileBase = $strDestFileGen.'.base';
			$strDestFileBak  = $strDestFileGen.'.bak';

			$mergeResult = $this->_mergeFile($strDestFile, $strDestFileBase, $strDestFileGen, $strDestFileBak);

			if ($isDisplay) {
				if ($mergeResult === self::MERGE_COPIED) {
					echo 'The Local File is created(C) : '.$strTemplateFile.' => '.$strCreatedFile."\n";
				}
				else if ($mergeResult === self::MERGE_BY_BASE) {
					echo 'The Local File is merged(M) : '.$strTemplateFile.' +=> '.$strCreatedFile."\n";
				}
				else if ($mergeResult === self::MERGE_NON_BASEFILE) {
					echo 'The Local File is created(B) : '.$strTemplateFile.' => '.$strCreatedFile."\n(The Original File is backuped at : ".substr($strDestFileBak, strlen($strBaseDir)+1).")\n";
				}
			}
		}
	} /*}}}*/

	private function _setWritePerm($dir) /*{{{*/
	{
		if (is_dir($dir) === false) {
			chmod($dir, 0666);
			return;
		}

		@chmod($dir, 0777);

		if ($dh = opendir($dir)) {
			while (($file = readdir($dh)) !== false) {
				if ($file === '.' || $file === '..') {
					continue;
				}

				$filepath = $dir.DIRECTORY_SEPARATOR.$file;

				if (is_dir($filepath)) {
					$this->_setWritePerm($filepath);
					continue;
				}

				@chmod($filepath, 0666);
			}
			closedir($dh);
		}
	} /*}}}*/

	/**
	 * @desc check if it is need to install, and install as if need
	 */
	public function check() /*{{{*/
	{
		$intMaxInstallFileModifiedTime = $this->_getMaxFileModifiedTime($this->_arrInstallFile);
		$intMinCreatedFileModifiedTime = $this->_getMinFileModifiedTime($this->_arrCreatedFile);

		if ($intMinCreatedFileModifiedTime === 0 ||
		        file_exists($this->_getBaseDir().DIRECTORY_SEPARATOR.$this->_strTempDir) === false) {
			echo 'You must initialize a working directory. Execute file of \'config/init-prj [ dev | live ]\'.';
			exit;
		}

		if (is_writable($this->_getBaseDir().DIRECTORY_SEPARATOR.$this->_strTempDir) === false) {
			echo 'You must initialize a working directory. Execute file of \'config/init-prj [ dev | live ]\'.';
			exit;
		}

		if ($intMinCreatedFileModifiedTime < $intMaxInstallFileModifiedTime) {
			if (defined('PODO_CONFIG_ISLIVE')) {
				$this->setLive(PODO_CONFIG_ISLIVE);
			}
			else {
				$this->setLive(false);
			}
			$this->install();
		}
	} /*}}}*/

	public function setLive($isLive) /*{{{*/
	{
		$this->_isLive = $isLive;
	} /*}}}*/

	public function getLive() /*{{{*/
	{
		return $this->_isLive;
	} /*}}}*/
}
?>
