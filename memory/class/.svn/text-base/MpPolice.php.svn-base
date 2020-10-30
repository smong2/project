<?php
class MpPolice extends Police
{
	protected $__mpSq;
	protected $__mp;
	protected $__mpNm;
	protected $__statusGb;
	protected $__reasonGb;
	protected $__officer;
	protected $__content;
	protected $__updateDt;

	public static function instance($mpSq) /*{{{*/
	{
		static $sInstance = array();

		$mpSq = intval($mpSq);

		if (isset($sInstance[$mpSq]) === false) {
			$className        = __CLASS__;
			$mp               = new $className($mpSq);
			$sInstance[$mpSq] = $mp;
		}

		return $sInstance[$mpSq];
	} /*}}}*/

	public function __construct($mpSq = null) /*{{{*/
	{
		$this->__mpSq = $mpSq;
	} /*}}}*/

	public function getStatusStr() /*{{{*/
	{
		return self::$status[$this->getStatusGb()];
	} /*}}}*/

	public function getReasonStr() /*{{{*/
	{
		return self::$reasons[$this->getReasonGb()];
	} /*}}}*/
}
?>
