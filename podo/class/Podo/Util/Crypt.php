<?php
/**
 * @desc Crypt Class
 * 
 * @package catz
 * @author JongHun Shin <teeroz@nate.com>
 */
class Podo_Util_Crypt
{
	protected static $_strKey = '083a15470c5f1d8e42c70f947721b912';
	protected static $_strIv  = 'f3f73189cc545f8f4ba8c936a921388c';

	/**
	 * @desc encrypt text
	 * 
	 * @param string $strText
	 * @param string $strToEncoding cookie encoding type, 'utf-8', 'euc-kr'
	 * @param string $strKey
	 * @param string $strIv
	 * @return string hex string
	 */
	public static function encrypt($strText, $strKey = null, $strIv = null, $strToEncoding = 'utf-8', $strFromEncoding = 'utf-8') /*{{{*/
	{
		if ($strText === '') {
			return $strText;
		}

		$strOriginalText = $strText;
		if (strtolower(trim($strFromEncoding)) !== strtolower(trim($strToEncoding))) {
			$strOriginalText = mb_convert_encoding($strOriginalText, $strToEncoding, $strFromEncoding);
		}
		$strEncryptedText = mcrypt_cbc(MCRYPT_RIJNDAEL_128, self::getKey($strKey), $strOriginalText, MCRYPT_ENCRYPT, self::getIv($strIv));
		return bin2hex($strEncryptedText);
	} /*}}}*/

	/**
	 * @desc decrypt text
	 * 
	 * @param string $strText hex string
	 * @param string $strFromEncoding cookie encoding type, 'utf-8', 'euc-kr'
	 * @param string $strKey
	 * @param string $strIv
	 * @return string
	 */
	public static function decrypt($strText, $strKey = '', $strIv = '', $strToEncoding = 'utf-8', $strFromEncoding = 'utf-8') /*{{{*/
	{
		if ($strText === '') {
			return $strText;
		}

		$strHexText       = pack('H*', $strText);
		$strDecryptedText = mcrypt_cbc(MCRYPT_RIJNDAEL_128, self::getKey($strKey), $strHexText, MCRYPT_DECRYPT, self::getIv($strIv));

		$strDecryptedText = str_replace("\0", '', $strDecryptedText);

		if (strtolower(trim($strFromEncoding)) !== strtolower(trim($strToEncoding))) {
			$strDecryptedText = mb_convert_encoding($strDecryptedText, $strToEncoding, $strFromEncoding);
		}

		return $strDecryptedText;
	} /*}}}*/

	public static function generateKey($strWord = '') /*{{{*/
	{
		if ($strWord === '') {
			return self::$_strKey;
		}

		$retval = $strWord;
		do {
			$retval = self::encrypt($retval);
		} while (strlen($retval) < 32);

		return $retval;
	} /*}}}*/

	protected static function getKey($strKey = null) /*{{{*/
	{
		if ($strKey === null) {
			return pack('H*', self::$_strKey);
		}
		else {
			return pack('H*', $strKey);
		}
	} /*}}}*/

	protected static function getIv($strIv = null) /*{{{*/
	{
		if ($strIv === null) {
			return pack('H*', self::$_strIv);
		}
		else {
			return pack('H*', $strIv);
		}
	} /*}}}*/
}
?>
