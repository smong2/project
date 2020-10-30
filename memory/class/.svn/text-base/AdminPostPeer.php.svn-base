<?php
class AdminPostPeer extends BaseObject
{
	function hash_hmac_php4($algo,$data,$passwd)
	{
		$algo=strtolower($algo);
		$p=array('md5'=>'H32','sha1'=>'H40');
		if(strlen($passwd)>64) $passwd=pack($p[$algo],$algo($passwd));
		if(strlen($passwd)<64) $passwd=str_pad($passwd,64,chr(0));
		$ipad=substr($passwd,0,64) ^ str_repeat(chr(0x36),64);
		$opad=substr($passwd,0,64) ^ str_repeat(chr(0x5C),64);
		return($algo($opad.pack($p[$algo],$algo($ipad.$data))));
	}
	
	function Daum_OpenAPI_Sign( $api_url, $apid, $apikey, $sig_key) 
	{	
		$api_call_url = $api_url . '?apid=' . $apid . '&apikey=' . $apikey;
		$bin_sig_key = pack("H*",$sig_key);
		Logger::debug($bin_sig_key);
		$timestamp = gmdate( 'YmdHis' );
		$nonce = "";
	
		for ( $i=0; $i< 8 ; $i++)
		{
			$hex_byte = sprintf("%02s", dechex( mt_rand(0,255))); 
			$nonce = $nonce . $hex_byte;
		}
	
		$to_be_signed_str = $api_call_url . '&ts=' . $timestamp . '&nonce=' . $nonce ;
		$signature = AdminPostPeer::hash_hmac_php4( 'sha1', $to_be_signed_str , $bin_sig_key );
		$signed_api_call_url = $to_be_signed_str . '&sigalg=hmacsha1&sig=' . $signature;
		
		return $signed_api_call_url;
	}
}
?>
