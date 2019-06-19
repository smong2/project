<?php /* /home/mong/project/NateOnConnecting/template/Common/Html.tpl */ class Common_HtmlTemplate extends Podo_Template_Base { const HAVE_CDATA = TRUE; public function printHead($p_intLine, $p_intCol) { ?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
    <?php } public function printTail($p_intLine, $p_intCol) { ?>
</html><?php } } ?>