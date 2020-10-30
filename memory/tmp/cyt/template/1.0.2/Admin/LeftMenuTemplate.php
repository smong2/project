<?php /* /home/mong/project/memory/template/Admin/LeftMenu.tpl */ class Admin_LeftMenuTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $myOfficer; public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
	<?php $this->_tpl_4 = Podo_Template::instance('Admin_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
		<style>
			body {margin: 10px 10px;}
			dt {font-weight: bold; margin-bottom: 4px;}
			dd {margin-left: 8px;}
			ul {margin-left: 0px; padding-left: 12px;}
			li {margin-bottom: 4px; }
		</style>
	<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>

	<?php $this->_tpl_10 = Podo_Template::instance('Common_Body'); foreach ($this as $__key=>$__val) { $this->_tpl_10->{$__key} = $__val; } $this->_tpl_10->printHead(-1, -1); ?>
		<dl>
			<dt>기억나 관리</dt>
			<dd>
				<ul>
					<li><a href="home" target="body">Home</a></li>
				</ul>
			</dd>
		</dl>
		<dl>
			<dt>MP 관리</dt>
			<dd>
				<ul>
					<li><?php $this->_isCondResult1 =  ($this->myOfficer->haveAuthOf(AdminMenu::GB_CATEGORY)); if ($this->_isCondResult1) { ?><a href="category/index" target="body"><?php } ?>카테고리 관리<?php if ($this->_isCondResult1) { ?></a><?php } ?></li>
					<li><?php $this->_isCondResult2 =  ($this->myOfficer->haveAuthOf(AdminMenu::GB_MP)); if ($this->_isCondResult2) { ?><a href="mp/index" target="body"><?php } ?>MP 목록<?php if ($this->_isCondResult2) { ?></a><?php } ?></li>
					<li><?php $this->_isCondResult3 =  ($this->myOfficer->haveAuthOf(AdminMenu::GB_MP)); if ($this->_isCondResult3) { ?><a href="mp/add" target="body"><?php } ?>MP 추가<?php if ($this->_isCondResult3) { ?></a><?php } ?></li>
					<li><?php $this->_isCondResult4 =  ($this->myOfficer->haveAuthOf(AdminMenu::GB_MP)); if ($this->_isCondResult4) { ?><a href="mp/trash" target="body"><?php } ?>삭제대기함<?php if ($this->_isCondResult4) { ?></a><?php } ?></li>
				</ul>
			</dd>
		</dl>
		<dl>
			<dt>운영자 관리</dt>
			<dd>
				<ul>
					<li><?php $this->_isCondResult5 =  ($this->myOfficer->haveAuthOf(AdminMenu::GB_OFFICER)); if ($this->_isCondResult5) { ?><a href="officer" target="body"><?php } ?>운영자 관리<?php if ($this->_isCondResult5) { ?></a><?php } ?></li>
					<li><?php $this->_isCondResult6 =  ($this->myOfficer->haveAuthOf(AdminMenu::GB_AUTH)); if ($this->_isCondResult6) { ?><a href="authByOfficer" target="body"><?php } ?>권한 관리 (운영자별)<?php if ($this->_isCondResult6) { ?></a><?php } ?></li>
					<li><?php $this->_isCondResult7 =  ($this->myOfficer->haveAuthOf(AdminMenu::GB_AUTH)); if ($this->_isCondResult7) { ?><a href="authByMenu" target="body"><?php } ?>권한 관리 (메뉴별)<?php if ($this->_isCondResult7) { ?></a><?php } ?></li>
				</ul>
			</dd>
		</dl>
		<dl>
			<dt>기타</dt>
			<dd>
				<ul>
					<li><?php $this->_isCondResult8 =  ($this->myOfficer->haveAuthOf(AdminMenu::GB_LOG)); if ($this->_isCondResult8) { ?><a href="log" target="body"><?php } ?>관리 로그 보기<?php if ($this->_isCondResult8) { ?></a><?php } ?></li>
				</ul>
			</dd>
		</dl>
	<?php $this->_tpl_10->printTail(-1, -1); unset($this->_tpl_10); ?>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>