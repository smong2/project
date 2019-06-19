<?php /* /home/mong/project/NateConnectApi/template/Main/NotFound.tpl */ class Main_NotFoundTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public function printHead($p_intLine, $p_intCol) { ?><?xml version="1.0" encoding="UTF-8"?>
<NateConnect>
	<code>600</code>
	<message>NOT EXIST URI</message>
</NateConnect><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>