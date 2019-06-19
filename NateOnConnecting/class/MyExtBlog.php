<?php
class MyExtBlog Extends BaseObject
{
	protected $__blogdocSeq;
	protected $__extBlog;
	protected $__owner;
	protected $__blogTitle;
	protected $__blogUrl;

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

	protected function __construct($blogdocSeq) /*{{{*/
	{
		$this->__blogdocSeq = $blogdocSeq;
	} /*}}}*/
}
?>
