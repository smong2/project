<?php
class User_Cyworld extends BaseObject
{
	protected $__userId;
	protected $__cyId;

	protected $parent;

	public function __construct(User $user) /*{{{*/
	{
		$this->__userId = $user->getUserId();
		$this->parent   = $user;
	} /*}}}*/

	public function isConnected() /*{{{*/
	{
		return ($this->getCyId() !== '');
	} /*}}}*/
}
?>
