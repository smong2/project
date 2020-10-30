<?php
class Util
{
	/**
	 * $url 에 해당하는 파일의 수정 시각을 파라미터로 붙인다.
	 * 
	 * js 나 css 파일에 캐쉬를 적용하기 위해서 사용하는 함수이다.
	 * 캐쉬를 적용할 경우 이 파일이 수정되었을 때 변경된 것을 알려주기 위해서
	 * 파일의 최종 수정 시각을 파라미터로 붙여서 반환한다.
	 * 
	 * @param string $url
	 * 
	 * @return string
	 */
	public static function appendFileModifyTime($url) /*{{{*/
	{
		if (Podo_Util_String::startsWith($url, array('/css/', '/js/')) === false) {
			return $url;
		}

		$filepath = ConfigManager::get('common.basedir') . '/docroot' . $url;

		if (file_exists($filepath) === false) {
			return $url;
		}

		return $url . '?m=' . filemtime($filepath);
	} /*}}}*/

	  /**
	   * Mulit바이트 문자 substr
	   *
	   * 사용법:
	   * echo substrWideChar("한글제목", 5);      // 결과: 한글...
	   * echo substrWideChar("한글제목", 5, "");  // 결과: 한글
	   * 
	   * @param string $raw 자를 문자열
	   * @param integer $maxBytes 최대바이트
	   * @param encoding_type
	   * @param string $omittingString 잘릴 때 뒤에 붙이는 생략표시 문자열.
	   * @return string 크기에 맞게 잘린 문자열.
	   * @access public
	   * @static
	   */
	public static function substrWideChar($str, $maxBytes, $encoding_type = 'UTF-8', $omittingString = '') /*{{{*/
	{
		$length = $maxBytes;
		$first  = 0;
		$alpha  = 0;
		if (function_exists('mb_strimwidth')) {
			$str = mb_strimwidth($str, 0, $length, $omittingString, $encoding_type);
		}
		else {
			if (strlen($str) <= $length && !eregi("^[a-z]+$", $str)) {
				return $str;
			}

			for ($co=1; $co<=$length; $co++) {
				if (self::checkHangul(substr($str, $co-1, $co))) {
					if ($first) {
						// first 값이 있으면 한글의 두번째 바이트로 정의
						$second = 1;
						$first  = 0;
					}
					else {
						// first 값이 없으면 한글의 첫번째 바이트로 정의
						$first  = 1;
						$second = 0;
					}
					$hangul = 1;
				}
				else {
					// 한글이 아닐 경우 한글의 몇번째 바이트인지 나타내는 변수 초기화
					$first = $second = 0;
					// 대문자의 갯수를 기록
					if (self::checkAlphabet(substr($str, $co-1, $co)) == 2) {
						$alpha++;
					}
				}
			}
			// 한글의 첫번째 바이트일 때 깨지는 것을 막기 위해 지정된 길이를 한
			// 바이트 줄임
			if ($first) {
				$length--;
			}

			// 지정된 길이로 문자열을 자르고 문자열 끝의 공백 문자를 삭제함
			// 영문만 있을 경우 대문자의 길이를 1.3으로 하여 초과된 만큼을 뺌
			if ($hangul) {
				$str = chop(substr($str, 0, $length));
			}
			else {
				$str = chop(substr($str, 0, $length-intval($alpha*0.5)));
			}
		}
		return $str;
	} /*}}}*/

	/**
	 * $length = 1 영문 2글자, 한글 1글자
	 */
	public static function cutStr($str, $length, $endString = '')/*{{{*/
	{
		$cuttedStr = mb_convert_encoding($str, 'cp949', 'utf-8');
		$cuttedStr = mb_strcut($cuttedStr, 0, $length * 2, 'cp949');
		
		if (strcmp($str,$cuttedStr)) {
			return mb_convert_encoding($cuttedStr, 'utf-8', 'cp949') . $endString;
		}

		return mb_convert_encoding($cuttedStr, 'utf-8', 'cp949');
	}/*}}}*/

function str_cut($str, $maxlen, $type)
{
	$width = Array(0, 12, 4, 4, 4, 6, 6, 10, 8, 4, 5, 5, 6, 6, 4, 6, 4, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 4, 4, 8, 6, 8, 6, 12, 8, 8, 9, 8, 8, 7, 9, 8, 3, 6, 8, 7, 11, 9, 9, 8, 9, 8, 8, 8, 8, 8, 10, 8, 8, 8, 6, 11, 6, 6, 6, 4, 7, 7, 7, 7, 7, 3, 7, 7, 3, 3, 6, 3, 11, 7, 7, 7, 7, 4, 7, 3, 7, 6, 10, 7, 7, 7, 6, 6, 6, 9, 0);

	$str_buffer = "";
	$len_buffer = 0;
	$count = 0;

					    $str = str_trans_rev($str);
						    $str_len = strlen($str);

							    $maxlen = $width[1] * $maxlen / 2;

								    while( $count < $str_len )
										    {
												        $asc = ord(substr($str, $count, 1));

														        if( $asc < 128 )
																	        {
																				            $len_buffer += $width[$asc-30];

																							            if( $len_buffer > $maxlen )
																											            {
																															                $str_buffer .= "..";
																																			                break;
																																							            }

																																										            $str_buffer .= substr($str, $count, 1);
																																													            $count += 1;
																																																        }
																																																		        else
																																																					        {
																																																								            $len_buffer += $width[1];

																																																											            if( $len_buffer > $maxlen )
																																																															            {
																																																																			                $str_buffer .= "..";
																																																																							                break;
																																																																											            }

																																																																														            $str_buffer .= substr($str, $count, 3);
																																																																																	            $count += 3;
																																																																																				        }
																																																																																						    }

																																																																																							    $str = str_tag_off(str_trans($str));
																																																																																								    $str_buffer = str_tag_off(str_trans($str_buffer));

																																																																																									    return ($type) ? "<span title=\"$str\">".$str_buffer."</span>" : $str_buffer;
}


}
?>
