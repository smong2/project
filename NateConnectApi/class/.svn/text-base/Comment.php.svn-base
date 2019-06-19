<?php
class Comment Extends BaseObject
{
	protected $__commentKey;
	protected $__commentId;
	protected $__parentId;
	protected $__content;
	protected $__message;
	protected $__writer;
	protected $__writeDt;
	protected $__writerNm;
	protected $__isSecret;

	const MAXLEN_CONTENT = 150;

	const COMMENT_TYPE_RECOMMENT = 're';

	const IS_SECRET_Y = 1;
	const IS_SECRET_N = 0;

	public static function instance($pk) /*{{{*/
	{
		static $sInstance = array();

		$pk = strval($pk);

		if (isset($sInstance[$pk]) === false) {
			$className      = __CLASS__;
			$obj            = new $className($pk);
			$sInstance[$pk] = $obj;
		}

		return $sInstance[$pk];
	} /*}}}*/

	protected function __construct($commentKey) /*{{{*/
	{
		$this->__commentKey = $commentKey;
	} /*}}}*/

	/************************************************************************** 
	 ***** ACTION ************************************************************* 
	 **************************************************************************/

	/**
	 * 댓글을 등록한다
	 * 
	 * @param User $user 유저 객체
	 * @param string $mode 트위터 댓글(twit)/일반 댓글
	 * @param string $twitId 트위터 스크린명
	 * @param Service $service 서비스 계정
	 * 
	 * @return 결과 xml
	 */
	public function add(User $user, $mode, $twitId, Service $service) /*{{{*/
	{
		return ContainerAPI::addComment($user, $this, $mode, $twitId, $service);
	} /*}}}*/

	/**
	 * 댓글을 비밀글로 변경한다.
	 * 
	 * @return bool 성공할 경우 true 를 반환한다.
	 */
	public function secret(User $user, Service $service) /*{{{*/
	{
		return ContainerAPI::secretComment($user, $this, $service);
	} /*}}}*/

	/**
	 * 댓글을 삭제한다.
	 * 
	 * @param User $user 삭제하는 사용자의 객체를 전달한다.
	 * @param string $mode 트위터 댓글(twit)/일반 댓글
	 * 
	 * @return bool 성공할 경우 true 를 반환한다.
	 */
	public function delete(User $user, $mode, Service $service) /*{{{*/
	{
		return ContainerAPI::deleteComment($this, $user, $mode, $service);
	} /*}}}*/
}
?>
