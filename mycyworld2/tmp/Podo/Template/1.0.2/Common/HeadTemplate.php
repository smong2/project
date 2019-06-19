<?php /* /home/mong/project/mycyworld2/template/Common/Head.tpl */ class Common_HeadTemplate extends Podo_Template_Base { const HAVE_CDATA = TRUE; public function printHead($p_intLine, $p_intCol) { ?><head>
	<title>마이 싸이월드 - 개발중</title>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
	<script type="text/javascript" language="javascript" src="/js/prototype.js"></script>
	<link rel="stylesheet" type="text/css" href="/ui/css/common.css" />
	<link rel="stylesheet" type="text/css" href="/ui/css/main.css" />
	
	<?php } public function printTail($p_intLine, $p_intCol) { ?>
</head><?php } } ?>