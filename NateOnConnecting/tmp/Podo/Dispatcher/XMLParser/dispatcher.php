<?php
	$Cache_Array = array();
	$Cache_Array['DISPATCHER-CONFIG']['0']['PATTERNS']['0']['PATTERN']['0']['attr']['TYPE'] = 'ACTION';
	$Cache_Array['DISPATCHER-CONFIG']['0']['PATTERNS']['0']['PATTERN']['0']['EXPRESSION']['0']['data'] = '/^\/?$/i';
	$Cache_Array['DISPATCHER-CONFIG']['0']['PATTERNS']['0']['PATTERN']['0']['CONTROLLER']['0']['data'] = 'MainController';
	$Cache_Array['DISPATCHER-CONFIG']['0']['PATTERNS']['0']['PATTERN']['0']['ACTION']['0']['data'] = 'doIndex';
	$Cache_Array['DISPATCHER-CONFIG']['0']['PATTERNS']['0']['PATTERN']['0']['VIEW']['0']['data'] = 'Main_Index';
	$Cache_Array['DISPATCHER-CONFIG']['0']['PATTERNS']['0']['PATTERN']['1']['attr']['TYPE'] = 'ACTION';
	$Cache_Array['DISPATCHER-CONFIG']['0']['PATTERNS']['0']['PATTERN']['1']['EXPRESSION']['0']['data'] = '/^\/([a-zA-Z_]\w*)\/?$/i';
	$Cache_Array['DISPATCHER-CONFIG']['0']['PATTERNS']['0']['PATTERN']['1']['CONTROLLER']['0']['data'] = 'MainController';
	$Cache_Array['DISPATCHER-CONFIG']['0']['PATTERNS']['0']['PATTERN']['1']['ACTION']['0']['data'] = 'do<$1>';
	$Cache_Array['DISPATCHER-CONFIG']['0']['PATTERNS']['0']['PATTERN']['1']['VIEW']['0']['data'] = 'Main_<$1>';
	$Cache_Array['DISPATCHER-CONFIG']['0']['PATTERNS']['0']['PATTERN']['2']['attr']['TYPE'] = 'ACTION';
	$Cache_Array['DISPATCHER-CONFIG']['0']['PATTERNS']['0']['PATTERN']['2']['EXPRESSION']['0']['data'] = '/^\/([a-zA-Z_]\w*(?:\/[a-zA-Z_]\w*)*)\/([a-zA-Z_]\w*)\/?$/i';
	$Cache_Array['DISPATCHER-CONFIG']['0']['PATTERNS']['0']['PATTERN']['2']['CONTROLLER']['0']['data'] = '<$1>Controller';
	$Cache_Array['DISPATCHER-CONFIG']['0']['PATTERNS']['0']['PATTERN']['2']['ACTION']['0']['data'] = 'do<$2>';
	$Cache_Array['DISPATCHER-CONFIG']['0']['PATTERNS']['0']['PATTERN']['2']['VIEW']['0']['data'] = '<$1>_<$2>';
	$Cache_Array['DISPATCHER-CONFIG']['0']['DEFAULT']['0']['CONTROLLER']['0']['data'] = 'MainController';
	$Cache_Array['DISPATCHER-CONFIG']['0']['DEFAULT']['0']['ACTION']['0']['data'] = 'doNotFound';
	$Cache_Array['DISPATCHER-CONFIG']['0']['DEFAULT']['0']['VIEW']['0']['data'] = 'Main_NotFound';
?>
