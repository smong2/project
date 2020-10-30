<?php
/**
* I18NParser class
*
* @package phpframework.dispatcher
* @version 1.0
* @author kimgua<kimgua@nate.com>
* @copyright SK Communications. all rights reserved
* @createDate 2007.03.26
*/
class I18NParser{
	private $parser;
	private $filePath;
	private $document;
	private $tagStack;
	private $encoding = 'UTF-8';
	
	function __construct($filePath = ""){
	   $this->parser = xml_parser_create($this->encoding);
	   $this->filePath = $filePath;
	   $this->document = array();
	   $this->tagStack = array();
	}

	function __destruct(){
	}
	
	public function setFile($filePath){
	    $this->filePath = $filePath;
	}

	public function getDocument(){
	    return $this->document;
	}

	public function parse(){
	    $this->setparser();
	    
	    if(!($fp = @fopen($this->filePath, "r"))) {
	        //die("Cannot open XML data file: $this->filePath");
	        return false;
	    }
	    
	    while($data = fread($fp, 4096)){
	        if(!xml_parse($this->parser, $data, feof($fp))) {
	            die(sprintf("XML error: %s at line %d",
	                xml_error_string(xml_get_error_code($this->parser)),
	              xml_get_current_line_number($this->parser)));
	        }
	    }
	    
	    fclose($fp);
	    $this->freeparser();
	    
	    return true;
	}
	
	public function parse_str($data){
	    $this->setparser();
	    
        if(!xml_parse($this->parser, $data)) {
            sprintf("XML error: %s at line %d",
                xml_error_string(xml_get_error_code($this->parser)),
              xml_get_current_line_number($this->parser));
			$this->freeparser();
            return false;
        }
	    
	    $this->freeparser();
	    return true;
	}
	
	private function setparser(){
	    xml_set_object($this->parser, $this);
	    xml_set_character_data_handler($this->parser, 'dataHandler');
	    xml_set_element_handler($this->parser, 'startHandler', 'endHandler');
	}
	
	private function freeparser(){
	    xml_parser_free($this->parser);
	}

	private function startHandler($parser, $name, $attribs){
	    $this->tagStack[$name] = 1;
//	    echo "key ==> $name<br>";
	}
	
	private function dataHandler($parser, $data){
	    $data = trim($data);

    	$php_stmt = '$this->document';
    	foreach ($this->tagStack as $key => $val) {
    		$php_stmt .= '[\''.$key.'\']';
    	}
	    
		if(!empty($data)) {
			eval('if (isset('.$php_stmt.')) { $t_array = '.$php_stmt.'; }');
			if(isset($t_array)){
				$php_stmt .= '.= trim($data);';
			}else{
				$php_stmt .= '= trim($data);';
			}

    		eval($php_stmt);
    		$this->tagStack[$key] = $php_stmt;
	    }
//		echo '<pre>';
//		var_dump($this->document);
//		echo "===========stack=============\n";
//		var_dump($this->tagStack);
//		echo '</pre>';
	}
	
	private function endHandler($parser, $name){
		if($this->tagStack[$name] == 1){
	    	$php_stmt = '$this->document';
	    	foreach ($this->tagStack as $key => $val) {
	    		$php_stmt .= '[\''.$key.'\']';
	    	}

			eval('if (isset('.$php_stmt.')) { $t_array = '.$php_stmt.'; }');
			if(!isset($t_array)){
				eval($php_stmt.'= array();');
			}
//			echo "////".$php_stmt."= array();<br>";
		}
		
	    unset($this->tagStack[$name]);
	}
}
?>
<?php
	//$parser = new I18NParser(dirname(__FILE__)."/dispatcher.xml");
//	$parser = new I18NParser;
//	$parser->setFile(dirname(__FILE__)."/dispatcher.xml");
//	$parser->parse();
//	$result = $parser->getDocument();
//	echo '<pre>';
//	var_dump($result);
//	echo '</pre>';
?>