<?php /* /home/mong/project/memory/template/Mybox/Index.tpl */ class Mybox_IndexTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public function printHead($p_intLine, $p_intCol) { ?>기억함 관리
<br />
<a href="config/index">기본설정</a> |
<a href="config/blogsync">기억 외부 공유</a> |
<a href="config/widget">위젯</a> |
<a href="config/invite">초대</a><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>