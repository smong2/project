<?php
class Podo_Net_Socket extends Net_Socket
{
	function read($size) /*{{{*/
	{
		$retval = '';
		$toread = $size;
		while (!feof($this->fp) && $toread > 0) {
			$buf = parent::read($toread);

			if ($buf === false) {
				return false;
			}

			$toread -= strlen($buf);
			$retval .= $buf;
		}

		return $retval;
	} /*}}}*/
}
?>
