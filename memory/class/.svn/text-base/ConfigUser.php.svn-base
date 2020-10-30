<?php
class ConfigUser extends BaseObject
{
	protected $__userid;
	protected $__insertDt;
	protected $__nickEnableFl;
	protected $__nickname;
	protected $__homepageLinkFl;
	protected $__homepage;
	protected $__viewPerPage;
	protected $__dateDiff;
	protected $__profileImage;

	public static function instance($userid) /*{{{*/
	{
		static $sInstance = array();

		$userid = intval($userid);

		if (isset($sInstance[$userid]) === false) {
			$className          = __CLASS__;
			$user               = new $className($userid);
			$sInstance[$userid] = $user;
		}

		return $sInstance[$userid];
	} /*}}}*/
}
?>
