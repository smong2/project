<?php
class ExtBlogPeer
{
	/**
	 * 등록 가능한 외부 블로그 목록을 가져온다.
	 * 
	 * @return array of ExtBlog
	 */
	public static function retrieveEnableExtBlogs() /*{{{*/
	{
		$pdo = PDO_Manager::getConnectDB();

		$query = 'exec dbo.ncsp2010_extblog_list :current_page, :perpage';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':current_page', 1,  PDO::PARAM_INT);
		$stmt->bindValue(':perpage',      50, PDO::PARAM_INT);
		$stmt->execute();

		$results = array();
		while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			if ($row['USE_FLAG'] != 'y') {
				continue;
			}

			if (mb_detect_encoding($row['BLOG_NM']) != 'UTF-8') {
				$row['BLOG_NM'] = mb_convert_encoding($row['BLOG_NM'], 'utf-8', 'cp949');
			}

			$extBlog = ExtBlog::instance($row['BLOG_ID']);
			$extBlog->setBlogNm($row['BLOG_NM']);
			$extBlog->setImgPath($row['IMG_PATH']);

			$results[] = $extBlog;
		}

		return $results;
	} /*}}}*/
}
?>
