<?php
class ModuleBasic extends BaseObject
{
	protected $__mdBasicSq;
	protected $__mp;
	protected $__writer;
	protected $__editGb;
	protected $__mainImgGb;
	protected $__mainImgUrl;
	protected $__content;

	private $_fields;

	const EDIT_GB_NORMAL = 1;
	const EDIT_GB_CUSTOM = 2;

	public static $editGbs = array(
	    self::EDIT_GB_NORMAL => '일반 편집',
	    self::EDIT_GB_CUSTOM => '직접 편집',
	);

	public static function instance($mdBasicSq) /*{{{*/
	{
		static $sInstance = array();

		$mdBasicSq = intval($mdBasicSq);

		if (isset($sInstance[$mdBasicSq]) === false) {
			$className             = __CLASS__;
			$mdBasic               = new $className($mdBasicSq);
			$sInstance[$mdBasicSq] = $mdBasic;
		}

		return $sInstance[$mdBasicSq];
	} /*}}}*/

	public function __construct($mdBasicSq) /*{{{*/
	{
		$this->__mdBasicSq = $mdBasicSq;
	} /*}}}*/

	/***************************************************************************
	 ***** LOAD 함수들 *********************************************************
	 **************************************************************************/

	private function _loadAllFieldData() /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT field_nm, content FROM module_field
				  WHERE module_gb = :module_gb and parent_sq = :parent_sq';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':module_gb', ModuleConfig::GB_BASIC, PDO::PARAM_INT);
		$stmt->bindValue(':parent_sq', $this->__mdBasicSq,     PDO::PARAM_INT);
		$stmt->execute();

		$this->_fields = array();
		while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$this->_fields[$row['field_nm']] = $row['content'];
		}
	} /*}}}*/

	/***************************************************************************
	 ***** ACTION 함수들 *******************************************************
	 **************************************************************************/

	public function modifyMainImg($mainImgGb, $mainImgUrl) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'UPDATE module_basic 
				  SET edit_gb = :edit_gb, mainimg_gb = :mainimg_gb, mainimg_url = :mainimg_url, update_dt = now()
				  WHERE md_basic_sq = :md_basic_sq';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':md_basic_sq', $this->__mdBasicSq,   PDO::PARAM_INT);
		$stmt->bindValue(':edit_gb',     self::EDIT_GB_NORMAL, PDO::PARAM_INT);
		$stmt->bindValue(':mainimg_gb',  $mainImgGb,           PDO::PARAM_INT);
		$stmt->bindValue(':mainimg_url', $mainImgUrl,          PDO::PARAM_STR);
		$stmt->execute();
	} /*}}}*/

	public function modifyContent($content) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'UPDATE module_basic SET edit_gb = :edit_gb, content = :content, update_dt = now()
				  WHERE md_basic_sq = :md_basic_sq';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':md_basic_sq', $this->__mdBasicSq,   PDO::PARAM_INT);
		$stmt->bindValue(':edit_gb',     self::EDIT_GB_CUSTOM, PDO::PARAM_INT);
		$stmt->bindValue(':content',     $content,             PDO::PARAM_STR);
		$stmt->execute();
	} /*}}}*/

	public function updateTextField($fieldName, $text) /*{{{*/
	{
		$this->_updateField($fieldName, $text);
	} /*}}}*/

	public function updateDateField($fieldName, $year, $month, $day) /*{{{*/
	{
		$this->_updateField($fieldName, sprintf('%04d%02d%02d', $year, $month, $day));
	} /*}}}*/

	public function updatePeriodField($fieldName, $startYear, $startMonth, $startDay, $endYear, $endMonth, $endDay) /*{{{*/
	{
		$this->_updateField($fieldName, sprintf('%04d%02d%02d-%04d%02d%02d', $startYear, $startMonth, $startDay, $endYear, $endMonth, $endDay));
	} /*}}}*/

	private function _updateField($fieldName, $text) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT md_field_sq FROM module_field
				  WHERE module_gb = :module_gb and parent_sq = :parent_sq and field_nm = :field_nm';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':module_gb', ModuleConfig::GB_BASIC, PDO::PARAM_INT);
		$stmt->bindValue(':parent_sq', $this->__mdBasicSq,     PDO::PARAM_INT);
		$stmt->bindValue(':field_nm',  $fieldName,             PDO::PARAM_STR);
		$stmt->execute();

		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$query = 'UPDATE module_field SET content = :content, update_dt = now() 
					  WHERE md_field_sq = :md_field_sq';
			$stmt  = $pdo->prepare($query);
			$stmt->bindValue(':md_field_sq', $row['md_field_sq'], PDO::PARAM_INT);
		}
		else {
			$query = 'INSERT INTO module_field
					  (module_gb, parent_sq, field_nm, content, main_fl, recent_dt, update_dt)
					  VALUES (:module_gb, :parent_sq, :field_nm, :content, :main_fl, :recent_dt, now())';
			$stmt  = $pdo->prepare($query);
			$stmt->bindValue(':module_gb', ModuleConfig::GB_BASIC, PDO::PARAM_INT);
			$stmt->bindValue(':parent_sq', $this->__mdBasicSq,     PDO::PARAM_INT);
			$stmt->bindValue(':field_nm',  $fieldName,             PDO::PARAM_STR);
			$stmt->bindValue(':main_fl',   1,                      PDO::PARAM_INT);
			$stmt->bindValue(':recent_dt', '2100-01-01 00:00:00',  PDO::PARAM_STR);
		}
		$stmt->bindValue(':content', $text, PDO::PARAM_STR);
		$stmt->execute();
	} /*}}}*/

	/***************************************************************************
	 ***** GET 함수들 **********************************************************
	 **************************************************************************/

	private function _getDataOf($fieldName) /*{{{*/
	{
		if (isset($this->_fields) === false) {
			$this->_loadAllFieldData();
		}

		if (isset($this->_fields[$fieldName])) {
			return $this->_fields[$fieldName];
		}
		else {
			return '';
		}
	} /*}}}*/

	public function getStartYearOf($fieldName) /*{{{*/
	{
		$data = $this->_getDataOf($fieldName);

		if ($data == '') {
			return '';
		}

		return intval(substr($data, 0, 4));
	} /*}}}*/

	public function getStartMonthOf($fieldName) /*{{{*/
	{
		$data = $this->_getDataOf($fieldName);

		if ($data == '') {
			return '';
		}

		return intval(substr($data, 4, 2));
	} /*}}}*/

	public function getStartDayOf($fieldName) /*{{{*/
	{
		$data = $this->_getDataOf($fieldName);

		if ($data == '') {
			return '';
		}

		return intval(substr($data, 6, 2));
	} /*}}}*/

	public function getEndYearOf($fieldName) /*{{{*/
	{
		$data = $this->_getDataOf($fieldName);

		if ($data == '') {
			return '';
		}

		return intval(substr($data, 9, 4));
	} /*}}}*/

	public function getEndMonthOf($fieldName) /*{{{*/
	{
		$data = $this->_getDataOf($fieldName);

		if ($data == '') {
			return '';
		}

		return intval(substr($data, 13, 2));
	} /*}}}*/

	public function getEndDayOf($fieldName) /*{{{*/
	{
		$data = $this->_getDataOf($fieldName);

		if ($data == '') {
			return '';
		}

		return intval(substr($data, 15, 2));
	} /*}}}*/

	public function getTextOf($fieldName) /*{{{*/
	{
		return $this->_getDataOf($fieldName);
	} /*}}}*/

	public function getUniqueCode() /*{{{*/
	{
		return 'mdbasic#' . $this->__mdBasicSq;
	} /*}}}*/
}
?>
