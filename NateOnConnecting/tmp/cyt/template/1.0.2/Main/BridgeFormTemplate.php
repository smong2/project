<?php /* /home/mong/project/NateOnConnecting/template/Main/BridgeForm.tpl */ class Main_BridgeFormTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $token; public $expireTime; public function printHead($p_intLine, $p_intCol) { ?><form id="fo_bridge" name="bridgeForm" action="http://br.nate.com/index.php" method="post" target="_blank">
	<input type="hidden" name="code" value="<?php echo $this->_escapeAttrib(MainController::NATEON_BRIDGE_CODE); ?>" />
	<input type="hidden" name="r_url" value="http://connect.nate.com" />
	<input type="hidden" name="t" value="<?php echo $this->_escapeAttrib($this->token); ?>" />
	<input type="hidden" name="expireTime" value="<?php echo $this->_escapeAttrib($this->expireTime); ?>" />
</form><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>