PHP Warning:  Unexpected character in input:  '\' (ASCII=92) state=1 in /skcomms/frw/kiwi/podo/class/Podo/Formatter/Tokenizer.php on line 16

Warning: Unexpected character in input:  '\' (ASCII=92) state=1 in /skcomms/frw/kiwi/podo/class/Podo/Formatter/Tokenizer.php on line 16
PHP Warning:  Unexpected character in input:  '\' (ASCII=92) state=1 in /skcomms/frw/kiwi/podo/class/Podo/Formatter/Tokenizer.php on line 16

Warning: Unexpected character in input:  '\' (ASCII=92) state=1 in /skcomms/frw/kiwi/podo/class/Podo/Formatter/Tokenizer.php on line 16
<?php
require_once 'XML/Unserializer.php';

class Api extends BaseObject
{
	protected $__userId;
	protected $__url;
	protected $__shortenUrl;


	public static function instance($pk) /*{{{*/
	{
		static $sInstance = array();

		$pk = strval($pk);

		if (isset($sInstance[$pk]) === false) {
			$className      = __CLASS__;
			$obj            = new $className($pk);
			$sInstance[$pk] = $obj;
		}

		return $sInstance[$pk];
	} /*}}}*/

	protected function __construct($url) /*{{{*/
	{
		$this->__url = $url;
	} /*}}}*/

	public function shorten() /*{{{*/
	{
		$string    = 'curl http://goo.gl/api/shorten -d url=\\' . $this->getUrl();
		$last_line = exec($string);
		$json      = json_decode($last_line);

		if (isset($json->short_url)) {
			return $json->short_url;
		} else {
			return false;
		}
	} /*}}}*/

}
?>
