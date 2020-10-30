<?php
class Podo_Formatter_Token
{
	public $type = '';
	public $data = '';

	public function __construct($type, $data) /*{{{*/
	{
		$this->type = $type;
		$this->data = $data;
	} /*}}}*/

	public function toString($depth = 0) /*{{{*/
	{
		switch ($this->type) {
			case 'T_STRING':
				if (in_array(strtolower($this->data), array('true', 'false', 'null'))) {
					return strtolower($this->data);
				}
				return $this->data;

			case 'T_CONSTANT_ENCAPSED_STRING':
				if ($this->data[0] === '"' &&
				        strpos($this->data, '$') === false &&
				        strpos($this->data, '\\') === false &&
				        strpos($this->data, '\'') === false) {
					return '\''.substr($this->data, 1, -1).'\'';
				}
				return $this->data;

			case 'T_DOC_COMMENT':
				$strCmt = rtrim(substr($this->data, 3));
				$strCmt = preg_replace("/\n[ \t]*(?:(\**\/?) ?)?/", "\n".str_repeat("\t", $depth).' $1 ', $strCmt);

				return '/**'.$strCmt;

			case 'T_COMMENT':
				$retval = '';

				if (substr(ltrim($this->data), 0, 2) === '//') {
					return preg_replace('/^(\s*)\/\/([^ \/])/', '$1// $2', $this->data);
				}
				else if (substr($this->data, 0, 3) === '/**') {
					$strCmt = rtrim(substr($this->data, 3));
					$strCmt = preg_replace("/\n[ \t]*(?:(\**\/?) ?)?/", "\n".str_repeat("\t", $depth).' $1 ', $strCmt);

					return '/**'.$strCmt;
				}
				else if (substr($this->data, 0, 2) === '/*') {
					$strCmt = rtrim(substr($this->data, 2));
					$strCmt = preg_replace("/\n[ \t]*/", "\n".str_repeat("\t", $depth).' ', $strCmt);

					return '/*'.$strCmt;
				}
				else {
					return $this->data;
				}

			default:
				return preg_replace("/\n[ \t]*/", "\n".str_repeat("\t", $depth), $this->data);
		}
	} /*}}}*/
}
?>
