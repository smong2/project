<?php
class Podo_Util_DBLogger
{
	protected static $_strQuery = '';
	protected static $_dblStart = 0;

	public static function startQuery($strQuery) /*{{{*/
	{
		self::$_strQuery = $strQuery;
		self::$_dblStart = microtime(true);
	} /*}}}*/

	public static function endQuery() /*{{{*/
	{
		$elapsed = sprintf('%.2f', (microtime(true)-self::$_dblStart)*1000);
		Logger::log(__CLASS__, 0, $elapsed.'|'.self::$_strQuery);
	} /*}}}*/
}
?>
