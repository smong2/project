<?php
/**
* I18N class
*
* @package phpframework.utils
* @version 1.0
* @author kimgua<kimgua@nate.com>
* @copyright SK Communications. all rights reserved
* @createDate 2007.03.20
*/
class I18N {
	private $arr_page_message;
	private $arr_global_message;
	private $str_nation;
	
	function __construct($str_viewfile = "") {
		$this->str_nation = "US";
		$arr_page_message = array();
		$arr_global_message = array();
	}

	function __destruct() {
	}

    public function setPageMessage($arr_page_message) {
    	$this->arr_page_message[$this->str_nation] = $arr_page_message;
    }

    public function setGlabalMessage($arr_global_message) {
    	$this->arr_global_message[$this->str_nation] = $arr_global_message;
    }

    public function setNation($str_nation) {
    	$this->str_nation = $str_nation;
    }

    public function getMessage($str_msgid, $arr_special = NULL) {
    	$str_message = $this->get($this->arr_page_message, $str_msgid, $arr_special);
    	return $str_message;
    }

    public function getGlobal($str_msgid, $arr_special = NULL) {
    	$str_message = $this->get($this->arr_global_message, $str_msgid, $arr_special);
    	
    	return $str_message;
    }

    private function get($arr_message, $str_msgid, $arr_special = NULL) {
    	$str_message = $arr_message[$this->str_nation][$str_msgid];
    	if(isset($arr_special)){
    		if(is_array($arr_special)){
	    		$str_message = preg_replace('/{\$([^{}\$ ]+)}/','\$arr_special[$1]',$str_message);
	    	}else{
	    		$str_message = preg_replace('/{\$([^{}\$ ]+)}/','\${arr_special}',$str_message);
	    	}
    		//var_dump($arr_special);
    		//var_dump($str_message);
    			
			eval("\$str_message = \"".$str_message."\";");
    	}
    	
    	return $str_message;
    }
}
?>
