<?php
class Admin_CategoryController extends AdminController
{
	public function __preProcessor() /*{{{*/
	{
		parent::__preProcessor();
		$this->checkAuthOf(AdminMenu::GB_CATEGORY);
	} /*}}}*/

	public function doIndex() /*{{{*/
	{
		$this->response->categories = CategoryPeer::retrieveCategories();
	} /*}}}*/

	public function doAddProc() /*{{{*/
	{
		if ($this->request->category_nm === '') {
			$this->alertAndGoBack('카테고리명을 입력해 주세요.');
		}

		if (CategoryPeer::add($this->request->category_nm, $this->myOfficer) === false) {
			$this->alertAndGoBack('알수 없는 오류로 카테고리를 추가하지 못했습니다. 입력한 카테고리명이 이미 등록되어있지 않은지 확인해 주세요.');
		}

		$this->response->setRedirect('index');
	} /*}}}*/

	public function doModify() /*{{{*/
	{
		$category = CategoryPeer::retrieveCategoryByCategorySq($this->request->category_sq);

		$this->response->category = $category;
	} /*}}}*/

	public function doModifyProc() /*{{{*/
	{
		if ($this->request->category_nm === '') {
			$this->alertAndGoBack('카테고리명을 입력해 주세요.');
		}

		$activateFl = isset($this->request->activate_fl) ? $this->request->activate_fl : 0;
		$modules    = isset($this->request->modules) ? $this->request->modules : array();
		$linesTitle = $this->request->lines_title === '직접입력' ? $this->request->lines_title_custom : $this->request->lines_title;

		if (isset($this->request->modules) && in_array(ModuleConfig::GB_LINES, $this->request->modules) && $linesTitle === '') {
			$this->alertAndGoBack('명대사 설정의 타이틀을 입력해주세요.');
		}

		$arrModuleConfig = array();
		foreach ($modules as $moduleGb) {
			$moduleConfig = array('moduleGb' => $moduleGb);
			if ($moduleGb == ModuleConfig::GB_LINES) {
				$moduleConfig['title'] = $linesTitle;
			}
			else {
				$moduleConfig['title'] = '';
			}
			$arrModuleConfig[] = $moduleConfig;
		}

		$category = Category::instance($this->request->category_sq);
		$category->modify($this->request->category_nm, $activateFl, $arrModuleConfig, $this->myOfficer);

		$this->response->setRedirect('modify?category_sq='.$category->getCategorySq());
	} /*}}}*/

	public function doAddBasicField() /*{{{*/
	{
		$category = CategoryPeer::retrieveCategoryByCategorySq($this->request->category_sq);

		$this->response->category            = $category;
		$this->response->selectedFieldGb     = ModuleConfig::FIELD_GB_TEXT;
		$this->response->selectedFieldLength = 20;
	} /*}}}*/

	public function doAddBasicFieldProc() /*{{{*/
	{
		if ($this->request->title === '') {
			$this->alertAndGoBack('타이틀을 입력해주세요.');
		}

		if ($this->request->field_gb == ModuleConfig::FIELD_GB_TEXT) {
			if ($this->request->field_length === '') {
				$this->alertAndGoBack('텍스트 최대 글자수를 입력해주세요.');
			}

			$fieldLength = $this->request->field_length;
		}
		else {
			$fieldLength = $this->request->field_date;
		}

		$category = CategoryPeer::retrieveCategoryByCategorySq($this->request->category_sq);
		$category->addBasicField($this->request->title, $this->request->field_gb, $fieldLength, $this->myOfficer);

		echo '<script type="text/javascript" language="javascript">try {opener.location.reload();} catch (e) { } document.location.replace(\'addBasicField?category_sq='.$this->request->category_sq.'\');</script>';
		exit;
	} /*}}}*/

	public function doModifyBasicField() /*{{{*/
	{
		$category     = CategoryPeer::retrieveCategoryByCategorySq($this->request->category_sq);
		$moduleConfig = $category->getBasicField($this->request->module_config_sq);

		$this->response->setViewName('Admin_Category_AddBasicField');
		$this->response->category            = $category;
		$this->response->moduleConfig        = $moduleConfig;
		$this->response->selectedFieldGb     = $moduleConfig->getFieldGb();
		$this->response->selectedFieldLength = $moduleConfig->getFieldLength();
	} /*}}}*/

	public function doModifyBasicFieldProc() /*{{{*/
	{
		if ($this->request->title === '') {
			$this->alertAndGoBack('타이틀을 입력해주세요.');
		}

		if ($this->request->field_gb == ModuleConfig::FIELD_GB_TEXT) {
			if ($this->request->field_length === '') {
				$this->alertAndGoBack('텍스트 최대 글자수를 입력해주세요.');
			}

			$fieldLength = $this->request->field_length;
		}
		else {
			$fieldLength = $this->request->field_date;
		}

		$category     = CategoryPeer::retrieveCategoryByCategorySq($this->request->category_sq);
		$moduleConfig = $category->getBasicField($this->request->module_config_sq);
		$moduleConfig->modify($this->request->title, $this->request->field_gb, $fieldLength, $this->myOfficer);

		echo '<script type="text/javascript" language="javascript">try {opener.location.reload();} catch (e) { } window.close();</script>';
		exit;
	} /*}}}*/

	public function doRemoveBasicFieldProc() /*{{{*/
	{
		$moduleConfig = ModuleConfig::instance($this->request->module_config_sq);
		$moduleConfig->setCategory(Category::instance($this->request->category_sq));
		$moduleConfig->remove($this->myOfficer);

		$this->response->setRedirect('modify?category_sq='.$this->request->category_sq);
	} /*}}}*/

	public function doUpBasicFieldProc() /*{{{*/
	{
		$moduleConfig = ModuleConfig::instance($this->request->module_config_sq);
		$moduleConfig->setCategory(Category::instance($this->request->category_sq));
		$moduleConfig->up($this->myOfficer);

		$this->response->setRedirect('modify?category_sq='.$this->request->category_sq);
	} /*}}}*/

	public function doDownBasicFieldProc() /*{{{*/
	{
		$moduleConfig = ModuleConfig::instance($this->request->module_config_sq);
		$moduleConfig->setCategory(Category::instance($this->request->category_sq));
		$moduleConfig->down($this->myOfficer);

		$this->response->setRedirect('modify?category_sq='.$this->request->category_sq);
	} /*}}}*/

	public function doRemove() /*{{{*/
	{
		$category = Category::instance($this->request->category_sq);
		$category->remove($this->myOfficer);

		$this->response->setRedirect('index');
	} /*}}}*/
}
?>
