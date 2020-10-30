<?php
class MpController extends BaseController
{
	public function __preProcessor() /*{{{*/
	{
		parent::__preProcessor();
	} /*}}}*/

	public function doIndex() /*{{{*/
	{
		$this->response->setRedirect('list');
	} /*}}}*/

	/**
	 * 목록 페이지
	 */
	public function doList() /*{{{*/
	{
		$this->request->setDefault(array('category_sq' => '', 'page' => 1, 'timetag_gb' => '', 'timetag_data' => '', 'order' => 'mp_sq'));

		$page = min(max($this->request->page, 1), 12);

		$timeTag = new TimeTag();
		$timeTag->setTimeTagGb($this->request->timetag_gb);
		$timeTag->setTimeTagData($this->request->timetag_data);

		if ($this->request->timetag_gb == '' && $this->request->category_sq == '') {
			$mps   = MpPeer::retrieveMps($page, 9, false, $this->request->order);
			$mpCnt = MpPeer::countMps();
		}
		else {
			$mps   = MpPeer::retrieveMpsByCategorySqAndTimeTag($this->request->category_sq, $this->request->timetag_gb, $this->request->timetag_data, $this->request->order, $page, 9);
			$mpCnt = MpPeer::countMpsByCategorySqAndTimeTag($this->request->category_sq, $this->request->timetag_gb, $this->request->timetag_data);
		}

		$this->response->mpCnt   = $mpCnt;
		$this->response->mps     = $mps;
		$this->response->timeTag = $timeTag;
	} /*}}}*/

	/**
	 * 검색 페이지
	 */
	public function doSearch() /*{{{*/
	{
	} /*}}}*/

	/**
	 * 자세히 보기 페이지
	 */
	public function doView() /*{{{*/
	{
		$this->response->mp = Mp::instance($this->request->mp_sq)->load();
	} /*}}}*/

	/**
	 * MP 생성 페이지
	 */
	public function doCreate() /*{{{*/
	{
		$this->redirectLoginPage();

		$this->response->categories = CategoryPeer::retrieveActivatedCategories();
	} /*}}}*/

	/**
	 * MP 생성 프로세스
	 */
	public function doCreateProc() /*{{{*/
	{
		// MP 객체 생성
		$mp = new Mp();
		$mp->setCreator($this->myUser);
		$mp->setCreatorNick($this->myUser->getNickname());
		$mp->setMpNm($this->request->mp_nm);
		$mp->setCategory(Category::instance($this->request->category_sq));
		$mp->setCategoryMiscNm($this->request->category_misc_nm);

		// MP 유효성 체크
		$validCode = $mp->validate();
		if ($validCode !== Mp::VALIDATED) {
			$this->alertAndGoBack(Mp::$errmsg[$validCode]);
		}

		// 타임 태그 객체 생성
		$timeTag = new TimeTag();
		$timeTag->setUser($this->myUser);
		$timeTag->setInsertDt(time());
		$timeTag->setTimeTagGb($this->request->timetag_gb);
		$timeTag->setCustom($this->request->timetag_year, $this->request->timetag_month, $this->request->timetag_day);
		$timeTag->setTheDay($this->request->timetag_theday);
		$timeTag->setAgo($this->request->timetag_ago);
		$timeTag->setAges($this->request->timetag_ages);

		// 타임 태그 유효성 체크
		$validCode = $timeTag->validate();
		if ($validCode !== TimeTag::VALIDATED) {
			$this->alertAndGoBack(TimeTag::$errmsg[$validCode]);
		}

		// MT 객체 생성
		$mt = new Mt();
		$mt->setWriter($this->myUser);
		$mt->setWriterNick($this->myUser->getNickname());
		$mt->setContent($this->request->content);
		$mt->setTimeTag($timeTag);
		$mt->setParentMt(false);

		// MT 유효성 체크
		if ($this->request->content == '') {
			$this->alertAndGoBack('간략한 소개말을 입력해 주세요.');
		}

		// MP 데이타 DB에 기록
		$mp->setTimeTag(clone$timeTag);
		$mp->doAdd();

		// MT 데이타 DB에 기록
		$mp->addMt($mt);

		$this->response->setRedirect('list');
	} /*}}}*/

	/**
	 * 나도 기억나 프로세스
	 */
	public function doCommentProc() /*{{{*/
	{
	} /*}}}*/

	/**
	 * AJAX (HTML): 유사한 MP 타이틀 목록
	 */
	public function doGetSimilarMps() /*{{{*/
	{
		// 파라미터 체크
		if (isset($this->request->mp_nm) === false) {
			$this->json->result = false;
			exit;
		}

		// 카테고리 정보를 미리 읽어온다.
		CategoryPeer::retrieveCategories();

		// 카테고리를 선택한 경우 중복 체크
		if ($this->request->category_sq) {
			$creatable = (MpPeer::countMpsByCategorySqAndMpNm($this->request->category_sq, $this->request->mp_nm) <= 0);
		}
		else {
			$creatable = true;
		}

		// 이미 같은 기억이 있는 카테고리 목록 정리
		$mps = MpPeer::retrieveMpsByMpNm($this->request->mp_nm);

		$arrDisableCategorySq = array();
		foreach ($mps as $mp) {
			$arrDisableCategorySq[] = $mp->getCategory()->getCategorySq();
		}
		$arrDisableCategorySq = array_unique($arrDisableCategorySq);

		// MP 목록에 유사한 MP들 추가
		$similarMps = MpPeer::retrieveSimilarMpsByMpNm($this->request->mp_nm);
		foreach ($similarMps as $k=>$v) {
			if ($v->getMpNm() != $this->request->mp_nm) {
				$mps[] = $v;
			}
		}

		$mps = array_slice($mps, 0, 20);

		// 반환할 HTML 을 생성
		$html = '';

		if ($creatable == false) {
			$html .= '※ ' . Category::instance($this->request->category_sq)->getCategoryNm() . ' 카테고리 내에 같은 기억이 있습니다.';
		}
		else if (count($mps) <= 0) {
			$html .= '※ 유사한 기억이 없으므로 기억을 만들 수 있습니다.';
		}

		$html .= '<table cellspacing="0" cellpadding="5" border="1">';
		foreach ($mps as $mp) {
			$html .= '
<tr>
	<td>' . $mp->getCategory()->getCategoryNm() . ' &gt; ' . htmlspecialchars($mp->getMpNm()) . '</td>
	<td>기억한 사람 ' . number_format($mp->getMemorizeCnt()) . '명</td>
	<td>생성일 ' . date('Y.m.d', $mp->getInsertDt()) . '</td>
</tr>
';
		}

		$html .= '</table>';

		// JSON 반환 값 정리
		$this->json->result               = true;
		$this->json->html                 = $html;
		$this->json->arrDisableCategorySq = $arrDisableCategorySq;
	} /*}}}*/

	public function doAddTalkProc() /*{{{*/
	{
		$this->request->setDefault(array('mp_sq' => null,
		                                 'timetag_gb' => null,
		                                 'timetag_year' => '',
		                                 'timetag_day' => '',
		                                 'timetag_theday' => '',
		                                 'timetag_ago' => '',
		                                 'timetag_ages' => '',
		                                 'parent_mt_sq' => '',
		                                 'content' => null,
		                                ));

		if (isset($this->request->mp_sq) === false ||
		        isset($this->request->timetag_gb) === false ||
		        isset($this->request->content) === false) {
			exit;
		}

		// 타임 태그 객체 생성
		$timeTag = new TimeTag();
		$timeTag->setUser($this->myUser);
		$timeTag->setInsertDt(time());
		$timeTag->setTimeTagGb($this->request->timetag_gb);
		$timeTag->setCustom($this->request->timetag_year, $this->request->timetag_month, $this->request->timetag_day);
		$timeTag->setTheDay($this->request->timetag_theday);
		$timeTag->setAgo($this->request->timetag_ago);
		$timeTag->setAges($this->request->timetag_ages);

		// 타임 태그 유효성 체크
		$validCode = $timeTag->validate();
		if ($validCode !== TimeTag::VALIDATED) {
			$this->alertAndGoBack(TimeTag::$errmsg[$validCode]);
		}

		// MT 객체 생성
		$mt = new Mt();
		$mt->setWriter($this->myUser);
		$mt->setWriterNick($this->myUser->getNickname());
		$mt->setContent($this->request->content);
		$mt->setTimeTag($timeTag);
		$mt->setParentMt(false);

		// MT 유효성 체크
		if ($this->request->content == '') {
			$this->alertAndGoBack('간략한 소개말을 입력해 주세요.');
		}

		// MP 객체 생성
		$mp = Mp::instance($this->request->mp_sq)->load();

		// MP 유효성 체크
		if ($mp === null) {
			$this->alertAndGoBack('알수 없는 오류가 발생하였습니다.');
		}

		// MT 추가
		$mp->addMt($mt);

		// MP 자세히보기 페이지로 이동
		$this->response->setRedirect('view?mp_sq='.$this->request->mp_sq);
	} /*}}}*/

	public function doAddTalkChildProc() /*{{{*/
	{
		$this->request->setDefault(array('mt_sq' => null,
		                                 'timetag_gb' => null,
		                                 'timetag_year' => '',
		                                 'timetag_day' => '',
		                                 'timetag_theday' => '',
		                                 'timetag_ago' => '',
		                                 'timetag_ages' => '',
		                                 'parent_mt_sq' => '',
		                                 'content' => null,
		                                ));

		if (isset($this->request->mt_sq) === false ||
		        isset($this->request->timetag_gb) === false ||
		        isset($this->request->content) === false) {
			exit;
		}

		// 타임 태그 객체 생성
		$timeTag = new TimeTag();
		$timeTag->setUser($this->myUser);
		$timeTag->setInsertDt(time());
		$timeTag->setTimeTagGb($this->request->timetag_gb);
		$timeTag->setCustom($this->request->timetag_year, $this->request->timetag_month, $this->request->timetag_day);
		$timeTag->setTheDay($this->request->timetag_theday);
		$timeTag->setAgo($this->request->timetag_ago);
		$timeTag->setAges($this->request->timetag_ages);

		// 타임 태그 유효성 체크
		$validCode = $timeTag->validate();
		if ($validCode !== TimeTag::VALIDATED) {
			$this->alertAndGoBack(TimeTag::$errmsg[$validCode]);
		}

		// MT 객체 생성
		$mt = new Mt();
		$mt->setWriter($this->myUser);
		$mt->setWriterNick($this->myUser->getNickname());
		$mt->setContent($this->request->content);
		$mt->setTimeTag($timeTag);
		$mt->setParentMt(false);

		// MT 유효성 체크
		if ($this->request->content == '') {
			$this->alertAndGoBack('간략한 소개말을 입력해 주세요.');
		}

		// MP 객체 생성
		$parent = Mt::instance($this->request->mt_sq)->load();

		// MP 유효성 체크
		if ($parent === null) {
			$this->alertAndGoBack('알수 없는 오류가 발생하였습니다.');
		}

		// MT 추가
		$parent->addChild($mt);

		// MP 자세히보기 페이지로 이동
		$this->response->setRedirect('view?mp_sq='.$parent->getMp()->getMpSq().'&mt_sq='.$this->request->mt_sq);
	} /*}}}*/

	public function doAddCommentProc() /*{{{*/
	{
		$this->request->setDefault(array('mt_sq' => null, 'content' => null));

		if (isset($this->request->mt_sq) === false || isset($this->request->content) === false) {
			exit;
		}

		// MT 객체 생성
		$mt = new Mt();
		$mt->setWriter($this->myUser);
		$mt->setWriterNick($this->myUser->getNickname());
		$mt->setContent($this->request->content);

		// MT 유효성 체크
		if ($this->request->content == '') {
			$this->alertAndGoBack('간략한 소개말을 입력해 주세요.');
		}

		// MP 객체 생성
		$parent = Mt::instance($this->request->mt_sq)->load();

		// MP 유효성 체크
		if ($parent === null) {
			$this->alertAndGoBack('알수 없는 오류가 발생하였습니다.');
		}

		// MT 추가
		$parent->addChild($mt);

		// MP 자세히보기 페이지로 이동
		$this->response->setRedirect('view?mp_sq='.$parent->getMp()->getMpSq().'&mt_sq='.$this->request->mt_sq);
	} /*}}}*/

	/**
	 * AJAX (HTML) : 기억나를 등록한 사용자 목록
	 */
	public function doGetMemorizeUsers() /*{{{*/
	{
		$mp    = Mp::instance($this->request->mp_sq);
		$users = $mp->getMemorizeUsers();

		$this->response->users = $users;
	} /*}}}*/

	/**
	 * AJAX (HTML) : 1-depth MT 목록
	 */
	public function doGetMts() /*{{{*/
	{
		$this->request->setDefault(array('mp_sq' => null, 'page' => 1));

		$mp  = Mp::instance($this->request->mp_sq);
		$mts = $mp->getMts($this->request->page, 20, $this->request->order);

		$this->response->mts = $mts;
	} /*}}}*/

	/**
	 * AJAX (HTML) : 2-depth MT 목록
	 */
	public function doGetMtChildren() /*{{{*/
	{
		$this->request->setDefault(array('mt_sq' => null, 'page' => 1));

		$mt  = Mt::instance($this->request->mt_sq);
		$mts = $mt->getChildren($this->request->page, 20);

		$this->response->mts = $mts;
	} /*}}}*/

	/**
	 * AJAX (HTML) : 3-depth MT 목록
	 */
	public function doGetComments() /*{{{*/
	{
		$this->request->setDefault(array('mt_sq' => null, 'page' => 1));

		$mt  = Mt::instance($this->request->mt_sq);
		$mts = $mt->getChildren($this->request->page, 20);

		$this->response->mts = $mts;
	} /*}}}*/
}
?>
