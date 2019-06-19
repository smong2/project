<?php
class MainController extends Podo_Controller_Base
{
	public function __preProcessor() /*{{{*/
	{
		parent::__preProcessor();
	} /*}}}*/

	public function doIndex() /*{{{*/
	{
       $goo = isset($_POST["goo"])?$_POST["goo"]:"";

	   if($goo)
	   {
		   $short = htmlspecialchars($_POST["goo"]);

		   $string = 'curl http://goo.gl/api/shorten -d url='.$short;
		   $last_line = system($string, $retval);
		   $json = json_decode($last_line);

		   echo nl2br("\n\n");

		   echo '단축 URL : '.$json->short_url;
	   }	
	} /*}}}*/

	public function doNotFound() /*{{{*/
	{
	} /*}}}*/

	public function doUser_View() /*{{{*/
	{
	} /*}}}*/

}
?>
