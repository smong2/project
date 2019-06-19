<?php /* /home/mong/project/mycyworld2/template/Invite1/Add.tpl */ class Invite1_AddTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $cmn; public $name; public $group; public function printHead($p_intLine, $p_intCol) { ?><table>
<tr>
<th>cmn : <?php echo $this->cmn; ?></th>
</tr>
<tr>
<th>name : <?php echo $this->name; ?></th>
</tr>
<tr>
<th>group : <?php echo $this->group; ?></th>
</tr>
</table><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>