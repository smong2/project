<?php
class TimeTag extends BaseObject
{
	protected $__timeTagGb;
	protected $__parentGb; // timetag 와 관련된 객체의 구분코드
	protected $__parentSq; // timetag 와 관련된 객체의 일련번호

	protected $__theDay;
	protected $__ago;
	protected $__ages;

	protected $__data; // 각 입력타입별로 입력한 값, 직접입력은 YYYYMMDD, 시절은 시절구분값, 몇년전, 몇살때 등

	protected $__user;
	protected $__insertDt; // 기억일을 산정하기 위한 기준이 되는 시각, 보통 MP 나 MT 를 등록한 시각이다.
	protected $__year;
	protected $__month;
	protected $__day;

	protected $__startYear;

	const PARENT_GB_MP         = 1;
	const PARENT_GB_MT         = 2;
	const PARENT_GB_BASICFIELD = 3;

	const GB_CUSTOM  = 1;
	const GB_THEDAY  = 2;
	const GB_AGO     = 3;
	const GB_AGES    = 4;
	const GB_UNKNOWN = 5;
	const GB_10YEARS = 6;

	const THEDAY_GB_ELEM   = 1;
	const THEDAY_GB_MIDDLE = 2;
	const THEDAY_GB_HIGH   = 3;
	const THEDAY_GB_UNIV   = 4;

	public static $thedays = array(
	    self::THEDAY_GB_ELEM => '초등학교',
	    self::THEDAY_GB_MIDDLE => '중학교',
	    self::THEDAY_GB_HIGH => '고등학교',
	    self::THEDAY_GB_UNIV => '대학교',
	);

	const VALIDATED            = 0;
	const ERROR_GB_INVALID     = 1;
	const ERROR_CUSTOM_EMPTY   = 2;
	const ERROR_CUSTOM_MONTH   = 3;
	const ERROR_CUSTOM_DAY     = 4;
	const ERROR_CUSTOM_FUTURE  = 5;
	const ERROR_THEDAY_EMPTY   = 6;
	const ERROR_THEDAY_INVALID = 7;
	const ERROR_AGO_EMPTY      = 8;
	const ERROR_AGO_INVALID    = 9;
	const ERROR_AGES_EMPTY     = 10;
	const ERROR_AGES_FUTURE    = 11;
	const ERROR_AGES_INVALID   = 12;

	public static $errmsg = array(
	    self::ERROR_GB_INVALID => '알 수 없는 오류가 발생하였습니다.',
	    self::ERROR_CUSTOM_EMPTY => '언제의 기억인지 입력해 주세요.',
	    self::ERROR_CUSTOM_MONTH => '기억일의 월에 해당하는 값을 잘못 입력하였습니다.',
	    self::ERROR_CUSTOM_DAY => '기억일의 일에 해당하는 값을 잘못 입력하였습니다.',
	    self::ERROR_CUSTOM_FUTURE => '기억일에는 미래에 해당하는 날짜는 입력할 수 없습니다.',
	    self::ERROR_THEDAY_EMPTY => '나의 시절을 선택해 주세요.',
	    self::ERROR_THEDAY_INVALID => '알 수 없는 오류가 발생하였습니다.',
	    self::ERROR_AGO_EMPTY => '몇 년 전 기억인지 입력해 주세요.',
	    self::ERROR_AGO_INVALID => '기억일의 몇 년 전 정보를 잘못 입력하였습니다.',
	    self::ERROR_AGES_EMPTY => '몇 살 때 기억인지 입력해 주세요.',
	    self::ERROR_AGES_FUTURE => '기억일에서 고객님의 나이보다 많은 나이를 입력할 수 없습니다.',
	    self::ERROR_AGES_INVALID => '기억일의 몇 살 때 정보를 잘못 입력하였습니다.',
	);

	/***************************************************************************
	 ***** CHECK 함수들 ********************************************************
	 **************************************************************************/

	public function validate() /*{{{*/
	{
		switch ($this->getTimeTagGb()) {
			case self::GB_CUSTOM:
				if ($this->getYear() === '') {
					return self::ERROR_CUSTOM_EMPTY;
				}

				if ($this->getMonth() < 0 || $this->getMonth() > 12) {
					return self::ERROR_CUSTOM_MONTH;
				}

				if ($this->getDay() < 0 || $this->getDay() > 31) {
					return self::ERROR_CUSTOM_DAY;
				}

				if ($this->getMonth() > 0 && $this->getDay() > 0 && checkdate($this->getMonth(), $this->getDay(), $this->getYear()) === false) {
					return self::ERROR_CUSTOM_DAY;
				}

				if (mktime(0, 0, 0, intval($this->getMonth()), intval($this->getDay()), $this->getYear()) > time()) {
					return self::ERROR_CUSTOM_FUTURE;
				}
				break;

			case self::GB_THEDAY:
				if ($this->getTheDay() === '') {
					return self::ERROR_THEDAY_EMPTY;
				}

				if (in_array($this->getTheDay(), array_keys(self::$thedays)) === false) {
					return self::ERROR_THEDAY_INVALID;
				}
				break;

			case self::GB_AGO:
				if ($this->getAgo() === '') {
					return self::ERROR_AGO_EMPTY;
				}

				if ($this->getAgo() < 0) {
					return self::ERROR_AGO_INVALID;
				}
				break;

			case self::GB_AGES:
				if ($this->getAges() === '') {
					return self::ERROR_AGES_EMPTY;
				}

				if ($this->getAges() > $this->getUser()->getKoreanAge()) {
					return self::ERROR_AGES_FUTURE;
				}

				if ($this->getAges() < 0) {
					return self::ERROR_AGES_INVALID;
				}
				break;

			case self::GB_UNKNOWN:
				break;

			default:
				return self::ERROR_GB_INVALID;
		}

		return self::VALIDATED;
	} /*}}}*/

	/***************************************************************************
	 ***** ACTION 함수들 *******************************************************
	 **************************************************************************/

	public function bindValue(PDOStatement $stmt) /*{{{*/
	{
		$stmt->bindValue(':start_year',   $this->getStartYear(),  PDO::PARAM_INT);
		$stmt->bindValue(':start_month',  $this->getStartMonth(), PDO::PARAM_INT);
		$stmt->bindValue(':start_day',    $this->getStartDay(),   PDO::PARAM_INT);
		$stmt->bindValue(':timetag_gb',   $this->getTimeTagGb(),  PDO::PARAM_INT);
		$stmt->bindValue(':timetag_data', $this->getData(),       PDO::PARAM_STR);
	} /*}}}*/

	/***************************************************************************
	 ***** SET 함수들 **********************************************************
	 **************************************************************************/

	/**
	 * FORM 태그로 받은 데이타를 입력할 때는 다음과 같은 함수를 사용한다.
	 * 
	 * setTimeTagGb($timeTagGb)
	 * setCustom($year, $month, $day)
	 * setTheDay($theDay)
	 * setAgo($ago)
	 * setAges($ages)
	 * 
	 * 이를 통해 다음 값들을 자동으로 구할 수 있다.
	 * 
	 * getStartYear()
	 * getStartMonth()
	 * getStartDay()
	 * getData()
	 */
	public function setCustom($year, $month, $day) /*{{{*/
	{
		$this->setYear($year);
		$this->setMonth($month);
		$this->setDay($day);
	} /*}}}*/

	/***************************************************************************
	 ***** GET 함수들 **********************************************************
	 **************************************************************************/

	/**
	 * FORM 태그로 받은 데이타를 입력 후 자동 계산된 값들을 읽어올 수 있다.
	 * 
	 * getStartYear()
	 * getStartMonth()
	 * getStartDay()
	 * getData()
	 */
	public function getStartYear() /*{{{*/
	{
		if (isset($this->__startYear)) {
			return $this->__startYear;
		}

		switch ($this->getTimeTagGb()) {
			case self::GB_CUSTOM:
				return $this->getYear();

			case self::GB_THEDAY:
				return 0;

				/*
				 switch ($this->getTheDay()) {
				 case self::THEDAY_GB_ELEM:
				 return $this->getUser()->getBirthYear() + 7;

				 case self::THEDAY_GB_MIDDLE:
				 return $this->getUser()->getBirthYear() + 13;

				 case self::THEDAY_GB_HIGH:
				 return $this->getUser()->getBirthYear() + 16;

				 case self::THEDAY_GB_UNIV:
				 return $this->getUser()->getBirthYear() + 19;

				 default:
				 return 0;
				 }
				 */

			case self::GB_AGO:
				return date('Y', $this->getInsertDt()) - $this->getAgo();

			case self::GB_AGES:
				return $this->getUser()->getBirthYear() + $this->getAges() - 1;

			default:
				return 0;
		}
	} /*}}}*/

	public function getStartMonth() /*{{{*/
	{
		switch ($this->getTimeTagGb()) {
			case self::GB_CUSTOM:
				return intval($this->getMonth());

			default:
				return 1;
		}
	} /*}}}*/

	public function getStartDay() /*{{{*/
	{
		switch ($this->getTimeTagGb()) {
			case self::GB_CUSTOM:
				return intval($this->getDay());

			default:
				return 1;
		}
	} /*}}}*/

	public function getData() /*{{{*/
	{
		if (isset($this->__data)) {
			return $this->__data;
		}
		else {
			switch ($this->getTimeTagGb()) {
				case self::GB_CUSTOM:
					return sprintf('%04d%02d%02d', $this->getYear(), $this->getMonth(), $this->getDay());

				case self::GB_THEDAY:
					return $this->getTheDay();

				case self::GB_AGO:
					return $this->getAgo();

				case self::GB_AGES:
					return $this->getAges();

				default:
					return '';
			}
		}
	} /*}}}*/

	/**
	 * DB 로부터 데이타를 읽어온 후 자동 계산된 값들을 읽어올 수 있다.
	 * 
	 * getYear()
	 * getMonth()
	 * getDay()
	 * getTheDay()
	 * getAgo()
	 * getAges()
	 */
	public function getYear() /*{{{*/
	{
		if (isset($this->__data)) {
			if ($this->getTimeTagGb() == self::GB_CUSTOM) {
				return intval(substr($this->__data, 0, 4));
			}
			else {
				return '';
			}
		}
		else {
			return $this->__call('getYear', array());
		}
	} /*}}}*/

	public function getMonth() /*{{{*/
	{
		if (isset($this->__data)) {
			if ($this->getTimeTagGb() == self::GB_CUSTOM) {
				return intval(substr($this->__data, 4, 2));
			}
			else {
				return '';
			}
		}
		else {
			return $this->__call('getMonth', array());
		}
	} /*}}}*/

	public function getDay() /*{{{*/
	{
		if (isset($this->__data)) {
			if ($this->getTimeTagGb() == self::GB_CUSTOM) {
				return intval(substr($this->__data, 6, 2));
			}
			else {
				return '';
			}
		}
		else {
			return $this->__call('getDay', array());
		}
	} /*}}}*/

	public function getTheDay() /*{{{*/
	{
		if (isset($this->__data)) {
			if ($this->getTimeTagGb() == self::GB_THEDAY) {
				return $this->__data;
			}
			else {
				return '';
			}
		}
		else {
			return $this->__call('getTheDay', array());
		}
	} /*}}}*/

	public function getAgo() /*{{{*/
	{
		if (isset($this->__data)) {
			if ($this->getTimeTagGb() == self::GB_AGO) {
				return $this->__data;
			}
			else {
				return '';
			}
		}
		else {
			return $this->__call('getAgo', array());
		}
	} /*}}}*/

	public function getAges() /*{{{*/
	{
		if (isset($this->__data)) {
			if ($this->getTimeTagGb() == self::GB_AGES) {
				return $this->__data;
			}
			else {
				return '';
			}
		}
		else {
			return $this->__call('getAges', array());
		}
	} /*}}}*/

	/**
	 * 타임 태그 정보를 이해하기 쉬운 문자열로 반환한다.
	 */
	public function getTimeTagStr() /*{{{*/
	{
		switch ($this->getTimeTagGb()) {
			case self::GB_CUSTOM:
				return $this->getYear() . '.' . $this->getMonth() . '.' . $this->getDay();

			case self::GB_THEDAY:
				return '나의 ' . self::$thedays[$this->getTheDay()] . ' 시절';

			case self::GB_AGO:
				return $this->getAgo() . '년 전';

			case self::GB_AGES:
				return '내가 ' . $this->getAges() . '살 때';

			case self::GB_UNKNOWN:
				return '기억나지 않음';

			default:
				return '';
		}
	} /*}}}*/

	/**
	 * 타임 태그 정보를 간단한 문자열로 반환한다.
	 */
	public function getShortStr() /*{{{*/
	{
		switch ($this->getTimeTagGb()) {
			case self::GB_CUSTOM:
				$retval = '';
				if ($this->getYear() > 0) {
					$retval .= $this->getYear().'년';
				}
				if ($this->getMonth() > 0) {
					$retval .= ' '.$this->getMonth().'월';
				}
				if ($this->getDay() > 0) {
					$retval .= ' '.$this->getDay().'일';
				}
				return $retval;

			case self::GB_AGO:
			case self::GB_AGES:
				return $this->getStartYear().'년';

			case self::GB_THEDAY:
				return self::$thedays[$this->getTheDay()] . ' 시절';

			case self::GB_UNKNOWN:
				return '';

			default:
				return '';
		}
	} /*}}}*/
}
?>
