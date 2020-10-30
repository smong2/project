<?php
class Admin_MpController extends AdminController
{
	public function __preProcessor() /*{{{*/
	{
		parent::__preProcessor();
		$this->checkAuthOf(AdminMenu::GB_MP);
	} /*}}}*/

	public function doIndex() /*{{{*/
	{
		$page = isset($this->request->page) ? $this->request->page : 1;
		if ($page < 1) {
			$page = 1;
		}

		$cnt = MpPeer::countMps(true);

		$numPerPage = 20;
		$maxPage    = max((int)(($cnt-1)/$numPerPage)+1, 1);
		if ($page > $maxPage) {
			$page = $maxPage;
		}

		// 카테고리 정보를 미리 읽어와서 인스턴스 값을 채워놓기 위함
		CategoryPeer::retrieveCategories();

		$this->response->page    = $page;
		$this->response->maxPage = $maxPage;
		$this->response->mps     = MpPeer::retrieveMps($page, $numPerPage, true);
	} /*}}}*/

	public function doAdd() /*{{{*/
	{
		$this->response->categories = CategoryPeer::retrieveCategories();
	} /*}}}*/

	public function doAddProc() /*{{{*/
	{
		$mp = new Mp();
		$mp->setCategory(Category::instance($this->request->category_sq));
		$mp->setCategoryMiscNm($this->request->category_misc_nm);
		$mp->setMpNm($this->request->mp_nm);
		$mp->setCreator($this->myOfficer->user);
		$mp->setContent($this->request->content);
		$mp->setCreatorNick($this->myOfficer->user->nate->getNickname());
		$validCode = $mp->validate();

		if ($validCode !== Mp::VALIDATED) {
			$this->alertAndGoBack(Mp::$errmsg[$validCode]);
		}

		$timeTag = new TimeTag();
		$timeTag->setUser($this->myOfficer->user);
		$timeTag->setInsertDt(time());
		$timeTag->setTimeTagGb($this->request->timetag_gb);
		$timeTag->setCustom($this->request->timetag_year, $this->request->timetag_month, $this->request->timetag_day);
		$timeTag->setTheDay($this->request->timetag_theday);
		$timeTag->setAgo($this->request->timetag_ago);
		$timeTag->setAges($this->request->timetag_ages);
		$validCode = $timeTag->validate();

		if ($validCode !== TimeTag::VALIDATED) {
			$this->alertAndGoBack(TimeTag::$errmsg[$validCode]);
		}

		$mp->setTimeTag($timeTag);
		$mp->doAdd();

		AdminLogPeer::add($this->myOfficer, AdminLog::GB_MP_ADD, $mp);

		$this->response->setRedirect('add');
	} /*}}}*/

	public function doUpdateStatus() /*{{{*/
	{
		$mp = MpPeer::_retrieveMpByMpSq($this->request->mp_sq);
		$this->response->mp = $mp;
	} /*}}}*/

	public function doMpRss()
	{
		$page = isset($this->request->page) ? $this->request->page : 1;
		if ($page < 1) {
			$page = 1;
		}

		$cnt = MpPeer::countMps(true);

		$numPerPage = 10;
		$maxPage    = max((int)(($cnt-1)/$numPerPage)+1, 1);
		if ($page > $maxPage) {
			$page = $maxPage;
		}

		// 카테고리 정보를 미리 읽어와서 인스턴스 값을 채워놓기 위함
		CategoryPeer::retrieveCategories();

		$this->response->page    = $page;
		$this->response->maxPage = $maxPage;
		$this->response->mps     = MpPeer::retrieveMps($page, $numPerPage, true);
	}

	public function doUpdateStatusProc() /*{{{*/
	{
		if ($this->request->reason_gb === '') {
			$this->alertAndGoBack('유형을 입력해주세요.');
		}

		$mp = MpPeer::retrieveMpByMpSq($this->request->mp_sq);

		switch ($this->request->status_gb) {
			case MpPolice::STATUS_GB_NORMAL:
				$mp->recovery($this->myOfficer);
				break;

			case MpPolice::STATUS_GB_BLOCKED:
				$mp->block($this->request->reason_gb, $this->request->content, $this->myOfficer);
				break;

			case MpPolice::STATUS_GB_TRASH:
				$mp->trashByAdmin($this->request->reason_gb, $this->request->content, $this->myOfficer);
				break;
		}

		echo '<script type="text/javascript" language="javascript">try {opener.location.reload();} catch (e) { } window.close();</script>';
	} /*}}}*/

	public function doModify() /*{{{*/
	{
		$mp          = MpPeer::retrieveMpByMpSq($this->request->mp_sq);
		$moduleBasic = $mp->getMainModuleBasic();
		if ($moduleBasic) {
			$editGb = $moduleBasic->getEditGb();
		}
		else if (count($mp->getCategory()->getBasicFields()) > 0) {
			$editGb = ModuleBasic::EDIT_GB_NORMAL;
		}
		else {
			$editGb = ModuleBasic::EDIT_GB_CUSTOM;
		}

		$this->response->mp          = $mp;
		$this->response->categories  = CategoryPeer::retrieveCategories();
		$this->response->editGb      = $editGb;
		$this->response->moduleBasic = $moduleBasic ? $moduleBasic : new NullModuleBasic(0);
	} /*}}}*/

	public function doModifyProc() /*{{{*/
	{
		$mp = MpPeer::retrieveMpByMpSq($this->request->mp_sq);
		$mp->setCategory(Category::instance($this->request->category_sq));
		$mp->setCategoryMiscNm($this->request->category_misc_nm);
		$mp->setContent($this->request->content);
		$validCode = $mp->validate(true);

		if ($validCode !== Mp::VALIDATED) {
			$this->alertAndGoBack(Mp::$errmsg[$validCode]);
		}

		$mp->getCreator()->loadNateInfo();

		$timeTag = $mp->getTimeTag();
		$timeTag->setUser($mp->getCreator());
		$timeTag->setInsertDt($mp->getInsertDt());
		$timeTag->setData(null); // 기존의 data field 값이 무의미하므로 data 를 리셋시켜줘야 한다.
		$timeTag->setTimeTagGb($this->request->timetag_gb);
		$timeTag->setCustom($this->request->timetag_year, $this->request->timetag_month, $this->request->timetag_day);
		$timeTag->setTheDay($this->request->timetag_theday);
		$timeTag->setAgo($this->request->timetag_ago);
		$timeTag->setAges($this->request->timetag_ages);
		$validCode = $timeTag->validate();

		if ($validCode !== TimeTag::VALIDATED) {
			$this->alertAndGoBack(TimeTag::$errmsg[$validCode]);
		}

		$mp->doModify();

		AdminLogPeer::add($this->myOfficer, AdminLog::GB_MP_MODIFY, $mp);

		$this->response->setRedirect('modify?mp_sq='.$this->request->mp_sq);
	} /*}}}*/

	public function doAddMainImage() /*{{{*/
	{
	} /*}}}*/

	public function doModifyBasicProc() /*{{{*/
	{
		$mp = MpPeer::retrieveMpByMpSq($this->request->mp_sq);

		if ($this->request->edit_gb == ModuleBasic::EDIT_GB_NORMAL) {
			// Request 파라미터 체크
			if ($this->request->mainimg_gb == '' || $this->request->mainimg_url == '') {
				$this->alertAndGoBack('메인 이미지를 입력해주세요.');
			}

			$basicFields = $mp->getCategory()->getBasicFields();

			foreach ($basicFields as $basicField) {
				$mdConfigSq = $basicField->getModuleConfigSq();

				switch ($basicField->getFieldGb()) {
					case ModuleConfig::FIELD_GB_TEXT:
						if ($this->request->text[$mdConfigSq] == '') {
							$this->alertAndGoBack($basicField->getTitle().' 항목을 입력해주세요.');
						}
						break;

					case ModuleConfig::FIELD_GB_DATE:
						if ($this->request->start_year[$mdConfigSq] == '') {
							$this->alertAndGoBack($basicField->getTitle().' 항목을 입력해주세요.');
						}
						break;

					case ModuleConfig::FIELD_GB_PERIOD:
						if ($this->request->start_year[$mdConfigSq] == '' || $this->request->end_year[$mdConfigSq] == '') {
							$this->alertAndGoBack($basicField->getTitle().' 항목을 입력해주세요.');
						}
						break;
				}
			}

			// 메인이미지 설정
			$mdBasic = $mp->getMainModuleBasic();
			if (!$mdBasic) {
				$mdBasic = $mp->addModuleBasic($this->myOfficer->user, true);
			}
			$mdBasic->modifyMainImg($this->request->mainimg_gb, $this->request->mainimg_url);

			// 필드 항목 설정
			foreach ($basicFields as $basicField) {
				$mdConfigSq = $basicField->getModuleConfigSq();
				$fieldGb    = $basicField->getFieldGb();

				switch ($fieldGb) {
					case ModuleConfig::FIELD_GB_TEXT:
						$mdBasic->updateTextField($basicField->getTitle(), $this->request->text[$mdConfigSq]);
						break;

					case ModuleConfig::FIELD_GB_DATE:
						$mdBasic->updateDateField($basicField->getTitle(), $this->request->start_year[$mdConfigSq], $this->request->start_month[$mdConfigSq], $this->request->start_day[$mdConfigSq]);
						break;

					case ModuleConfig::FIELD_GB_PERIOD:
						$mdBasic->updateDateField($basicField->getTitle(), $this->request->start_year[$mdConfigSq], $this->request->start_month[$mdConfigSq], $this->request->start_day[$mdConfigSq], $this->request->end_year[$mdConfigSq], $this->request->end_month[$mdConfigSq], $this->request->end_day[$mdConfigSq]);
						break;
				}
			}
		}
		else {
			// Request 파라미터 설정
			if ($this->request->content == '') {
				$this->alertAndGoBack('직접 편집 내용을 입력해주세요.');
			}

			// 직접 입력 설정
			$mdBasic = $mp->getMainModuleBasic();
			if (!$mdBasic) {
				$mdBasic = $mp->addModuleBasic($this->myOfficer->user, true);
			}
			$mdBasic->modifyContent($this->request->content);
		}

		AdminLogPeer::add($this->myOfficer, AdminLog::GB_MP_MODIFY, $mdBasc);

		$this->response->setRedirect('modify?mp_sq='.$this->request->mp_sq);
	} /*}}}*/

	/**
	 * 삭제 대기함
	 */
	public function doTrash() /*{{{*/
	{
		$page = isset($this->request->page) ? $this->request->page : 1;
		if ($page < 1) {
			$page = 1;
		}

		$cnt = MpPolicePeer::countMpPolices($this->req->mp_nm, $this->req->reason_gb, $this->req->status_gb);

		$numPerPage = 20;
		$maxPage    = max((int)(($cnt-1)/$numPerPage)+1, 1);

		if ($page > $maxPage) {
			$page = $maxPage;
		}

		$this->response->cnt       = $cnt;
		$this->response->page      = $page;
		$this->response->maxPage   = $maxPage;
		$this->response->mpPolices = MpPolicePeer::retrieveMpPolicesByPage($page, $numPerPage, $this->req->mp_nm, $this->req->reason_gb, $this->req->status_gb);
	} /*}}}*/

	function doTrashRemoveProc() /*{{{*/
	{
		/* 삭제대기함 삭제 버튼 클릭시 이벤트 */
		Mp::instance($this->request->MpSq)->load()->remove($this->myOfficer);

		// 삭제후에 해당 페이지로 이동하도록 수정
		$this->response->setRedirect('trash?page='.$this->request->page);
	} /*}}}*/
}
?>
