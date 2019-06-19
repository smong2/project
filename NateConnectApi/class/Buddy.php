<?php
class Buddy Extends BaseObject
{
	protected $__fCmn;
	protected $__nateId;
	protected $__name;
	protected $__fName;
	protected $__fNateId;
	protected $__fTid;
	protected $__regSource;
	protected $__userIp;
	protected $__blockYn;

	const M_INFO_Y = 'y';
	const M_INFO_N = 'n';

	const SORT_BY_DATE = 1;
	const SORT_BY_NAME = 2;

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

	protected function __construct($fCmn) /*{{{*/
	{
		$this->__fCmn = $fCmn;
	} /*}}}*/

	/**
	 * 친구 추가
	 */
	public function addFriend(User $user, Service $service) /*{{{*/
	{
		return ContainerAPI::addFriend($this, $user, $service);
	} /*}}}*/

	/**
	 * 친구 제거
	 */
	public function deleteFriend(User $user, Service $service) /*{{{*/
	{
		return ContainerAPI::deleteFriend($user, $this, $service);
	} /*}}}*/

	/**
	 * 수신 거부 설정
	 */
	public function updateRecieve(User $user, Service $service) /*{{{*/
	{
		return ContainerAPI::updateRecieve($this, $user, $service);
	} /*}}}*/
}
?>
