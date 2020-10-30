<?php
if (class_exists('Podo_System_Installer', false) === false) {
	require_once PODO_CONFIG_KIWIDIR.'/podo/class/Podo/System/Installer.php';
}

/**
 * @desc Install Class
 * 
 * @author Jonghun Shin <teeroz@nate.com>
 */
class Installer extends Podo_System_Installer
{
	const PJT_NAME = 'memory';

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
	    'config/Installer.php',
	    'config/template/common_base.inc.php',
	    'config/template/dev.cfg',
	);

	// created files after install
	// this files may not include in VCS repository
	protected $_arrCreatedFile = array(
	    'config/common_base.inc.php',
	    'config/dev.cfg',
	);

	/**
	 * @desc return base directory
	 * @return string
	 */
	protected function _getBaseDir() /*{{{*/
	{
		return realpath(dirname(dirname(__FILE__)));
	} /*}}}*/

	/**
	 * @desc return macro keywords and values
	 * @return array Macro Keyword => Replaced Value
	 */
	protected function _getMacro() /*{{{*/
	{
		$arrMacro = array(
		    'PODO_INSTALL_BASEDIR' => $this->_getBaseDir(),
		    'PODO_INSTALL_TEMPDIR' => $this->_getBaseDir().'/tmp',
		    'PODO_INSTALL_ISLIVE' => $this->getLive(),
		);

		if ($this->getLive()) {
			$arrMacro['PODO_INSTALL_TEMPDIR'] = '/skcomms/tmp';
		}

		return $arrMacro;
	} /*}}}*/
}
?>
