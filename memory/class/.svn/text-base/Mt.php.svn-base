<?php
class Mt extends BaseObject
{
	protected $__mtSq;
	protected $__mp; // from mp
	protected $__privateFl;
	protected $__writer; // from writer_id
	protected $__writerNick;
	protected $__content;
	protected $__parentMt; // from parent_mt_sq
	protected $__childMtCnt;
	protected $__timeTag; // from start_year, start_month, start_day, timetag_gb, timetag_data
	protected $__insertDt;
	protected $__updateDt;

	private $_isLoaded = false;

	public static function instance($mtSq) /*{{{*/
	{
		static $sInstance = array();

		$mtSq = intval($mtSq);

		if (isset($sInstance[$mtSq]) === false) {
			$className        = __CLASS__;
			$mt               = new $className($mtSq);
			$sInstance[$mtSq] = $mt;
		}

		return $sInstance[$mtSq];
	} /*}}}*/

	public function __construct($mtSq = null) /*{{{*/
	{
		$this->__mtSq = $mtSq;
	} /*}}}*/

	/***************************************************************************
	 ***** SET 함수들 **********************************************************
	 **************************************************************************/

	public function setMtSq($mtSq) /*{{{*/
	{
		$this->__mtSq = $mtSq;

		if (isset($this->__timeTag)) {
			$this->__timeTag->setParentSq($this->__mtSq);
		}
	} /*}}}*/

	public function setTimeTag(TimeTag $timeTag) /*{{{*/
	{
		$timeTag->setParentGb(TimeTag::PARENT_GB_MT);
		$timeTag->setParentSq($this->__mtSq);

		$this->__timeTag = $timeTag;
	} /*}}}*/

	/***************************************************************************
	 ***** LOAD 함수들 *********************************************************
	 **************************************************************************/

	public function loadByRowData($row) /*{{{*/
	{
		parent::loadByRowData($row);

		$this->setMp(Mp::instance($row['mp_sq']));
		$this->setWriter(User::instance($row['writer_id']));

		if ($row['parent_mt_sq']) {
			$this->setParentMt(Mt::instance($row['parent_mt_sq']));
		}
		else {
			$this->setParentMt(false);
		}

		$timeTag = new TimeTag();
		$timeTag->setStartYear($row['start_year']);
		$timeTag->setTimeTagGb($row['timetag_gb']);
		$timeTag->setData($row['timetag_data']);
		$timeTag->setInsertDt(strtotime($row['insert_dt']));
		$this->setTimeTag($timeTag);
	} /*}}}*/

	public function load() /*{{{*/
	{
		if ($this->_isLoaded == true) {
			return $this;
		}

		$this->_isLoaded = true;

		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT * FROM memory_talk WHERE mt_sq = :mt_sq';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':mt_sq', $this->__mtSq, PDO::PARAM_INT);
		$stmt->execute();

		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$this->loadByRowData($row);
		}

		return $this;
	} /*}}}*/

	/***************************************************************************
	 ***** GET 함수들 **********************************************************
	 **************************************************************************/

	public function getChildren($page = 1, $numPerPage = 10) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT * FROM memory_talk WHERE parent_mt_sq = :parent_mt_sq
				  ORDER BY mt_sq desc LIMIT :offset, :limit';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':parent_mt_sq', $this->__mtSq,         PDO::PARAM_INT);
		$stmt->bindValue(':offset',       ($page-1)*$numPerPage, PDO::PARAM_INT);
		$stmt->bindValue(':limit',        $numPerPage,           PDO::PARAM_INT);
		$stmt->execute();

		$mts = array();
		while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$mt = Mt::instance($row['mt_sq']);
			$mt->loadByRowData($row);

			$mts[] = $mt;
		}

		return $mts;
	} /*}}}*/

	/***************************************************************************
	 ***** ACTION 함수들 *******************************************************
	 **************************************************************************/

	public function increaseChildMtCnt() /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'UPDATE memory_talk SET child_mt_cnt = child_mt_cnt + 1, update_dt = now() WHERE mt_sq = :mt_sq';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':mt_sq', $this->__mtSq, PDO::PARAM_INT);
		$stmt->execute();

		if (isset($this->__childMtCnt)) {
			$this->__childMtCnt++;
		}
	} /*}}}*/

	/***************************************************************************
	 ***** ADD 함수들 **********************************************************
	 **************************************************************************/

	public function addChild(Mt $child) /*{{{*/
	{
		// DB 에 INSERt 쿼리 실행
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'INSERT INTO memory_talk
				  (mp_sq, writer_id, writer_nick, content, parent_mt_sq,
				   start_year, start_month, start_day, timetag_gb, timetag_data, update_dt)
				  VALUES (:mp_sq, :writer_id, :writer_nick, :content, :parent_mt_sq, 
						  :start_year, :start_month, :start_day, :timetag_gb, :timetag_data, now())';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':mp_sq',        $this->getMp()->getMpSq(),                    PDO::PARAM_INT);
		$stmt->bindValue(':writer_id',    $child->getWriter()->getUserId(), PDO::PARAM_STR);
		$stmt->bindValue(':writer_nick',  $child->getWriterNick(),          PDO::PARAM_STR);
		$stmt->bindValue(':content',      $child->getContent(),             PDO::PARAM_STR);
		$stmt->bindValue(':parent_mt_sq', $this->__mtSq,                    PDO::PARAM_INT);
		if (isset($child->__timeTag)) {
			$child->getTimeTag()->bindValue($stmt);
		}
		else {
			$stmt->bindValue(':start_year',   0,  PDO::PARAM_INT);
			$stmt->bindValue(':start_month',  0, PDO::PARAM_INT);
			$stmt->bindValue(':start_day',    0,   PDO::PARAM_INT);
			$stmt->bindValue(':timetag_gb',   0,  PDO::PARAM_INT);
			$stmt->bindValue(':timetag_data', '',       PDO::PARAM_STR);
		}
		$stmt->execute();

		$child->setMtSq($pdo->lastInsertId());

		// MT 개수 업데이트
		$this->increaseChildMtCnt();
		$child->getWriter()->increaseMtCnt();

		if ($child->getWriter()->isMemorize($this->getMp()) === false) {
			$child->getWriter()->memorize($this->getMp());
		}

		// 현재 MT 가 1-depth MT 라면 memory_piece.mt2d_cnt 값을 증가시켜야 한다.
		if ($this->getParentMt() == false) {
			$this->getMp()->increaseMt2dCnt();
		}
	} /*}}}*/
}
?>
