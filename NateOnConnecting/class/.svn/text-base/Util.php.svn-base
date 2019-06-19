<?php
class Util
{
	/**
	 * $url 에 해당하는 파일의 수정 시각을 파라미터로 붙인다.
	 * 
	 * js 나 css 파일에 캐쉬를 적용하기 위해서 사용하는 함수이다.
	 * 캐쉬를 적용할 경우 이 파일이 수정되었을 때 변경된 것을 알려주기 위해서
	 * 파일의 최종 수정 시각을 파라미터로 붙여서 반환한다.
	 * 
	 * @param string $url
	 * 
	 * @return string
	 */
	public static function appendFileModifyTime($url) /*{{{*/
	{
		if (Podo_Util_String::startsWith($url, array('/css/', '/js/')) === false) {
			return $url;
		}

		$filepath = ConfigManager::get('common.basedir') . '/docroot' . $url;

		if (file_exists($filepath) === false) {
			return $url;
		}

		return $url . '?m=' . filemtime($filepath);
	} /*}}}*/
}
?>
