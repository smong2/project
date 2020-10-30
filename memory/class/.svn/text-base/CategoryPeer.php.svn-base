<?php
class CategoryPeer
{
	/**
	 * @return 카테고리 추가가 정상적으로 성공했으면 Category 객체를, 그렇지 않으면 FALSE 를 반환한다.
	 */
	public static function add($categoryNm, AdminOfficer $officer) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT count(*) cnt FROM category WHERE category_nm = :category_nm';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':category_nm', $categoryNm, PDO::PARAM_STR);
		$stmt->execute();

		$row = $stmt->fetch(PDO::FETCH_ASSOC);

		if ($row['cnt'] > 0) {
			return false;
		}

		$query = 'INSERT INTO category
				  (category_nm, update_dt)
				  VALUES (:category_nm, now())';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':category_nm', $categoryNm, PDO::PARAM_STR);
		$stmt->execute();

		$categorySq = $pdo->lastInsertId();

		$category = Category::instance($categorySq);

		AdminLogPeer::add($officer, AdminLog::GB_CATEGORY_ADD, $category);

		return $category;
	} /*}}}*/

	/**
	 * 전체 카테고리 목록을 반환한다. (비활성화된 카테고리 포함)
	 */
	public static function retrieveCategories() /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT category_sq, category_nm, activate_fl, mp_cnt, view_ord, insert_dt, update_dt
			      FROM category';
		$stmt  = $pdo->prepare($query);
		$stmt->execute();

		$categories = array();
		while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$category = Category::instance($row['category_sq']);
			$category->loadByRowData($row);
			$categories[] = $category;
		}

		if (count($categories) > 0) {
			usort($categories, array($category, 'compareWithViewOrd'));
		}

		return $categories;
	} /*}}}*/

	/**
	 * 활성화된 카테고리 목록을 반환한다.
	 */
	public static function retrieveActivatedCategories() /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT category_sq, category_nm, view_ord
			      FROM category WHERE activate_fl = :activate_fl';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':activate_fl', 1, PDO::PARAM_INT);
		$stmt->execute();

		$categories = array();
		while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$category = Category::instance($row['category_sq']);
			$category->loadByRowData($row);
			$categories[] = $category;
		}

		if (count($categories) > 0) {
			usort($categories, array($category, 'compareWithViewOrd'));
		}

		return $categories;
	} /*}}}*/

	public static function retrieveCategoryByCategorySq($categorySq) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT category_sq, category_nm, activate_fl, mp_cnt
			      FROM category WHERE category_sq = :category_sq';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':category_sq', $categorySq, PDO::PARAM_INT);
		$stmt->execute();

		$category = null;

		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$category = Category::instance($row['category_sq']);
			$category->setCategoryNm($row['category_nm']);
			$category->setActivateFl((bool)($row['activate_fl']));
			$category->setMpCnt(intval($row['mp_cnt']));
		}

		return $category;
	} /*}}}*/

	public static function countCategoryByCategorySq($categorySq) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT count(*) cnt FROM category WHERE category_sq = :category_sq';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':category_sq', $categorySq, PDO::PARAM_INT);
		$stmt->execute();

		$row = $stmt->fetch(PDO::FETCH_ASSOC);

		return $row['cnt'];
	} /*}}}*/
}
?>
