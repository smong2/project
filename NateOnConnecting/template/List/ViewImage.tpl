<tpl:Common_Html>
<head>
	<title>이미지 보기</title>
	<style type="text/css">
		body {
			margin:0px;
		}
	</style>

	<script type="text/javascript" src="/js/common.js"></script>
</head>
<body>
	<a href="#" onclick="window.close(); return false;"><img id="view_image" border="0" src="{$this->request->url}" onload="resizePopupWindow(this.width, this.height)" alt=""/></a>
</body>
</tpl:Common_Html>
