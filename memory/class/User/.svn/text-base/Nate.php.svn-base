<?php
class User_Nate extends BaseObject
{
	protected $__userId;
	protected $__nateId;
	protected $__mail;
	protected $__nickname;

	protected $parent;

	public function __construct(User $user) /*{{{*/
	{
		$this->__userId = $user->getUserId();
		$this->parent   = $user;
	} /*}}}*/

	public function getNateIdStr() /*{{{*/
	{
		$nateId = $this->getNateId();

		if (strpos($nateId, '@') === false) {
			return $nateId . '@nate.com';
		}
		else {
			return $nateId;
		}
	} /*}}}*/
}
?>
