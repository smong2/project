<?php /* /home/mong/project/memory/template/Mp/GetMemorizeUsers.tpl */ class Mp_GetMemorizeUsersTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $users = array(); public function printHead($p_intLine, $p_intCol) { ?><?php $_fid_147_var = $this->users; if ($_fid_147_var == false) $_fid_147_var = array(); $_fid_147_idx = 1; $_fid_147_cnt = count($_fid_147_var); foreach ($_fid_147_var as $user) { ?>
	<?php echo $user->getNickname(); ?> <?php if ($this->_foreachIsNotLast($_fid_147_idx, $_fid_147_cnt)) { ?>|<?php } ?>
<?php $_fid_147_idx++; } ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>