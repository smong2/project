<?php /* /home/mong/project/mycyworld2/template/Invite/Accept.tpl */ class Invite_AcceptTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $board; public function printHead($p_intLine, $p_intCol) { ?><table>
<tr>
<th>이름</th>
<td><?php echo print_r($this->board->getMember()->getUserId()); ?></td>


</tr>
</table><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>