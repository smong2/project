<?php
class Board extends BaseObject
{
	protected $__idx;
	protected $__name;
	protected $__subject;
	protected $__content;
	protected $__regDt;
	protected $__userCreatedTime;

	protected $__member;


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

	protected function __construct($idx) /*{{{*/
	{
		$this->__idx = $idx;
	} /*}}}*/


	/**
	 * 유닉스 타임으로 변경
	 * 
	 * return 유닉스 타임으로 변경된 $__regDt
	 */
	public function transTimeformat() /*{{{*/
	{
		$this->setRegDt(strtotime($this->__regDt));
	} /*}}}*/
}
?>
