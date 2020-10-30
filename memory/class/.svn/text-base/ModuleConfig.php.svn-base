<?php
class ModuleConfig extends BaseObject
{
	protected $__moduleConfigSq;
	protected $__category;
	protected $__moduleGb;
	protected $__activateFl;
	protected $__title;
	protected $__fieldGb;
	protected $__fieldLength;

	const GB_BASIC     = 12;
	const GB_LINK      = 1;
	const GB_IMAGE     = 2;
	const GB_VIDEO     = 3;
	const GB_MUSIC     = 4;
	const GB_MAP       = 5;
	const GB_LINES     = 6;
	const GB_HISTORY   = 7;
	const GB_PLOT      = 8;
	const GB_CHARACTER = 9;
	const GB_COMMUNITY = 10;
	const GB_RELATED   = 11;

	const FIELD_GB_TEXT   = 1;
	const FIELD_GB_DATE   = 2;
	const FIELD_GB_PERIOD = 3;

	const FIELD_DATE_YMD = 1;
	const FIELD_DATE_YM  = 2;
	const FIELD_DATE_Y   = 3;

	public static $modules = array(
	    self::GB_LINK => '링크',
	    self::GB_IMAGE => '이미지',
	    self::GB_VIDEO => '동영상',
	    self::GB_MUSIC => '음악',
	    self::GB_MAP => '지도',
	    self::GB_LINES => '명대사',
	    self::GB_HISTORY => '변천사',
	    self::GB_PLOT => '줄거리',
	    self::GB_CHARACTER => '등장인물',
	    self::GB_COMMUNITY => '커뮤니티',
	    self::GB_RELATED => '관련 기억들',
	);

	public static $fields = array(
	    self::FIELD_GB_TEXT => '텍스트',
	    self::FIELD_GB_DATE => '날짜',
	    self::FIELD_GB_PERIOD => '기간',
	);

	public static $fieldDates = array(
	    self::FIELD_DATE_YMD => '년월일',
	    self::FIELD_DATE_YM => '년월',
	    self::FIELD_DATE_Y => '년',
	);

	public static function instance($moduleConfigSq) /*{{{*/
	{
		static $sInstance = array();

		$moduleConfigSq = intval($moduleConfigSq);

		if (isset($sInstance[$moduleConfigSq]) === false) {
			$className                  = __CLASS__;
			$module                     = new $className($moduleConfigSq);
			$sInstance[$moduleConfigSq] = $module;
		}

		return $sInstance[$moduleConfigSq];
	} /*}}}*/

	protected function __construct($moduleConfigSq) /*{{{*/
	{
		$this->__moduleConfigSq = $moduleConfigSq;
	} /*}}}*/

	public function getFieldGbStr() /*{{{*/
	{
		return self::$fields[$this->getFieldGb()];
	} /*}}}*/

	public function getFieldLengthStr() /*{{{*/
	{
		if ($this->getFieldGb() == self::FIELD_GB_TEXT) {
			return $this->getFieldLength() . '자';
		}
		else {
			return self::$fieldDates[$this->getFieldLength()];
		}
	} /*}}}*/

	public function modify($title, $fieldGb, $fieldLength, AdminOfficer $officer) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'UPDATE module_config SET title = :title, field_gb = :field_gb, field_length = :field_length, update_dt = now()
		          WHERE module_config_sq = :module_config_sq';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':module_config_sq', $this->__moduleConfigSq, PDO::PARAM_STR);
		$stmt->bindValue(':title',            $title,                  PDO::PARAM_STR);
		$stmt->bindValue(':field_gb',         $fieldGb,                PDO::PARAM_INT);
		$stmt->bindValue(':field_length',     $fieldLength,            PDO::PARAM_INT);
		$stmt->execute();

		$this->setTitle($title);
		$this->setFieldGb($fieldGb);
		$this->setFieldLength($fieldLength);

		AdminLogPeer::add($officer, AdminLog::GB_CATEGORY_BASIC_MODIFY, $this->getCategory(), $this);
	} /*}}}*/

	public function remove(AdminOfficer $officer) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'DELETE FROM module_config WHERE module_config_sq = :module_config_sq';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':module_config_sq', $this->__moduleConfigSq, PDO::PARAM_INT);
		$stmt->execute();

		AdminLogPeer::add($officer, AdminLog::GB_CATEGORY_BASIC_REMOVE, $this->getCategory(), $this);
	} /*}}}*/

	public function up(AdminOfficer $officer) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT a.view_ord this_ord, b.module_config_sq that_sq, b.view_ord that_ord
			      FROM module_config a, module_config b
		          WHERE a.module_config_sq = :module_config_sq AND a.category_sq = b.category_sq AND a.view_ord > b.view_ord
				  ORDER BY b.view_ord DESC LIMIT 1';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':module_config_sq', $this->__moduleConfigSq, PDO::PARAM_INT);
		$stmt->execute();

		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$query = 'UPDATE module_config SET view_ord = :view_ord, update_dt = now()
					  WHERE module_config_sq = :module_config_sq';
			$stmt  = $pdo->prepare($query);
			$stmt->bindValue(':module_config_sq', $this->__moduleConfigSq, PDO::PARAM_INT);
			$stmt->bindValue(':view_ord',         $row['that_ord'],        PDO::PARAM_INT);
			$stmt->execute();

			$stmt->bindValue(':module_config_sq', $row['that_sq'],  PDO::PARAM_INT);
			$stmt->bindValue(':view_ord',         $row['this_ord'], PDO::PARAM_INT);
			$stmt->execute();
		}

		AdminLogPeer::add($officer, AdminLog::GB_CATEGORY_BASIC_MODIFY, $this->getCategory(), $this);
	} /*}}}*/

	public function down(AdminOfficer $officer) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT a.view_ord this_ord, b.module_config_sq that_sq, b.view_ord that_ord
			      FROM module_config a, module_config b
		          WHERE a.module_config_sq = :module_config_sq AND a.category_sq = b.category_sq AND a.view_ord < b.view_ord
				  ORDER BY b.view_ord LIMIT 1';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':module_config_sq', $this->__moduleConfigSq, PDO::PARAM_INT);
		$stmt->execute();

		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$query = 'UPDATE module_config SET view_ord = :view_ord, update_dt = now()
					  WHERE module_config_sq = :module_config_sq';
			$stmt  = $pdo->prepare($query);
			$stmt->bindValue(':module_config_sq', $this->__moduleConfigSq, PDO::PARAM_INT);
			$stmt->bindValue(':view_ord',         $row['that_ord'],        PDO::PARAM_INT);
			$stmt->execute();

			$stmt->bindValue(':module_config_sq', $row['that_sq'],  PDO::PARAM_INT);
			$stmt->bindValue(':view_ord',         $row['this_ord'], PDO::PARAM_INT);
			$stmt->execute();
		}

		AdminLogPeer::add($officer, AdminLog::GB_CATEGORY_BASIC_MODIFY, $this->getCategory(), $this);
	} /*}}}*/

	public function getUniqueCode() /*{{{*/
	{
		return 'mcfg#' . $this->__moduleConfigSq;
	} /*}}}*/
}
?>
