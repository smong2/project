<tpl:Common_Html>
	<tpl:Admin_Head>
	</tpl:Admin_Head>

	<tpl:Common_Body>
		<table width="100%" style="margin:10px 0px;">
			<tr>
				<td style="padding-left:10px; font-size:11pt; font-weight:bold;">
					<a href="http://www.nate.com" target="_top"><strong>Nate</strong></a>
					<a href="http://memory.nate.com" target="_top" style="font-size:10pt;">기억나</a>
				</td>
				<td align="right" style="padding-right:10px;">
					{$this->myOfficer->user->getRealNameAndIdStr()} |
					<a href="http://xso.nate.com/rlogout.jsp?redirect=http://memory.nate.com/admin/index" target="_top">로그아웃</a>
				</td>
			</tr>
		</table>
	</tpl:Common_Body>
</tpl:Common_Html>
