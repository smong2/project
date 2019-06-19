<?php /* /home/mong/project/mycyworld2/template/Main/Index.tpl */ class Main_IndexTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public function printHead($p_intLine, $p_intCol) { ?>
<form action="" method="post">

<input type="text" name="goo" id="goo" />
<input type="submit" name="trans" value="변환" />
</form><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>