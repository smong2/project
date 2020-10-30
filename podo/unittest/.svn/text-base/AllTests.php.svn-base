<?php
define ("TEST_PATH",dirname(__FILE__)."/");

require_once "PHPUnit/Framework.php";
require_once "PHPUnit/TextUI/TestRunner.php";

class AllTests
{
	private static $testdirs = array("dispatcher","utils","i18n");
	
    public static function suite()
    {
        $suite = new PHPUnit_Framework_TestSuite("PHPUnit Frameowrk");
		$arr_testnames = self::includeTests();

		for($i = 0 ; $i < sizeof($arr_testnames) ; $i++){
			$suite->addTestSuite($arr_testnames[$i]);
		}

        return $suite;
    }
    
    private static function includeTests()
    {
    	$arr_testnames = array();
    	for($i = 0 ; $i < sizeof(self::$testdirs) ; $i++){
    		$t_dir = TEST_PATH.self::$testdirs[$i];
	    	if ($handle = opendir($t_dir)) {
			   	while (false !== ($file = readdir($handle))) {
			       	if ($file != "." && $file != "..") {
			       		$t_file = TEST_PATH.self::$testdirs[$i]."/".$file;
					if(!is_dir($t_file)){
			           		require_once($t_file);
				           	$t_str_testname = preg_replace("/\.php$/i", "", $file);
				           	array_push($arr_testnames, $t_str_testname);
					}
			       	}
			   	}
			   	closedir($handle);
			}
		}
		
		return $arr_testnames;
    }
}
