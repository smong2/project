<?php
class BlogSyncPeer
{
	public function countBlogsync() /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT count(*) cnt FROM user_blogsync';
		$stmt  = $pdo->prepare($query);
		$stmt->execute();

		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			return $row['cnt'];
		}
		else {
			return 0;
		}
	} /*}}}*/

	// 몇개가 있는지 모르니 proc를 거쳐서 remove로 진행
	public function preRemoveProc() /*{{{*/
	{
		for ($i=0; $i<sizeof($this->req->chk_blog_id); $i++) {
			$deleteSeq = $this->req->chk_blog_id[$i];
			BlogSyncPeer::remove($deleteSeq);
		}
	} /*}}}*/

	public function remove($deleteSeq) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'DELETE FROM user_blogsync
					WHERE blog_seq = :blog_seq';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':blog_seq', $deleteSeq, PDO::PARAM_INT);
		$stmt->execute();
	} /*}}}*/

	public function addModify() /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$blogGbn     = $this->req->blog_gbn;
		$appId       = $this->req->appid;
		$password    = $this->req->password;
		$serverId    = $this->req->serverid;
		$userName    = $this->req->username;
		$processMode = $this->req->processMode;

		// 0이 아니면 수정
		if ($processMode) {
			$query = 'UPDATE user_blogsync
						SET blog_id = :blog_id,
						api_id = :appid,
						blog_user_id = :serverid,
						api_key = :username,
						blog_password = :password
						WHERE user_id = :userid AND
								blog_seq = :processMode';
		} else {
			// 0은 입력
			$query = 'INSERT INTO user_blogsync
						 (blog_id, api_id, blog_user_id, api_key, blog_password, user_id)
						 values
						 (:blog_id, :appid, :serverid, :username, :password, :userid)';
		}
		$stmt = $pdo->prepare($query);
		$stmt->bindValue(':blog_id',     $blogGbn,                   PDO::PARAM_INT);
		$stmt->bindValue(':appid',       $appId,                     PDO::PARAM_STR);
		$stmt->bindValue(':serverid',    $serverId,                  PDO::PARAM_STR);
		$stmt->bindValue(':username',    $userName,                  PDO::PARAM_STR);
		$stmt->bindValue(':password',    $password,                  PDO::PARAM_STR);
		$stmt->bindValue(':processMode', $processMode,               PDO::PARAM_INT);
		$stmt->bindValue(':userid',      $this->myUser->getUserId(), PDO::PARAM_STR);

		$stmt->execute();

		$chkval = $pdo->lastInsertId();

		return $chkval;
	} /*}}}*/

	public function retrieveBlogSyncBySeq() /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT blog_seq, blog_id, api_id, blog_user_id, api_key, blog_password, category_nm, mp_cnt, insert_dt
					 FROM user_blogsync WHERE user_id = :user_id and blog_seq = :blog_seq';

		$stmt = $pdo->prepare($query);
		$stmt->bindValue(':user_id',  $this->myUser->getUserId(), PDO::PARAM_STR);
		$stmt->bindValue(':blog_seq', $this->req->processMode,    PDO::PARAM_INT);

		$stmt->execute();

		$retvals = '';

		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$retval = BlogSync::instance($row['blog_seq']);
			$retval->setBlogSeq($row['blog_seq']);
			$retval->setBlogId($row['blog_id']);
			$retval->setBlogNm(BlogSync::$blogGbn[$row['blog_id']]);
			$retval->setApiId($row['api_id']);
			$retval->setBlogUserId($row['blog_user_id']);
			$retval->setBlogApiKey($row['api_key']);
			$retval->setBlogPassword($row['blog_password']);
			$retval->setCategoryNm($row['category_nm']);
			$retval->setMpCnt($row['mp_cnt']);
			$retval->setInsertDt($row['insert_dt']);

			$retvals[] = $retval;
		} else {
			$retval = BlogSync::instance('');
			$retval->setBlogSeq('');
			$retval->setBlogId('');
			$retval->setBlogNm('');
			$retval->setApiId('');
			$retval->setBlogUserId('');
			$retval->setBlogApiKey('');
			$retval->setBlogPassword('');
			$retval->setCategoryNm('');
			$retval->setMpCnt('');
			$retval->setInsertDt('');
			$retvals[] = $retval;
		}
		return $retvals;
	} /*}}}*/
}
?>
