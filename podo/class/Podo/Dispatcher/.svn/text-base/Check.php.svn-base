<?php
/**
 * Podo_Dispatcher_Check class
 * 
 * @package Podo.Dispatcher
 * @version 1.0
 * @author kimgua<kimgua@nate.com>
 * @copyright SK Communications. all rights reserved
 * @createDate 2007.05.03
 */
class Podo_Dispatcher_Check
{
	private static $_className;
	private static $_methodName;

	public static function check($arrParse, $undefined = null) /*{{{*/
	{
		self::$_className  = $arrParse['CONTROLLER'];
		self::$_methodName = $arrParse['ACTION'];

		if ($undefined === null || in_array($undefined, array('default', 'error', 'debug')) === false) {
			$undefined = ConfigManager::get('Podo.undefined', 'debug');
		}

		self::checkClass($undefined);
		self::checkMethod($undefined);
	} /*}}}*/

	protected static function checkClass($undefined) /*{{{*/
	{
		if (class_exists(self::$_className) === false) {
			switch ($undefined) {
				case 'default':
					Podo::notFound();
					exit;

				case 'error':
					echo 'Not Found Page';
					trigger_error('[Podo_Dispatcher] Not Found Class - '.self::$_className.'::'.self::$_methodName.'()', E_USER_ERROR);
					exit;

				case 'debug':
					echo '<pre>
controller/'.str_replace('_', '/', self::$_className).'.php

<b>Undefined Class '.self::$_className.'!</b>

&lt;?php
	class '.self::$_className.' extends Podo_Controller_Base 
	{
		public function '.self::$_methodName.'() 
		{
		}
	}
?&gt;</pre>';
					exit;
			}
		}
	} /*}}}*/

	protected static function checkMethod($undefined) /*{{{*/
	{
		if (method_exists(self::$_className, self::$_methodName) === false) {
			switch ($undefined) {
				case 'default':
					Podo::notFound();
					exit;

				case 'error':
					echo 'Not Found Page';
					trigger_error('[Podo_Dispatcher] Not Found Method - '.self::$_className.'::'.self::$_methodName.'()', E_USER_ERROR);
					exit;

				case 'debug':
					echo '<pre>
controller/'.str_replace('_', '/', self::$_className).'.php

<b>Undefined Function In Class '.self::$_className.'!</b>

	public function '.self::$_methodName.'() 
	{
	}
</pre>';
					exit;
			}
		}
	} /*}}}*/
}
?>
