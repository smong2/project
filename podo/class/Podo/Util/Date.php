<?php
class Podo_Util_Date
{
	/**
	 * @desc 시간 차이를 구해서 배열로 반환한다.
	 * 
	 * @param timestamp $time1
	 * @param timestamp $time2
	 * @return array[year, month, day, hour, minute, second]
	 */
	public static function getDiffDate($time1, $time2 = null) /*{{{*/
	{
		if ($time2 === null) {
			$time2 = time();
		}
		$ago  = getdate($time1);
		$curr = getdate($time2);

		$diff           = array();
		$diff['year']   = $curr['year'] - $ago['year'];
		$diff['month']  = $curr['mon'] - $ago['mon'];
		$diff['day']    = $curr['mday'] - $ago['mday'];
		$diff['hour']   = $curr['hours'] - $ago['hours'];
		$diff['minute'] = $curr['minutes'] - $ago['minutes'];
		$diff['second'] = $curr['seconds'] - $ago['seconds'];

		if ($diff['second'] < 0) {
			$diff['second'] += 60;
			$diff['minute']--;
		}

		if ($diff['minute'] < 0) {
			$diff['minute'] += 60;
			$diff['hour']--;
		}

		if ($diff['hour'] < 0) {
			$diff['hour'] += 24;
			$diff['day']--;
		}

		if ($diff['day'] < 0) {
			if (in_array($ago['mon'], array(1, 3, 5, 7, 8, 10, 12))) {
				$diff['day'] += 31;
			}
			else if (in_array($ago['mon'], array(2, 4, 6, 9, 11))) {
				$diff['day'] += 30;
			}
			else if ($ago['year']%4 == 0 && ($ago['year']%20 != 0 || $ago['year']%100 == 0)) {
				$diff['day'] += 29;
			}
			else {
				$diff['day'] += 28;
			}
			$diff['month']--;
		}

		if ($diff['month'] < 0) {
			$diff['month'] += 12;
			$diff['year']--;
		}

		return $diff;
	} /*}}}*/

	public static function getDiffDateStr($time1, $time2 = null) /*{{{*/
	{
		if ($time2 === false || $time2 === null) {
			$time2 = time();
		}

		if ($time2 !== null && $time1 > $time2) {
			$result     = self::getDiffDate($time2, $time1);
			$strPostfix = '후';
		}
		else {
			$result     = self::getDiffDate($time1, $time2);
			$strPostfix = '전';
		}


		if ($result['year'] > 0) {
			return $result['year'].'년 '.$strPostfix;
		}

		if ($result['month'] > 0) {
			return $result['month'].'개월 '.$strPostfix;
		}

		if ($result['day'] > 0) {
			return $result['day'].'일 '.$strPostfix;
		}

		if ($result['hour'] > 0) {
			return $result['hour'].'시간 '.$strPostfix;
		}

		if ($result['minute'] > 0) {
			return $result['minute'].'분 '.$strPostfix;
		}

		return $result['second'].'초 '.$strPostfix;
	} /*}}}*/

	public static function getDiffDateStrEn($time1, $time2 = null) /*{{{*/
	{
		$result = self::getDiffDate($time1, $time2);

		if ($result['year'] > 0) {
			if ($result['year'] == 1) {
				return $result['year'].' year ago';
			}
			else {
				return $result['year'].' years ago';
			}
		}

		if ($result['month'] > 0) {
			if ($result['month'] == 1) {
				return $result['month'].' month ago';
			}
			else {
				return $result['month'].' months ago';
			}
		}

		if ($result['day'] > 0) {
			if ($result['day'] == 1) {
				return $result['day'].' day ago';
			}
			else {
				return $result['day'].' days ago';
			}
		}

		if ($result['hour'] > 0) {
			if ($result['hour'] == 1) {
				return $result['hour'].' hour ago';
			}
			else {
				return $result['hour'].' hours ago';
			}
		}

		if ($result['minute'] > 0) {
			if ($result['minute'] == 1) {
				return $result['minute'].' minute ago';
			}
			else {
				return $result['minute'].' minutes ago';
			}
		}

		if ($result['second'] == 1) {
			return $result['second'].' second ago';
		}
		else {
			return $result['second'].' seconds ago';
		}
	} /*}}}*/
}
?>
