<?php
class Police extends BaseObject
{
	const REASON_GB_ADVERT    = 1;
	const REASON_GB_PRIVACY   = 2;
	const REASON_GB_DIRTY     = 3;
	const REASON_GB_COPYRIGHT = 4;
	const REASON_GB_SPAM      = 5;

	public static $reasons = array(
	    self::REASON_GB_ADVERT => '상업광고',
	    self::REASON_GB_PRIVACY => '사생활침해',
	    self::REASON_GB_DIRTY => '음란',
	    self::REASON_GB_COPYRIGHT => '저작권',
	    self::REASON_GB_SPAM => '도배',
	);

	const STATUS_GB_NORMAL  = 1;
	const STATUS_GB_BLOCKED = 2;
	const STATUS_GB_TRASH   = 3;
	const STATUS_GB_REMOVED = 4;

	public static $status = array(
	    self::STATUS_GB_NORMAL => '일반',
	    self::STATUS_GB_BLOCKED => '노출제한',
	    self::STATUS_GB_TRASH => '삭제대기',
	    self::STATUS_GB_REMOVED => '완전삭제',
	);
}
?>
