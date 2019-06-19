<?php /* /home/mong/project/NateOnConnecting/template/Common/Head.tpl */ class Common_HeadTemplate extends Podo_Template_Base { const HAVE_CDATA = TRUE; public $title; public function printHead($p_intLine, $p_intCol) { ?><head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	<title><?php echo htmlspecialchars($this->title ? $this->title : '네이트커넥트'); ?></title>

	<?php if (strpos($_SERVER['HTTP_USER_AGENT'], 'AppleWebKit/')) { ?>
	<meta name="viewport" content="width=device-width, intial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
	<?php } ?>
	<?php if ('/ui/css/common.css') { ?><link href="<?php echo Util::appendFileModifyTime('/ui/css/common.css'); ?>"  rel="stylesheet" type="text/css" /><?php } else { ?><link  rel="stylesheet" type="text/css"><?php } ?><?php if ('/ui/css/common.css' == false) { ?></link><?php } ?>
	<?php if ('/ui/css/main.css') { ?><link href="<?php echo Util::appendFileModifyTime('/ui/css/main.css'); ?>"  rel="stylesheet" type="text/css" /><?php } else { ?><link  rel="stylesheet" type="text/css"><?php } ?><?php if ('/ui/css/main.css' == false) { ?></link><?php } ?>
	<style type="text/css">
		html {.overflow:scroll; .overflow-x:hidden;}
	</style>

	<script <?php echo '/js/common.js' !== null ? 'src="'.Util::appendFileModifyTime('/js/common.js').'" ' : ''; ?> type="text/javascript"></script>
	<script <?php echo '/js/trans.js' !== null ? 'src="'.Util::appendFileModifyTime('/js/trans.js').'" ' : ''; ?> type="text/javascript"></script>
	<script <?php echo null !== null ? 'src="'.Util::appendFileModifyTime(null).'" ' : ''; ?> type="text/javascript">
		document.domain = 'nate.com';
	</script>

	<?php } public function printTail($p_intLine, $p_intCol) { ?>
</head><?php } } ?>