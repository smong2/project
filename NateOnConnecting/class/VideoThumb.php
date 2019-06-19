<?php
class VideoThumb
{
	public static function getThumbUrl($videoUrl) /*{{{*/
	{
		if (Podo_Util_String::startsWith($videoUrl, array('http://www.youtube.com/', 'http://www.youtube-nocookie.com/'))) {
			return self::getThumbOfYoutube($videoUrl);
		}

		return 'http://connect.nate.com/img/2.0/ico_youtube.gif';
	} /*}}}*/

	public static function getThumbOfYoutube($videoUrl) /*{{{*/
	{
		$urlInfo = parse_url($videoUrl);
		parse_str($urlInfo['query'], $params);

		return 'http://i' . rand(1, 4) . '.ytimg.com/vi/' . $params['v'] . '/default.jpg';
	} /*}}}*/
}
?>
