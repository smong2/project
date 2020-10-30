<?php
class Podo_Template_Base
{
	public function display($intLine = -1, $intCol = -1) /*{{{*/
	{
		$this->printHead($intLine, $intCol);
		$this->printTail($intLine, $intCol);
	} /*}}}*/

	public function printHead($intLine, $intCol) /*{{{*/
	{
		if (cyt_config::get('cyt.cache.enable', false)) {
			cyt_cache::instance($this)->printHeadCache();
		}
		else {
			$this->_printHead($intLine, $intCol);
		}
	} /*}}}*/

	public function printTail($intLine, $intCol) /*{{{*/
	{
		if (cyt_config::get('cyt.cache.enable', false)) {
			cyt_cache::instance($this)->printTailCache();
		}
		else {
			$this->_printTail($intLine, $intCol);
		}
	} /*}}}*/



	/**
	 * @desc $str 의 따옴표들을 &quot; &#...; 로 변환한다.
	 */
	protected function _replaceQuotes($string) /*{{{*/
	{
		return str_replace(array('"', '\''), array('&quot;', '&#039;'), $string);
	} /*}}}*/

	protected function _escapeAttrib($string) /*{{{*/
	{
		//return str_replace(array('<', '>', '"'), array('&lt;', '&gt;', '&quot;'), $string);
		return htmlspecialchars($string);
	} /*}}}*/

	protected function _foreachIsFirst($intIndex) /*{{{*/
	{
		return $intIndex === 1;
	} /*}}}*/

	protected function _foreachIsNotFirst($intIndex) /*{{{*/
	{
		return $intIndex !== 1;
	} /*}}}*/

	protected function _foreachIsLast($intIndex, $intCnt) /*{{{*/
	{
		return $intIndex === $intCnt;
	} /*}}}*/

	protected function _foreachIsNotLast($intIndex, $intCnt) /*{{{*/
	{
		return $intIndex !== $intCnt;
	} /*}}}*/

	protected function _foreachLowerIndex($intIndex) /*{{{*/
	{
		return $intIndex - 1;
	} /*}}}*/
}
?>
