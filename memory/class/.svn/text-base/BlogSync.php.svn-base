<?php
class BlogSync extends BaseObject
{
	protected $__blogId;
	protected $__blogNm;
	protected $__apiId;
	protected $__blogUserId;
	protected $__blogApiKey;
	protected $__blogPassword;
	protected $__caegoryNm;
	protected $__mpCnt;
	protected $__insertDt;
	protected $__blogSeq;

	public static function instance($blogId) /*{{{*/
	{
		static $sInstance = array();

		$blogId = intval($blogId);

		if (isset($sInstance[$blogId]) === false) {
			$className          = __CLASS__;
			$blog               = new $className($blogId);
			$sInstance[$blogId] = $blog;
		}

		return $sInstance[$blogId];
	} /*}}}*/

	public function retrieveBlogSync($page, $numPerPage) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT blog_seq, blog_id, api_id, blog_user_id, api_key, blog_password, category_nm, mp_cnt, insert_dt
					 FROM user_blogsync WHERE user_id = :user_id';
		$query .= ' ORDER BY blog_seq DESC LIMIT :offset, :limit';
		$stmt = $pdo->prepare($query);
		$stmt->bindValue(':user_id', $this->myUser->getUserId(), PDO::PARAM_STR);
		$stmt->bindValue(':offset',  ($page-1)*$numPerPage,      PDO::PARAM_INT);
		$stmt->bindValue(':limit',   $numPerPage,                PDO::PARAM_INT);
		$stmt->execute();

		$retvals = array();

		while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$retval = BlogSync::instance($row['blog_seq']);
			$retval->setBlogSeq($row['blog_seq']);
			$retval->setBlogId($row['blog_id']);
			$retval->setBlogNm(BlogSync::$blogGbn[$row['blog_id']]);
			$retval->setApiId($row['api_id']);
			$retval->setBlogUserId($row['blog_user_id']);
			$retval->setApiKey($row['api_key']);
			$retval->setBlogPassword($row['blog_password']);
			$retval->setCategoryNm($row['category_nm']);
			$retval->setMpCnt($row['mp_cnt']);
			$retval->setInsertDt(strtotime($row['insert_dt']));

			$retvals[] = $retval;
		}
		return $retvals;
	} /*}}}*/

	// 블로그 종류 가져오기
	public static $blogGbn = array('--선택--', '이글루스', '싸이블로그', '티스토리', '텍스트큐브', '다음');
}
?>
