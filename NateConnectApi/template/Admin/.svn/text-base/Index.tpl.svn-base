<head>
	<head>
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

		.useN {
			color:#ff0000;
		}
		.useY {
			color:#0000FF;
		}
	 </style>

	 <script type="text/javascript" language="javascript">
		function svc_delete(svc_id)<!--{{{-->
		{
			if (confirm('삭제하시겠습니까?')) {
				location.replace('delete?svc_id='+svc_id);
			}

			return false;
		}<!--}}}-->

		function updateUse(svc_id, use_fl)<!--{{{-->
		{
			location.replace('updateUse?svc_id='+svc_id+'&use_fl='+use_fl);
			return false;
		}<!--}}}-->

		function svc_add()<!--{{{-->
		{
			if (frm.svc_id.value == '') {
				alert('아이디를 입력해주세요');
				return false;
			}
			if (frm.svc_pwd.value == '') {
				alert('서비스키를 입력해주세요');
				return false;
			}
		}<!--}}}-->
	 </script>
	 <title>서비스 계정 관리</title>
	</head>

	<body>
		<br/>
		<h3 align="center">서비스 계정 관리</h3>

		
		<form name="frm" method="post" action="/admin/addSvc" onsubmit="return svc_add();">
		<table width="30%"  class="detail" align="center">
			<tr align="center" class="detail">
				<td>아이디</td>
				<td>서비스키</td>
				<td>등록</td>
			</tr>
			<tr align="center">
				<td><input type="text" name="svc_id" maxlength="20" size="10"/></td>
				<td><input type="text" name="svc_pwd" maxlength="20" size="10"/></td>
				<td>
					<button type="submit">등록</button>
				</td>
			</tr>
		</table>
		</form>
<br/>
		<table width="80%" cellpadding="0" cellspacing="0" border="0" align="center" class="list">
			<tr>
				<th>아이디</th>
				<th>서비스키</th>
				<th>사용여부</th>
				<th>생성일</th>
				<th>변경일</th>
				<th>관리</th>
			</tr>

			<tr podo:foreach="$this->services as $service" align="center">
				<td>{$service->getServiceId()}</td>
				<td>{$service->getServiceKey()}</td>
				<td class="{$service->getUseYN() == Service::USE_N?'useN':'useY'}">{$service->getUseYN() == Service::USE_Y?'사용중':'사용안함'}</td>
				<td class="date">{date('Y.m.d H:i',$service->getCreateD())}</td>
				<td class="date">{$service->getUpdateD()?date('Y.m.d H:i',$service->getUpdateD()):'-'}</td>
				<td>
					<button onclick="svc_delete({@ $service->getServiceId()});">삭제</button>
					<button onclick="updateUse({@ $service->getServiceId()}, {@ $service->getUseYN()});">사용여부 변경</button>
				</td>
			</tr>


		</table>

	</body>
</head>
