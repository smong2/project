<?php
/**
 * Podo_Dispatcher class
 * 
 * @package Podo
 * @version 1.0
 * @author kimgua<kimgua@nate.com>
 * @copyright SK Communications. all rights reserved
 * @createDate 2007.03.14
 */

class Podo_Dispatcher
{
	private $_arrPatterns;
	private $_arrDefault;
	private $_arrParsedData;
	protected $_strAction; // 현재 처리 중인 action 데이타를 들고 있음

	protected function __construct($arrPatterns = null, $arrDefaults = null) /*{{{*/
	{
		if ($arrPatterns === null || $arrDefaults === null) {
			$objXmlDispatcher = new Podo_Dispatcher_XMLParser;
			// $objXmlDispatcher->parse();
			$arrPatterns = $objXmlDispatcher->getPattern();
			$arrDefaults = $objXmlDispatcher->getDefault();
		}

		$this->_arrPatterns = $arrPatterns;
		$this->_arrDefault  = $arrDefaults;
	} /*}}}*/

	public static function instance($arrPatterns = null, $arrDefaults = null) /*{{{*/
	{
		static $sInstance;

		if (isset($sInstance) === false) {
			$strClassName = __CLASS__;
			$sInstance    = new $strClassName($arrPatterns, $arrDefaults);
		}

		return $sInstance;
	} /*}}}*/

	public function getDefaultInfo() /*{{{*/
	{
		return array(
		    'CONTROLLER' => $this->_arrDefault['CONTROLLER'][0]['data'],
		    'ACTION' => $this->_arrDefault['ACTION'][0]['data'],
		    'VIEW' => $this->_arrDefault['VIEW'][0]['data'],
		);
	} /*}}}*/

	public function setAction($strAction) /*{{{*/
	{
		$this->_strAction = $strAction;
	} /*}}}*/

	public function parsePattern($strFullURL = null) /*{{{*/
	{
		if ($strFullURL === null) {
			$strFullURL = $this->getRequestURL();
		}
		else {
			$strFullURL = $strFullURL;
		}

		Logger::log(__CLASS__, 1, 'URL: '.$strFullURL);

		$arrAssay['CONTROLLER'] = $this->_arrDefault['CONTROLLER'][0]['data'];
		$arrAssay['ACTION']     = $this->_arrDefault['ACTION'][0]['data'];

		$arrFind = $this->findUrlPattern($strFullURL);

		if (sizeof($arrFind) > 0) {
			if (isset($arrFind['MAPPING'])
			        && !preg_match($arrFind['EXPRESSION'][0]['data'], $arrFind['MAPPING'][0]['data'], $arrMapping)) {
				echo 'parseMapping Error!';
				return $arrAssay;
			}

			if (isset($arrFind['VIEW'][0]['data'])) {
				$arrAssay['VIEW'] = $this->parseEreg($arrFind['VIEW'][0]['data']);
			}
			if (isset($arrFind['PARAM'])) {
				for ($i=0; $i<sizeof($arrFind['PARAM']); $i++) {
					$tParmadata = $this->parseEreg($arrFind['PARAM'][$i]['data']);

					if (!((preg_match('/<\$(\d+)>/', $arrFind['PARAM'][$i]['data'])
					         || preg_match('/{\$(\d+)}/', $arrFind['PARAM'][$i]['data']))
					         && $tParmadata == $arrFind['PARAM'][$i]['data'])) {
						$arrAssay[$arrFind['PARAM'][$i]['attr']['ID']] = $tParmadata;
					}
				}
			}

			if (isset($arrMapping)) {
				for ($i=1; $i<sizeof($arrMapping); $i++) {
					if (strtoupper($arrMapping[$i]) == 'CONTROLLER') {
						$arrAssay[strtoupper($arrMapping[$i])] = $this->_arrParsedData[$i];
					}
					else if (strtoupper($arrMapping[$i]) == 'ACTION') {
						$arrAssay[strtoupper($arrMapping[$i])] = $this->_arrParsedData[$i];
					}
					else {
						$arrAssay[$arrMapping[$i]] = $this->_arrParsedData[$i];
					}
				}
			}
			if (isset($arrFind['CONTROLLER'][0]['data'])) {
				$arrAssay['CONTROLLER'] = $this->parseEreg($arrFind['CONTROLLER'][0]['data']);
			}
			if (isset($arrFind['ACTION'][0]['data'])) {
				$arrAssay['ACTION'] = $this->parseEreg($arrFind['ACTION'][0]['data']);
			}
		}
		// 		echo "<pre>";
		// 		var_dump($arrAssay);
		// 		echo "</pre>";
		return $arrAssay;
	} /*}}}*/

	public function parseUrl($strFullUrl) /*{{{*/
	{
		$arrParsedUrl = array();

		$x  = parse_url($strFullUrl);
		$x1 = pathinfo($x['path']);

		$arrParsedUrl[0] = $strFullUrl;
		if (strpos($x1['dirname'], '/') === false) {
			if ($x1['dirname'] === '.') {
				$arrParsedUrl[1] = $x1['basename'];
				$arrParsedUrl[2] = null;
			}
			else {
				$arrParsedUrl[1] = $x1['dirname'];
				$arrParsedUrl[2] = $x1['basename'];
			}
		}
		else {
			preg_match("%^([^/ ]*)/([^? ]*)$%", $x1['dirname'], $tParsed);
			list($arrParsedUrl[1], $arrParsedUrl[2]) = array($tParsed[1], $tParsed[2]);
			// list($arrParsedUrl[1], $arrParsedUrl[2]) = explode('/', $x1['dirname']);
			$arrParsedUrl[2] .= '/' . $x1['basename'];
		}
		if (isset($x['query'])) {
			$arrParsedUrl[3] = $x['query'];
		}
		else {
			$arrParsedUrl[3] = '';
		}
		ksort($arrParsedUrl);

		/*
		 if (preg_match("/^([^\/ ]*)\/?([^\? ]*)\??(.*)$/",$strFullUrl, $arrParsedUrl) === false) {
		 echo $strFullUrl." : parse Error!\n";
		 }
		 */

		if ($arrParsedUrl[2]) {
			$arrParsedUrl[2] = preg_replace("/\/{2,}/", '/', $arrParsedUrl[2]);
			$arrParsedUrl[2] = preg_replace("/^\//", '', $arrParsedUrl[2]);
			if ($arrParsedUrl[2] == '') {
				$arrParsedUrl[2] = false;
			}
		}

		if ($arrParsedUrl[3]) {
			$arrParsedUrl[3] = preg_replace('/&{2,}/', '&', $arrParsedUrl[3]);

			$arrParam   = split('&', $arrParsedUrl[3]);
			$tStrParams = '';
			for ($i=0; $i<sizeof($arrParam); $i++) {
				if (preg_match('/^action=/i', $arrParam[$i])) {
					$arrParsedUrl[2] .= '?' . $arrParam[$i];
				} else {
					$tStrParams .= '&' . $arrParam[$i];
				}
			}
			if (strlen($tStrParams) > 1) {
				$arrParsedUrl[3] = substr($tStrParams, 1);
			} else {
				$arrParsedUrl[3] = false;
			}
		}

		return $arrParsedUrl;
	} /*}}}*/

	public function findUrlPattern($strFullUrl) /*{{{*/
	{
		$arrParsedUrl   = $this->parseUrl($strFullUrl);
		$arrParsedParam = $this->parseParam($arrParsedUrl[3]);
		$isFindok       = false;

		foreach ($this->_arrPatterns as $i=>$dictPattern) {
			Logger::log(__CLASS__, 2, 'Pattern: ['.$dictPattern['attr']['TYPE'].'] '.$dictPattern['EXPRESSION'][0]['data']);
			switch ($dictPattern['attr']['TYPE']) {
				case 'PARAM':
					$isParam = false;
					for ($j=0; $j<sizeof($arrParsedParam); $j++) {
						if (ereg("^([^= ]+)=(.*)$", $arrParsedParam[$j], $arrParamSet)) {
							if ($arrParamSet[1] == $dictPattern['attr']['PARAM']) {
								if (!isset($dictPattern['attr']['VALUE'])) {
									$isParam = true;
									break;
								} else if ($dictPattern['attr']['VALUE'] == $arrParamSet[2]) {
									$isParam = true;
									break;
								}
							}
						}
					}
					if ($isParam) {
						$arrType  = $this->parseType($i, $dictPattern['attr']['TARGET'], $arrParsedUrl);
						$isFindok = $arrType[0];
					}
					break;

				case 'ACTION':
					$tUri = $arrParsedUrl[2];
					/*
					 if(preg_match("/^[^\? ]*\?action=/i" , $arrParsedUrl[2])) {
					 $arrParsedUrl[2] = eregi_replace("^([^\? ]*)\?action=" , "" , $arrParsedUrl[2]);
					 if ($tUri != $arrParsedUrl[2]) {
					 $arrType = $this->parseType($i, "URI", $arrParsedUrl);
					 $isFindok = $arrType[0];
					 }
					 }
					 else{
					 */
					// $arrParsedUrl[2] = $_REQUEST["action"];
					$arrParsedUrl[2] = $this->_strAction;
					$arrType         = $this->parseType($i, 'URI', $arrParsedUrl);
					$isFindok        = $arrType[0];
					// }
					$arrParsedUrl[2] = $tUri;

					break;

				default:
					$arrType  = $this->parseType($i, $dictPattern['attr']['TYPE'], $arrParsedUrl);
					$isFindok = $arrType[0];
			}
			if ($isFindok) {
				Logger::log(__CLASS__, 2, 'Match Result: success');
				break;
			}
			else {
				Logger::log(__CLASS__, 2, 'Match Result: fail');
			}
		}

		return $arrType[1];
	} /*}}}*/

	public static function getRequestURL() /*{{{*/
	{
		if ($_SERVER['SERVER_PORT'] != '80') {
			return $_SERVER['SERVER_NAME'] . ':' . $_SERVER['SERVER_PORT'] . $_SERVER['REQUEST_URI'];
		}
		else {
			return $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];
		}
	} /*}}}*/

	// {$n}으로 되어 있는 값들을 실제 값으로 치환한다.
	public function parseParam($strParams) /*{{{*/
	{
		$arrParam = array();
		if (!($strParams === false)) {
			$arrParam = split('&', $strParams);
		}

		return $arrParam;
	} /*}}}*/

	public function parseEreg($strValue, $arrParsedData = '') /*{{{*/
	{
		if (is_array($arrParsedData)) {
			$this->_arrParsedData = $arrParsedData;
		} else {
			$arrParsedData = $this->_arrParsedData;
		}

		if (preg_match_all('/<\$(\d+)>/', $strValue, $arrMatch)) {
			foreach ($arrMatch[1] as $intKey=>$intPatternNo) {
				if (isset($arrParsedData[$intPatternNo])) {
					$strPattern = str_replace(' ', '_', ucwords(str_replace('/', ' ', $arrParsedData[$intPatternNo])));
					$strValue   = str_replace($arrMatch[0][$intKey], $strPattern, $strValue);
				}
			}
		}

		if (preg_match_all('/{\$(\d+)}/', $strValue, $arrMatch)) {
			foreach ($arrMatch[1] as $intKey=>$intPatternNo) {
				if (isset($arrParsedData[$intPatternNo])) {
					$strValue = str_replace($arrMatch[0][$intKey], $arrParsedData[$intPatternNo], $strValue);
				}
			}
		}

		return $strValue;
	} /*}}}*/

	private function parseType($i, $strSwitch, $arrParsedUrl) /*{{{*/
	{
		$isFindok   = false;
		$arrPattern = array();
		$data       = array();

		switch ($strSwitch) {
			case 'HOST':
				if (preg_match($this->_arrPatterns[$i]['EXPRESSION'][0]['data'], $arrParsedUrl[1], $data)) {
					$arrPattern = $this->_arrPatterns[$i];
					$isFindok   = true;
				}
				break;

			case 'URI':
				if (preg_match($this->_arrPatterns[$i]['EXPRESSION'][0]['data'], $arrParsedUrl[2], $data)) {
					$arrPattern = $this->_arrPatterns[$i];
					$isFindok   = true;
				}
				break;

			case 'ALL':
				$tUrl = $arrParsedUrl[1] . $this->_strAction;
				if (preg_match($this->_arrPatterns[$i]['EXPRESSION'][0]['data'], $tUrl, $data)) {
					$arrPattern = $this->_arrPatterns[$i];
					$isFindok   = true;
				}
				break;

			default:
		}

		$arrType[0] = $isFindok;
		$arrType[1] = $arrPattern;

		$this->_arrParsedData = $data;

		return $arrType;
	} /*}}}*/
}
?>
