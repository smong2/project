<?php /* /home/mong/project/memory/template/Common/Head.tpl */ class Common_HeadTemplate extends Podo_Template_Base { const HAVE_CDATA = TRUE; public $title; public function printHead($p_intLine, $p_intCol) { ?><head>
	<title><?php echo $this->title ? $this->title : 'Nate - 기억나'; ?></title>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />

	<link rel="stylesheet" type="text/css" href="/css/minilife_v1_common.css" media="all" />
	<script type="text/javascript" language="javascript" src="/js/prototype.js"></script>
	<script type="text/javascript" language="javascript" src="/js/memory.js"></script>

	<style type="text/css">
		select {
			font-family:'돋움','Dotum','AppleGothic','sans-serif';
		}
	</style>

	<?php } public function printTail($p_intLine, $p_intCol) { ?>
</head><?php } } ?>