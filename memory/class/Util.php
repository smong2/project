<?php
class Util
{
	public static function getRequestUri() /*{{{*/
	{
		parse_str($_SERVER['QUERY_STRING'], $arrUrl);
		unset($arrUrl['action']);

		$queryString = '';
		if (count($arrUrl) > 0) {
			$queryString = '?' . http_build_query($arrUrl);
		}

		return 'http://' . $_SERVER['HTTP_HOST'] . Podo::getActionStr() . $queryString;
	} /*}}}*/
}
?>
