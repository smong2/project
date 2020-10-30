<?php
/**
 * Podo_Dispatcher_ArrayFile class
 * 
 * @package Podo.Dispatcher
 * @version 1.0
 * @author kimgua<kimgua@nate.com>
 * @copyright SK Communications. all rights reserved
 * @createDate 2007.04.02
 */
class Podo_Dispatcher_ArrayFile
{
	private $oriArray;
	private $targetFile;

	public function setArray($arrArray) /*{{{*/
	{
		$this->oriArray = $arrArray;
	} /*}}}*/

	public function setTarget($strFilename) /*{{{*/
	{
		$this->targetFile = $strFilename;
	} /*}}}*/

	public function makeArray2File($strArrayName) /*{{{*/
	{
		ob_start();

		echo "<?php\n";
		echo "\t\$".$strArrayName." = array();\n";

		$this->printArray("\t\$".$strArrayName, $this->oriArray);
		// echo "==============================\n";
		// var_dump($this->oriArray);

		echo "?>\n";
		$strArray = ob_get_contents();
		ob_end_clean();

		umask(0000);

		if (file_exists(dirname($this->targetFile)) === false) {
			mkdir(str_replace('/', DIRECTORY_SEPARATOR, dirname($this->targetFile)), 0777, true);
		}

		$result = file_put_contents($this->targetFile, $strArray);
		return $result;
	} /*}}}*/

	private function printArray($strParent, $arrSource) /*{{{*/
	{
		if (is_array($arrSource)) {
			foreach ($arrSource as $key=>$value) {
				$tParent = $strParent."['".$key."']";
				if (is_array($value)) {
					$this->printArray($tParent, $value);
				}
				else {
					echo $tParent." = '".$value."';\n";
				}
			}
		}
		else {
			echo $strParent." = '".$arrSource."';\n";
		}
	} /*}}}*/
}
?>
