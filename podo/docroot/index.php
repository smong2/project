<?php
	Podo::execute();
/*
	$objUrlDispatcher = Podo_Dispatcher::instance();
	$arrParse = $objUrlDispatcher->parsePattern();

    new Podo_Dispatcher_Check($arrParse);

	$CONTROLLER = new $arrParse["CONTROLLER"]($arrParse);
	$CONTROLLER->$arrParse["ACTION"]();

	$DICT = $CONTROLLER->getResponse();
	$PARAM = $CONTROLLER->getRequest();

	// Default View 필요할까?
	if(strlen($DICT->getRedirect()) > 0) {
	    header('Location: '.$DICT->getRedirect()); 
	} else if(strlen($DICT->getViewName()) > 0) {
		// nation은 입력받아 변경 가능
		$strNation = "US";
		$i18page = array();
		
		//Viewer에 따른 설정 Class 실행

		//include(ConfigManager::get('common.basedir')."/template/".$DICT->getViewName());
		$strViewClassName = $DICT->getViewName();
		$template = new $strViewClassName();
		foreach ($DICT as $key=>$val) {
			$template->{$key} = $val;
		}
        $template->request = $PARAM;
		$template->display();
	}
*/
?>
