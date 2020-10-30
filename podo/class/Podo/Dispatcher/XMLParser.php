<?php
/**
 * Podo_Dispatcher_XMLParser class
 * 
 * @package Podo.Dispatcher
 * @version 1.0
 * @author kimgua<kimgua@nate.com>
 * @copyright SK Communications. all rights reserved
 * @createDate 2007.03.06
 */
class Podo_Dispatcher_XMLParser
{
	private $_parser;
	private $_filePath;
	private $_document;
	private $_currTag;
	private $_tagStack;
	private $_TAG_ATTRIBUT = 'attr';
	private $_TAG_DATA     = 'data';
	private $_encoding     = 'UTF-8';

	function __construct($strFilepath = null) /*{{{*/
	{
		if ($strFilepath === null) {
			$strSourceFile = ConfigManager::get('Podo_Dispatcher.rule.file', dirname(__FILE__).'/../../../config/dispatcher.xml');
			$strDesFile    = ConfigManager::get('Podo_Dispatcher.rule.cache', dirname(__FILE__).'/../../../config/dispatcher.php');

			if (Podo_Util_File::checkTimeToLive($strSourceFile, $strDesFile, 0) === false) {
				$this->setUp($strSourceFile);
				$this->parse();

				$arrArray = array();

				$arrArray['DISPATCHER-CONFIG'][0]['PATTERNS'][0]['PATTERN'] = $this->getPattern();
				$arrArray['DISPATCHER-CONFIG'][0]['DEFAULT'][0]             = $this->getDefault();

				$fileBuilder = new Podo_Dispatcher_ArrayFile;
				$fileBuilder->setArray($arrArray);
				$tDesFile = $strDesFile.time();
				$fileBuilder->setTarget($tDesFile);
				$fileBuilder->makeArray2File('Cache_Array');
				if (!rename($tDesFile, $strDesFile)) {
					unlink($tDesFile);
				}
			}
			else {
				require_once($strDesFile);
				$this->_document = &$Cache_Array;
			}
		}
		else {
			$this->setUp($strFilepath);
		}
	} /*}}}*/

	private function setUp($strFilepath) /*{{{*/
	{
		$this->_parser   = xml_parser_create($this->_encoding);
		$this->_document = array();
		$this->_currTag  = &$this->_document;
		$this->_tagStack = array();
		$this->_filePath = $strFilepath;
	} /*}}}*/

	public function getDocument() /*{{{*/
	{
		return $this->_document;
	} /*}}}*/

	public function getPattern() /*{{{*/
	{
		return $this->_document['DISPATCHER-CONFIG'][0]['PATTERNS'][0]['PATTERN'];
	} /*}}}*/

	public function getDefault() /*{{{*/
	{
		return $this->_document['DISPATCHER-CONFIG'][0]['DEFAULT'][0];
	} /*}}}*/

	public function parse() /*{{{*/
	{
		$this->setparser();

		if (!($fp = fopen($this->_filePath, 'r'))) {
			die('Cannot open XML data file: '.$this->_filePath);
			return false;
		}

		while ($data = fread($fp, 4096)) {
			if (!xml_parse($this->_parser, $data, feof($fp))) {
				die(sprintf('XML error: %s at line %d',
				            xml_error_string(xml_get_error_code($this->_parser)),
				            xml_get_current_line_number($this->_parser)));
			}
		}

		fclose($fp);
		$this->freeparser();

		return true;
	} /*}}}*/

	public function parse_str($data) /*{{{*/
	{
		$this->setparser();

		if (!xml_parse($this->_parser, $data)) {
			sprintf('XML error: %s at line %d',
			        xml_error_string(xml_get_error_code($this->_parser)),
			        xml_get_current_line_number($this->_parser));
			$this->freeparser();
			return false;
		}

		$this->freeparser();
		return true;
	} /*}}}*/

	private function setparser() /*{{{*/
	{
		xml_set_object($this->_parser, $this);
		xml_set_character_data_handler($this->_parser, 'dataHandler');
		xml_set_element_handler($this->_parser, 'startHandler', 'endHandler');
	} /*}}}*/

	private function freeparser() /*{{{*/
	{
		xml_parser_free($this->_parser);
	} /*}}}*/

	private function startHandler($parser, $name, $attribs) /*{{{*/
	{
		if (!isset($this->_currTag[$name])) {
			$this->_currTag[$name] = array();
		}

		$newTag = array();
		if (!empty($attribs)) {
			$newTag[$this->_TAG_ATTRIBUT] = $attribs;
		}
		array_push($this->_currTag[$name], $newTag);

		$t              = &$this->_currTag[$name];
		$this->_currTag = &$t[count($t)-1];
		array_push($this->_tagStack, $name);
	} /*}}}*/

	private function dataHandler($parser, $data) /*{{{*/
	{
		$data = trim($data);

		if (!empty($data)) {
			if (isset($this->_currTag[$this->_TAG_DATA])) {
				$this->_currTag[$this->_TAG_DATA] .= $data;
			}
			else {
				$this->_currTag[$this->_TAG_DATA] = $data;
			}
		}
	} /*}}}*/

	private function endHandler($parser, $name) /*{{{*/
	{
		$this->_currTag = &$this->_document;
		array_pop($this->_tagStack);

		for ($i=0; $i<count($this->_tagStack); $i++) {
			$t              = &$this->_currTag[$this->_tagStack[$i]];
			$this->_currTag = &$t[count($t)-1];
		}
	} /*}}}*/
}
?>
