<?php
class ExtBlog Extends BaseObject
{
	protected $__blogId;
	protected $__blogNm;
	protected $__imgPath;

	const BLOG_EGLOOS = 0;
	const BLOG_SPOON = 3;
	const BLOG_TWITTER = 4;

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

	protected function __construct($blogId) /*{{{*/
	{
		$this->__blogId = $blogId;
	} /*}}}*/
}
?>
