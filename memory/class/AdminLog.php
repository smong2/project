<?php
class AdminLog extends BaseObject
{
	protected $__adminLogSq;
	protected $__officer;
	protected $__actionGb;
	protected $__arg1;
	protected $__arg2;
	protected $__insertDt;

	const GB_OFFICER_ADD           = 1;
	const GB_OFFICER_REMOVE        = 2;
	const GB_AUTH_MODIFY_OFFICER   = 3;
	const GB_AUTH_MODIFY_MENU      = 4;
	const GB_CATEGORY_ADD          = 5;
	const GB_CATEGORY_MODIFY       = 6;
	const GB_CATEGORY_REMOVE       = 11;
	const GB_ACCESS                = 7;
	const GB_CATEGORY_BASIC_ADD    = 8;
	const GB_CATEGORY_BASIC_MODIFY = 9;
	const GB_CATEGORY_BASIC_REMOVE = 10;
	const GB_MP_ADD                = 12;
	const GB_MP_TRASH_ADD          = 13;
	const GB_MP_TRASH_MODIFY       = 14;
	const GB_MP_BLOCK_ADD          = 15;
	const GB_MP_BLOCK_MODIFY       = 16;
	const GB_MP_RECOVERY           = 17;
	const GB_MP_MODIFY             = 18;
	const GB_MODULE_BASIC_MODIFY   = 18;

	private $_actionStr = array(
	    self::GB_OFFICER_ADD => '#arg1# 님을 운영자로 임명하였습니다.',
	    self::GB_OFFICER_REMOVE => '#arg1# 님을 해임하였습니다.',
	    self::GB_AUTH_MODIFY_OFFICER => '#arg1# 님의 메뉴 권한을 변경하였습니다.',
	    self::GB_AUTH_MODIFY_MENU => '#arg1# 메뉴의 운영 권한을 변경하였습니다.',
	    self::GB_CATEGORY_ADD => '카테고리 #arg1# 를 추가하였습니다.',
	    self::GB_CATEGORY_MODIFY => '카테고리 #arg1# 의 설정을 변경하였습니다.',
	    self::GB_CATEGORY_REMOVE => '카테고리 #arg1# 를 삭제하였습니다.',
	    self::GB_ACCESS => '관리 페이지에 접속하였습니다.',
	    self::GB_CATEGORY_BASIC_ADD => '카테고리 #arg1# 에 기본정보 #arg2# 항목을 추가하였습니다.',
	    self::GB_CATEGORY_BASIC_MODIFY => '카테고리 #arg1# 의 기본정보 #arg2# 항목을 수정하였습니다.',
	    self::GB_CATEGORY_BASIC_REMOVE => '카테고리 #arg1# 의 기본정보 #arg2# 항목을 삭제하였습니다.',
	    self::GB_MP_ADD => 'MP #arg1# 을 추가하였습니다.',
	    self::GB_MP_TRASH_ADD => 'MP #arg1# 을 삭제 대기 상태로 변경하였습니다.',
	    self::GB_MP_TRASH_MODIFY => 'MP #arg1# 의 삭제 사유를 변경하였습니다.',
	    self::GB_MP_BLOCK_ADD => 'MP #arg1# 을 노출 제한 상태로 변경하였습니다.',
	    self::GB_MP_BLOCK_MODIFY => 'MP #arg1# 의 노출 제한 사유를 변경하였습니다.',
	    self::GB_MP_RECOVERY => 'MP #arg1# 를 일반 상태로 변경하였습니다.',
	    self::GB_MP_MODIFY => 'MP #arg1# 를 수정하였습니다.',
	    self::GB_MODULE_BASIC_MODIFY => '기본 정보 #arg1# 를 수정하였습니다.',
	);

	public static function instance($adminLogSq) /*{{{*/
	{
		static $sInstance = array();

		$adminLogSq = intval($adminLogSq);

		if (isset($sInstance[$adminLogSq]) === false) {
			$className              = __CLASS__;
			$adminLog               = new $className($adminLogSq);
			$sInstance[$adminLogSq] = $adminLog;
		}

		return $sInstance[$adminLogSq];
	} /*}}}*/

	protected function __construct($adminLogSq) /*{{{*/
	{
		$this->__adminLogSq = $adminLogSq;
	} /*}}}*/

	public function getActionStr() /*{{{*/
	{
		$retval = $this->_actionStr[$this->getActionGb()];
		$retval = str_replace('#arg1#', $this->getArg1(), $this->_actionStr[$this->getActionGb()]);
		$retval = str_replace('#arg2#', $this->getArg2(), $retval);

		return $retval;
	} /*}}}*/
}
?>
