<?php /* /home/mong/project/memory/template/Mybox/Config/MailForm.tpl */ class Mybox_Config_MailFormTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>

<?php $this->_tpl_4 = Podo_Template::instance('Common_Body'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
Nate 기억나 서비스에 초대합니다!
<br />
본 메일은 어쩌구~!!
Nate 비회원이신 경우 <a href="http://helpdesk.nate.com/faq/exMemberInfo.asp?r_url=https://member.nate.com/sccustomer/join/nate/regist_index.jsp&amp;height=900">여기</a>
를 클릭하여 먼저 회원가입을 해 주시면 되겠습니다.<br />

__message__
<br />
__mp__
<br />
<input type="button" value="기억나 이용하기" onclick="location.href('http://memory.nate.com/mybox/config/emaillcheck');" />
<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>

<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>