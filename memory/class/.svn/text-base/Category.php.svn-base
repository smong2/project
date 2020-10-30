<?php
class Category extends BaseObject
{
	protected $__categorySq;
	protected $__categoryNm;
	protected $__mpCnt;
	protected $__activateFl;
	protected $__viewOrd;
	protected $__insertDt;
	protected $__updateDt;

	private $_arrModuleConfig; // 사용모듈 정보목록, key 는 module_gb 값, value 는 ModelConfig
	private $_arrBasicField;   // 기본정보 필드목록, value 는 ModuleConfig

	const MISC_NM = '기타';

	public static function instance($categorySq) /*{{{*/
	{
		static $sInstance = array();

		$categorySq = intval($categorySq);

		if (isset($sInstance[$categorySq]) === false) {
			$className              = __CLASS__;
			$category               = new $className($categorySq);
			$sInstance[$categorySq] = $category;
		}

		return $sInstance[$categorySq];
	} /*}}}*/

	protected function __construct($categorySq) /*{{{*/
	{
		$this->__categorySq = $categorySq;
	} /*}}}*/

	/***************************************************************************
	 ***** CHECK 함수들 ********************************************************
	 **************************************************************************/

	public function haveModule($moduleGb) /*{{{*/
	{
		if (isset($this->_arrModuleConfig) === false) {
			$this->_loadModuleConfigs();
		}

		return isset($this->_arrModuleConfig[$moduleGb]);
	} /*}}}*/

	/***************************************************************************
	 ***** LOAD 함수들 *********************************************************
	 **************************************************************************/

	private function _loadModuleConfigs() /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT module_config_sq, module_gb, title, field_gb, field_length FROM module_config
				  WHERE category_sq = :category_sq ORDER BY view_ord';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':category_sq', $this->__categorySq, PDO::PARAM_INT);
		$stmt->execute();

		$this->_arrModuleConfig = array();
		$this->_arrBasicField   = array();
		while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$moduleConfig = ModuleConfig::instance($row['module_config_sq']);
			$moduleConfig->setModuleGb($row['module_gb']);
			$moduleConfig->setTitle($row['title']);
			$moduleConfig->setFieldGb($row['field_gb']);
			$moduleConfig->setFieldLength($row['field_length']);
			$moduleConfig->setCategory($this);

			if ($row['module_gb'] == ModuleConfig::GB_BASIC) {
				$this->_arrBasicField[] = $moduleConfig;
			}
			else {
				$this->_arrModuleConfig[$row['module_gb']] = $moduleConfig;
			}
		}
	} /*}}}*/

	public function load() /*{{{*/
	{
		CategoryPeer::retrieveCategoryByCategorySq($this->__categorySq);
	} /*}}}*/

	/***************************************************************************
	 ***** ACTION 함수들 *******************************************************
	 **************************************************************************/

	public function modify($categoryNm, $activateFl, array $arrModuleConfig, AdminOfficer $officer) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'UPDATE category SET category_nm = :category_nm, activate_fl = :activate_fl, update_dt = now() WHERE category_sq = :category_sq';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':category_nm', $categoryNm,         PDO::PARAM_STR);
		$stmt->bindValue(':activate_fl', $activateFl,         PDO::PARAM_INT);
		$stmt->bindValue(':category_sq', $this->__categorySq, PDO::PARAM_INT);
		$stmt->execute();

		$this->__categoryNm = $categoryNm;
		$this->__activateFl = $activateFl;

		$this->_updateModules($arrModuleConfig);

		AdminLogPeer::add($officer, AdminLog::GB_CATEGORY_MODIFY, $this);
	} /*}}}*/

	public function remove(AdminOfficer $officer) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'DELETE FROM module_config WHERE category_sq = :category_sq';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':category_sq', $this->__categorySq, PDO::PARAM_INT);
		$stmt->execute();

		$query = 'DELETE FROM category WHERE category_sq = :category_sq';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':category_sq', $this->__categorySq, PDO::PARAM_INT);
		$stmt->execute();

		AdminLogPeer::add($officer, AdminLog::GB_CATEGORY_REMOVE, $this);
	} /*}}}*/

	public function addBasicField($title, $fieldGb, $fieldLength, AdminOfficer $officer) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT count(*) cnt FROM module_config WHERE category_sq = :category_sq AND module_gb = :module_gb';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':category_sq', $this->__categorySq,    PDO::PARAM_INT);
		$stmt->bindValue(':module_gb',   ModuleConfig::GB_BASIC, PDO::PARAM_INT);
		$stmt->execute();

		$viewOrd = 1;
		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$viewOrd = $row['cnt'] + 1;
		}

		$query = 'INSERT INTO module_config (category_sq, module_gb, title, field_gb, field_length, view_ord, update_dt)
		          VALUES (:category_sq, :module_gb, :title, :field_gb, :field_length, :view_ord, now())';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':category_sq',  $this->__categorySq,    PDO::PARAM_INT);
		$stmt->bindValue(':module_gb',    ModuleConfig::GB_BASIC, PDO::PARAM_INT);
		$stmt->bindValue(':title',        $title,                 PDO::PARAM_STR);
		$stmt->bindValue(':field_gb',     $fieldGb,               PDO::PARAM_INT);
		$stmt->bindValue(':field_length', $fieldLength,           PDO::PARAM_INT);
		$stmt->bindValue(':view_ord',     $viewOrd,               PDO::PARAM_INT);
		$stmt->execute();

		$moduleConfig = ModuleConfig::instance($pdo->lastInsertId());
		$moduleConfig->setModuleGb(ModuleConfig::GB_BASIC);
		$moduleConfig->setTitle($title);
		$moduleConfig->setFieldGb($fieldGb);
		$moduleConfig->setFieldLength($fieldLength);
		$moduleConfig->setCategory($this);

		AdminLogPeer::add($officer, AdminLog::GB_CATEGORY_BASIC_ADD, $this, $moduleConfig);

		return $moduleConfig;
	} /*}}}*/

	public function increaseMpCnt() /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'UPDATE category SET mp_cnt = mp_cnt + 1, update_dt = now() WHERE category_sq = :category_sq';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':category_sq', $this->__categorySq, PDO::PARAM_INT);
		$stmt->execute();

		if (isset($this->__mpCnt)) {
			$this->__mpCnt++;
		}
	} /*}}}*/

	public function decreaseMpCnt() /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'UPDATE category SET mp_cnt = mp_cnt - 1, update_dt = now() WHERE category_sq = :category_sq';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':category_sq', $this->__categorySq, PDO::PARAM_INT);
		$stmt->execute();

		if (isset($this->__mpCnt)) {
			$this->__mpCnt--;
		}
	} /*}}}*/

	private function _updateModules(array $arrModuleConfig) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'DELETE FROM module_config WHERE category_sq = :category_sq AND module_gb <> :module_gb';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':category_sq', $this->__categorySq,    PDO::PARAM_INT);
		$stmt->bindValue(':module_gb',   ModuleConfig::GB_BASIC, PDO::PARAM_INT);
		$stmt->execute();

		$arrModuleConfigObj = array();
		foreach ($arrModuleConfig as $moduleConfig) {
			$query = 'INSERT INTO module_config (category_sq, module_gb, title, update_dt) 
					  VALUES (:category_sq, :module_gb, :title, now())';
			$stmt  = $pdo->prepare($query);
			$stmt->bindValue(':category_sq', $this->__categorySq,       PDO::PARAM_INT);
			$stmt->bindValue(':module_gb',   $moduleConfig['moduleGb'], PDO::PARAM_INT);
			$stmt->bindValue(':title',       $moduleConfig['title'],    PDO::PARAM_STR);
			$stmt->execute();

			$moduleConfigObj = ModuleConfig::instance($pdo->lastInsertId());
			$moduleConfigObj->setModuleGb($moduleConfig['moduleGb']);
			$moduleConfigObj->setTitle($moduleConfig['title']);
			$moduleConfigObj->setCategory($this);

			$arrModuleConfigObj[$moduleConfig['moduleGb']] = $moduleConfigObj;
		}

		$this->_arrModuleConfig = $arrModuleConfigObj;
	} /*}}}*/

	/***************************************************************************
	 ***** GET 함수들 **********************************************************
	 **************************************************************************/

	/**
	 * $moduleGb 에 해당하는 모듈 설정 정보를 반환한다.
	 * 
	 * @return ModuleConfig or null
	 */
	public function getModuleConfig($moduleGb) /*{{{*/
	{
		if ($this->haveModule($moduleGb)) {
			return $this->_arrModuleConfig[$moduleGb];
		}
		else {
			return null;
		}
	} /*}}}*/

	/**
	 * 모든 기본 정보 항목을 반환한다.
	 * 
	 * @return array
	 */
	public function getBasicFields() /*{{{*/
	{
		if (isset($this->_arrBasicField) === false) {
			$this->_loadModuleConfigs();
		}

		return $this->_arrBasicField;
	} /*}}}*/

	/**
	 * $moduleConfigSq 에 해당하는 기본 정보 항목을 반환한다.
	 * 주의. 함수 호출마다 DB Query 발생함
	 * 
	 * @return ModuleConfig or null
	 */
	public function getBasicField($moduleConfigSq) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT module_gb, title, field_gb, field_length FROM module_config
				  WHERE module_config_sq = :module_config_sq ORDER BY view_ord';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':module_config_sq', $moduleConfigSq, PDO::PARAM_INT);
		$stmt->execute();

		$moduleConfig = null;
		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$moduleConfig = ModuleConfig::instance($moduleConfigSq);
			$moduleConfig->setModuleGb($row['module_gb']);
			$moduleConfig->setTitle($row['title']);
			$moduleConfig->setFieldGb($row['field_gb']);
			$moduleConfig->setFieldLength($row['field_length']);
			$moduleConfig->setCategory($this);
		}

		return $moduleConfig;
	} /*}}}*/

	/**
	 * 명XX 모듈에서 사용할 타이틀을 반환한다.
	 */
	public function getLinesModuleTitle() /*{{{*/
	{
		if ($this->haveModule(ModuleConfig::GB_LINES)) {
			return $this->_arrModuleConfig[ModuleConfig::GB_LINES]->getTitle();
		}
		else {
			return '';
		}
	} /*}}}*/

	/**
	 * AdminLog 에서 사용하기 위한 UniqueCode 를 반환한다.
	 */
	public function getUniqueCode() /*{{{*/
	{
		return 'cate#' . $this->__categorySq;
	} /*}}}*/
}
?>
