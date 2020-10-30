<?php
class MpPeer
{
	/***************************************************************************
	 ***** COUNT 함수들 ********************************************************
	 **************************************************************************/

	public static function countMpsByMpNm($name) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT count(*) cnt FROM memory_piece WHERE mp_nm = :mp_nm';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':mp_nm', $name, PDO::PARAM_STR);
		$stmt->execute();

		$row = $stmt->fetch(PDO::FETCH_ASSOC);

		return $row['cnt'];
	} /*}}}*/

	public static function countMpsByCategorySqAndMpNm($category_sq, $name) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT count(*) cnt FROM memory_piece WHERE category_sq = :category_sq and mp_nm = :mp_nm';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':category_sq', $category_sq, PDO::PARAM_INT);
		$stmt->bindValue(':mp_nm',       $name,        PDO::PARAM_STR);
		$stmt->execute();

		$row = $stmt->fetch(PDO::FETCH_ASSOC);

		return $row['cnt'];
	} /*}}}*/

	public static function countMps($includeDeleted = false) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT count(*) cnt FROM memory_piece';
		if ($includeDeleted === false) {
			$query .= ' WHERE deleted_fl = 0';
		}
		$stmt = $pdo->prepare($query);
		$stmt->execute();

		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			return $row['cnt'];
		}
		else {
			return 0;
		}
	} /*}}}*/

	public static function countMpsByCategorySqAndTimeTag($categorySq, $timetagGb, $timetagData) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$whereClause = array();
		if ($categorySq) {
			$whereClause[] = 'category_sq = :category_sq';
		}
		if ($timetagGb && $timetagData) {
			$whereClause[] = 'timetag_gb = :timetag_gb and timetag_data = :timetag_data';
		}

		$query = 'SELECT count(*) cnt FROM mp_timetag';
		if (count($whereClause) > 0) {
			$query .= ' WHERE '.join(' and ', $whereClause);
		}
		$stmt = $pdo->prepare($query);

		if ($categorySq) {
			$stmt->bindValue(':category_sq', $categorySq);
		}
		if ($timetagGb && $timetagData) {
			$stmt->bindValue(':timetag_gb', $timetagGb);

			if ($timetagGb == TimeTag::GB_CUSTOM) {
				$stmt->bindValue(':timetag_data', $timetagData.'0000');
			}
			else {
				$stmt->bindValue(':timetag_data', $timetagData);
			}
		}
		$stmt->execute();

		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			return $row['cnt'];
		}

		return 0;
	} /*}}}*/

	/***************************************************************************
	 ***** RETRIEVE 함수들 *****************************************************
	 **************************************************************************/

	public static function _retrieveMpByMpSq($mpSq) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT * FROM memory_piece WHERE mp_sq = :mp_sq';
		$stmt  = $pdo->prepare($query);

		$stmt->bindValue(':mp_sq', $mpSq, PDO::PARAM_INT);
		$stmt->execute();

		$mp = null;
		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {

			$mp = Mp::instance($row['mp_sq']);
			$mp->loadByRowData($row);
		}

		return $mp;
	} /*}}}*/

	public static function retrieveMpByMpSq($mpSq) /*{{{*/
	{
		return Mp::instance($mpSq)->load();

	} /*}}}*/

	public static function retrieveMps($page, $numPerPage, $includeDeleted = false, $order = 'mp_sq') /*{{{*/
	{
		if ($order == 'mt_cnt') {
			$orderBy = 'mt2d_cnt DESC';
		}
		else {
			$orderBy = 'mp_sq DESC';
		}

		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT a.*, content
			      FROM memory_piece a LEFT JOIN memory_talk b ON a.first_mt_sq = b.mt_sq';
		if ($includeDeleted === false) {
			$query .= ' WHERE deleted_fl = 0';
		}
		$query .= ' ORDER BY '.$orderBy.' LIMIT :offset, :limit';
		$stmt = $pdo->prepare($query);

		$stmt->bindValue(':offset', ($page-1)*$numPerPage, PDO::PARAM_INT);
		$stmt->bindValue(':limit',  $numPerPage,           PDO::PARAM_INT);
		$stmt->execute();

		$mps = array();
		while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$mp = Mp::instance($row['mp_sq']);
			$mp->loadByRowData($row);

			$mt = Mt::instance($row['first_mt_sq']);
			$mt->setContent($row['content']);

			$mp->setFirstMt($mt);

			$mps[] = $mp;
		}

		return $mps;
	} /*}}}*/

	public static function retrieveMpsByMpNm($mpNm) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT * FROM memory_piece WHERE mp_nm = :mp_nm';
		$stmt  = $pdo->prepare($query);

		$stmt->bindValue(':mp_nm', $mpNm, PDO::PARAM_STR);
		$stmt->execute();

		$mps = array();
		while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$mp = Mp::instance($row['mp_sq']);
			$mp->loadByRowData($row);

			$mps[] = $mp;
		}

		return $mps;
	} /*}}}*/

	public static function retrieveSimilarMpsByMpNm($mpNm, $limit = 20) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT * FROM memory_piece WHERE mp_nm LIKE :mp_nm LIMIT :limit';
		$stmt  = $pdo->prepare($query);

		$stmt->bindValue(':mp_nm', str_replace('%', '\%', $mpNm).'%', PDO::PARAM_STR);
		$stmt->bindValue(':limit', $limit,                            PDO::PARAM_INT);
		$stmt->execute();

		$mps = array();
		while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$mp = Mp::instance($row['mp_sq']);
			$mp->loadByRowData($row);

			$mps[] = $mp;
		}

		return $mps;
	} /*}}}*/

	public static function retrieveMpsByCategorySqAndTimeTag($categorySq, $timetagGb, $timetagData, $order = 'mp_sq', $page = 1, $numPerPage = 9) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$whereClause = array();
		if ($categorySq) {
			$whereClause[] = 'a.category_sq = :category_sq';
		}
		if ($timetagGb && $timetagData) {
			$whereClause[] = 'a.timetag_gb = :timetag_gb and a.timetag_data = :timetag_data';
		}
		$whereClause[] = 'a.mp_sq = b.mp_sq';

		if ($order === 'mt_cnt') {
			$orderBy = 'a.mt2d_cnt desc';
		}
		else {
			$orderBy = 'a.mp_sq desc';
		}

		$query = 'SELECT b.*, c.content
				  FROM mp_timetag a, memory_piece b LEFT JOIN memory_talk c ON b.first_mt_sq = c.mt_sq
				  WHERE '.join(' and ', $whereClause).' ORDER BY '.$orderBy.' LIMIT :offset, :limit';
		$stmt = $pdo->prepare($query);

		if ($categorySq) {
			$stmt->bindValue(':category_sq', $categorySq);
		}
		if ($timetagGb && $timetagData) {
			$stmt->bindValue(':timetag_gb', $timetagGb);

			if ($timetagGb == TimeTag::GB_CUSTOM) {
				$stmt->bindValue(':timetag_data', $timetagData.'0000');
			}
			else {
				$stmt->bindValue(':timetag_data', $timetagData);
			}
		}
		$stmt->bindValue(':offset', ($page-1)*$numPerPage, PDO::PARAM_INT);
		$stmt->bindValue(':limit',  $numPerPage,           PDO::PARAM_INT);
		$stmt->execute();

		$mps = array();
		while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$mp = Mp::instance($row['mp_sq']);
			$mp->loadByRowData($row);

			$mt = Mt::instance($row['first_mt_sq']);
			$mt->setContent($row['content']);

			$mp->setFirstMt($mt);

			$mps[] = $mp;
		}

		return $mps;
	} /*}}}*/
}
?>
