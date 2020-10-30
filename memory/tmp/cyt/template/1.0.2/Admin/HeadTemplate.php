<?php /* /home/mong/project/memory/template/Admin/Head.tpl */ class Admin_HeadTemplate extends Podo_Template_Base { const HAVE_CDATA = TRUE; public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_160 = Podo_Template::instance('Common_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_160->{$__key} = $__val; } $this->_tpl_160->printHead(-1, -1); ?>
	<script type="text/javascript" language="javascript">
	//<!--
		function resizePopupWindow(width, height) {/*{{{*/
			if (typeof(window.innerWidth) == 'number') {
				var w = width - window.innerWidth;
				var h = height - window.innerHeight;
			}
			else {
				var w = width - document.documentElement.clientWidth;
				var h = height - document.documentElement.clientHeight;
			}

			window.resizeBy(w, h);

			document.body.style.overflow = 'hidden';
		}/*}}}*/
	//-->
	</script>

	<style type="text/css">
		body {width:100%;height:100%;margin:0;padding:0;font-size:12px;line-height:1.2em;font-family:'돋움','Dotum','AppleGothic','sans-serif';background-color:#ffffff;}
		td {margin:0;padding:0;}

		table.contents {
			margin-top: 0px;
		}

		table.contents, table.contents input, table.contents select {
			font-family:'돋움','Dotum','AppleGothic','sans-serif';
		}

		td.headline table {
			font-weight: bold; 
			font-size: 13pt;
			color: #FFFFFF;
			background-color: #999999;
		}

		td.headline table td.title {
			padding: 15px 20px;
		}

		td.cmd {
			padding: 0px 30px;
		}

		td.subtitle {
			padding: 0px 30px;
			font-size: 11pt;
			font-weight: bold;
		}

		td.desc {
			padding: 0px 20px;
		}

		table.paging-wrap {
			margin: 0px;
		}

		table.paging-wrap td {
			padding: 0px 0px;
		}

		table.list {
			border-color: #E9E9E9;
			border-style: solid;
			border-width: 2px 0pt;
		}

		table.list th {
			background: #F8F8F8 none repeat scroll 0%;
			border-bottom: 1px solid #E9E9E9;
			color: #333333;
			font-family: '돋움';
			font-size: 9pt;
			font-size-adjust: none;
			font-stretch: normal;
			font-style: normal;
			font-variant: normal;
			font-weight:bold;
			height: 26px;
			line-height: normal;
			padding: 2px 8px 0pt;
		}

		table.list td {
			background: transparent url(http://c1img.cyworld.co.kr/img/minilife/v1/bg_dot-search-text.gif) repeat-x scroll left bottom;
			font-family: verdana;
			font-size: 9pt;
			font-size-adjust: none;
			font-stretch: normal;
			font-style: normal;
			font-variant: normal;
			font-weight: normal;
			letter-spacing: -1px;
			line-height: normal;
			padding: 9px 8px 6px;
		}

		table.list tr.last td {
			background: none;
		}

		table.list td.date {
			color: #888888;
			padding-top: 7px;
			font-size: 7pt;
		}

		table.list td.number {
			color: #444444;
			padding-top: 7px;
			font-size: 7pt;
		}

		span.number {
			color: #666666;
		}

		table.detail {
			border-color: #E9E9E9;
			border-style: solid;
			border-width: 2px 0pt;
		}

		table.detail tr {
			vertical-align: top;
		}

		table.detail tr .form {
			padding-top: 12px;
		}

		table.detail tr th {
			background: #F8F8F8 url(http://c1img.cyworld.co.kr/img/minilife/v1/bg_dot-search-text.gif) repeat-x scroll left bottom;
			font-family: '돋움';
			font-size: 9pt;
			font-size-adjust: none;
			font-stretch: normal;
			font-style: normal;
			font-variant: normal;
			color: #333333;
			font-weight: bold;
			line-height: normal;
			text-align: right;
			padding: 8px 12px 0pt;
			margin-left: 0px;
			margin-right: 0px;
		}

		table.detail tr td {
			background: transparent url(http://c1img.cyworld.co.kr/img/minilife/v1/bg_dot-search-text.gif) repeat-x scroll left bottom;
			font-size: 9pt;
			font-size-adjust: none;
			font-stretch: normal;
			font-style: normal;
			font-variant: normal;
			font-weight: normal;
			line-height: normal;
			padding: 8px 12px 6px;
			margin-left: 0px;
			margin-right: 0px;
		}

		table.detail tr.last th {
			background: #F8F8F8 none repeat scroll 0%
		}

		table.detail tr.last td {
			background: none;
		}

		table.normal, table.normal tr, table.normal tr td, table.normal tr th {
			padding: 0px;
			background: none;
		}

		label.middle {
			position: relative;
			top: -2px;
		}

		table.popup td.headline table td.title {
			padding: 8px 12px;
			font-size: 10pt;
		}

		table.popup td.desc {
			padding: 0px 8px;
		}

		td.top-cmd {
			padding: 0px 10px 10px;
		}

		td.bottom-cmd {
			padding: 10px 10px 0px;
		}
	</style>

	<?php } public function printTail($p_intLine, $p_intCol) { ?>
<?php $this->_tpl_160->printTail(-1, -1); unset($this->_tpl_160); ?><?php } } ?>