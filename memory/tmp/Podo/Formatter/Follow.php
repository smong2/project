<?php
class Buddy Extends BaseObject
{

	protected $__fCmn;
	protected $__nateId;
	protected $__name;
	protected $__fName;
	protected $__fNid;
	protected $__fTid;
	protected $__regSource;
	protected $__userIp;
	protected $__blockYn;

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

	public function addFriend(User $user, Service $service)/*{{{*/
	{
		return ContainerAPI::addFriend($this, $user, $service);
	}/*}}}*/

	public function deleteFriend(User $user, Service $service)/*{{{*/
	{
		return ContainerAPI::deleteFriend($this, $user, $service);
	}/*}}}*/

	public function updateRecieve(User $user, Service $service)/*{{{*/
	{
		return ContainerAPI::updateRecieve($this, $user, $service);
	}/*}}}*/

}
