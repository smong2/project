<?php
class AdminController extends BaseController
{
	public function __preProcessor() /*{{{*/
	{
		parent::__preProcessor();

		$this->redirectLoginPage();

		if (AdminOfficerPeer::isOfficerByUserId($this->myUser->getUserId()) === false) {
			echo $this->myUser->getRealNameAndIdStr() . ' - <' . $this->myUser->getUserId() . '>님은 이 페이지에 접근할 수 있는 권한이 없습니다.<br />올바른 아이디로 접속하였는지 확인해 주시기 바랍니다.<br /><a href="http://www.nate.com/">네이트 바로가기</a> | <a href="http://xso.nate.com/rlogout.jsp?redirect=http://memory.nate.com/admin/index">재로그인 하기</a>';
			exit;
		}

		// AdminController 에서는 $this->myUser 대신 $this->myOfficer->user 를 사용하도록 한다.
		$this->myOfficer           = AdminOfficer::instance($this->myUser->getUserId());
		$this->response->myOfficer = $this->myOfficer;
		unset($this->myUser);
		unset($this->response->myUser);
	} /*}}}*/

	/**
	 * 메인 페이지
	 */
	public function doIndex() /*{{{*/
	{
		$this->myOfficer->updateLastUpdateDt();
		AdminLogPeer::add($this->myOfficer, AdminLog::GB_ACCESS);
	} /*}}}*/

	public function doTopMenu() /*{{{*/
	{
	} /*}}}*/

	public function doLeftMenu() /*{{{*/
	{
	} /*}}}*/

	public function doHome() /*{{{*/
	{
	} /*}}}*/

	public function doOfficer() /*{{{*/
	{
		$this->checkAuthOf(AdminMenu::GB_OFFICER);

		$this->response->officers = AdminOfficerPeer::retrieveAdminOfficers();
	} /*}}}*/

	public function doOfficerAddProc() /*{{{*/
	{
		$this->checkAuthOf(AdminMenu::GB_OFFICER);

		if ($this->request->nate_id === '') {
			$this->alertAndGoBack('아이디를 입력해 주세요.');
		}

		$user = UserPeer::retrieveNateInfoByUserId($this->request->nate_id);

		if ($user === null) {
			$this->alertAndGoBack('입력하신 사용자를 찾을 수 없습니다. 이는 아이디를 잘못 입력하지 않았는지 확인해 보시고, 올바른 아이디인 경우에는 시스템 관리자에게 문의해주시기 바랍니다.');
		}

		if (AdminOfficerPeer::isOfficerByUserId($user->getUserId())) {
			$this->alertAndGoBack('입력하신 사용자는 이미 관리자로 등록되어 있습니다.');
		}
		else {
			AdminOfficerPeer::add($user, $this->myOfficer);
		}

		$this->response->setRedirect('officer');
	} /*}}}*/

	public function doOfficerRemoveProc() /*{{{*/
	{
		$this->checkAuthOf(AdminMenu::GB_OFFICER);

		$officer = AdminOfficer::instance($this->request->user_id);
		$officer->dismiss($this->myOfficer);

		$this->response->setRedirect('officer');
	} /*}}}*/

	public function doAuthByOfficer() /*{{{*/
	{
		$this->checkAuthOf(AdminMenu::GB_AUTH);

		$currUser = $this->myOfficer;
		if (isset($this->request->user_id)) {
			$currUser = AdminOfficer::instance($this->request->user_id);
		}

		$this->response->officers = AdminOfficerPeer::retrieveAdminOfficers();
		$this->response->currUser = $currUser;
	} /*}}}*/

	public function doAuthByOfficerUpdateProc() /*{{{*/
	{
		$this->checkAuthOf(AdminMenu::GB_AUTH);

		$arrAuthGb = array();
		if (isset($this->request->menus)) {
			$arrAuthGb = $this->request->menus;
		}

		AdminOfficer::instance($this->request->user_id)->updateAuth($arrAuthGb, $this->myOfficer);

		$this->response->setRedirect('authByOfficer?user_id='.$this->request->user_id);
	} /*}}}*/

	public function doAuthByMenu() /*{{{*/
	{
		$this->checkAuthOf(AdminMenu::GB_AUTH);

		$currMenuGb = AdminMenu::GB_AUTH;
		if (isset($this->request->menu_gb)) {
			$currMenuGb = $this->request->menu_gb;
		}
		$currMenu = AdminMenu::instance($currMenuGb);

		$this->response->officers = AdminOfficerPeer::retrieveAdminOfficers();
		$this->response->currMenu = $currMenu;
	} /*}}}*/

	public function doAuthByMenuUpdateProc() /*{{{*/
	{
		$this->checkAuthOf(AdminMenu::GB_AUTH);

		$arrOfficerId = array();
		if (isset($this->request->officers)) {
			$arrOfficerId = $this->request->officers;
		}

		AdminMenu::instance($this->request->menu_gb)->updateAuth($arrOfficerId, $this->myOfficer);

		$this->response->setRedirect('authByMenu?menu_gb='.$this->request->menu_gb);
	} /*}}}*/

	public function doLog() /*{{{*/
	{
		$this->checkAuthOf(AdminMenu::GB_LOG);

		$page = isset($this->request->page) ? $this->request->page : 1;
		if ($page < 1) {
			$page = 1;
		}

		AdminOfficerPeer::retrieveAdminOfficers();
		$cnt = AdminLogPeer::countAdminLogs();

		$numPerPage = 20;
		$maxPage    = max((int)(($cnt-1)/$numPerPage)+1, 1);
		if ($page > $maxPage) {
			$page = $maxPage;
		}

		$this->response->page    = $page;
		$this->response->maxPage = $maxPage;
		$this->response->logs    = AdminLogPeer::retrieveAdminLogs($page, $numPerPage);
	} /*}}}*/

	protected function checkAuthOf($menuGb) /*{{{*/
	{
		if ($this->myOfficer->haveAuthOf($menuGb)) {
			return;
		}

		echo $this->myOfficer->user->getRealNameAndIdStr() . '님은 이 페이지에 접근할 수 있는 권한이 없습니다.';
		exit;
	} /*}}}*/

	public function doPost() /*{{{*/
	{
		AdminPost::Admin_Post();
	} /*}}}*/
}
?>
