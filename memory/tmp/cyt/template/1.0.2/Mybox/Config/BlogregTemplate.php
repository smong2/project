<?php /* /home/mong/project/memory/template/Mybox/Config/Blogreg.tpl */ class Mybox_Config_BlogregTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $req; public $modify; public $request; public function printHead($p_intLine, $p_intCol) { ?><?php 
	$confirmBtn = "<input type='hidden' name='processMode' value='".$this->req->processMode."'/>
						<input type='submit' value='확인' onclick=\"return fnRegBlog();\"/>";

	$blogModify = $this->modify[0];

	switch($this->request->blogId) {
		case 1 : echo "<table>
								<tr>
									<td>* 아이디 </td>
									<td><input type=text name='appid' value='{$blogModify->getApiId()}'/>
								</tr>
								<tr>
									<td>* API Key </td>
									<td><input type='password' name='password'  value='{$blogModify->getblogPassword()}' />
									$confirmBtn</td>
								</tr>
							</table>";
		break;
		case 2 : echo "<table>
								<tr>
									<td>* APP ID</td>
									<td><input type='text' name='appid' value='{$blogModify->getApiId()}' />
								</tr>
								<tr>
									<td>*  API KEY</td>
									<td><input type='password' name='password' value='{$blogModify->getblogPassword()}' />
									$confirmBtn</td>
								</tr>
							</table>";
		break;
		case 3 : echo "<table>
								<tr>
									<td>* APP ID </td>
									<td><input type='text' name='appid' value='{$blogModify->getApiId()}' /></td>
								</tr>
								<tr>
									<td>* Server ID </td>
									<td><input type='text' name='serverid'  size='7' value='{$blogModify->getblogUserId()}' />.tistory.com</td>
								</tr>
								<tr>
									<td>* User Name</td>
									<td><input type='text' name='username' value='{$blogModify->getBlogApiKey()}' /></td>
								</tr>
								<tr>
									<td>* 비밀번호</td>
									<td><input type='password' name='password' value='{$blogModify->getblogPassword()}' />
									$confirmBtn</td>
								</tr>
							</table>
							";
		break;
		case 4 : echo "<table>
								<tr>
									<td>* APP ID </td>
									<td><input type='text' name='appid' /></td>
								</tr>
								<tr>
									<td>* Blog URL </td>
									<td><input type='text' name='serverid' size='7' />.textcube.com</td>
								</tr>
								<tr>
									<td>* Email</td>
									<td><input type='text' name='username' value='{$blogModify->getBlogApiKey()}'/></td>
								</tr>
								<tr>
									<td>* 비밀번호</td>
									<td><input type='password' name='passwd' value='{$blogModify->getblogPassword()}'/>
									$confirmBtn</td>
								</tr>
							</table>";
		break;
		case 5 : echo "<table>
								<tr>
									<td>* APP ID </td>
									<td><input type='text' name='appid' />
								</tr>
								<tr>
									<td>* APP Key</td>
									<td><input type='password' name='passwd' />
									$confirmBtn</td>
								</tr>
							</table>";
		break;
		default:
		break;
	}
?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>