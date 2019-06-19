<?php
class BaseObject
{
	protected $isLoaded = false;
	protected $isEmptyStatus;

	public function __call($funcName, $args) /*{{{*/
	{
		if (Podo_Util_String::startsWith($funcName, 'set')) {
			if (count($args) < 1) {
				return null;
			}

			$varName = '__' . strtolower($funcName[3]) . substr($funcName, 4);
			if (property_exists($this, $varName) === false) {
				return null;
			}

			$this->{$varName} = $args[0];

			return true;
		}
		else if (Podo_Util_String::startsWith($funcName, 'get')) {
			$fieldName = strtolower($funcName[3]) . substr($funcName, 4);
			$varName   = '__' . $fieldName;

			if (isset($this->$varName) === false) {
				$setFuncName = 'set' . substr($funcName, 3);
				trigger_error('BaseObject::__call() - '.$fieldName.' 멤버변수는 값이 없습니다. '.$funcName.'() 메서드는 먼저 '.$setFuncName.'() 한 후에 호출해야 합니다.', E_USER_WARNING);
				return null;
			}

			return $this->{$varName} ;
		}
		else if (Podo_Util_String::startsWith($funcName, 'isset')) {
			$fieldName = strtolower($funcName[5]) . substr($funcName, 6);
			$varName   = '__' . $fieldName;

			return isset($this->$varName);
		}
		else if (Podo_Util_String::startsWith($funcName, 'compareWith')) {
			$fieldName   = strtolower($funcName[11]) . substr($funcName, 12);
			$getFuncName = 'get' . substr($funcName, 11);

			$val1 = $args[0]->{$getFuncName} ();
			$val2 = $args[1]->{$getFuncName} ();

			if ($val1 > $val2) {
				return 1;
			}
			else if ($val1 < $val2) {
				return -1;
			}
			else {
				return 0;
			}
		}
		else {
			trigger_error('BaseObject::__call() - 잘못된 함수명(=\''.$funcName.'\')입니다.', E_USER_WARNING);
		}

		return null;
	} /*}}}*/

	public function loadByRowData($row) /*{{{*/
	{
		$this->isLoaded = true;

		foreach ($row as $k=>$v) {
			$funcName = 'set' . Podo_Util_String::capitalize($k);

			if (Podo_Util_String::endsWith($k, '_dt')) {
				$this->{$funcName} (strtotime($v));
			}
			else {
				$this->{$funcName} ($v);
			}
		}
	} /*}}}*/

	/**
	 * 객체의 validates 에서 지정한 범위로 입력값을 제한한다.
	 */
	public function validate() /*{{{*/
	{
		foreach ($this->validates as $variable=>$values) {
			$fieldName = Podo_Util_String::capitalize($variable);
			$varName   = '__' . strtolower($fieldName[0]) . substr($fieldName, 1);
			foreach ($values as $var=>$val) {
				if ($var == 'filter') {
					if (isset($values['options'])) {
						$this->$varName = filter_var($this->$varName, $val, array('options' => $values['options']));
					}
					else {
						$this->$varName = filter_var($this->$varName, $val);
					}

					if ($this->$varName === false) {
						return $values['error'];
					}
				}
				else if ($var == 'max_length') {
					if (mb_strlen($this->$varName) > $val) {
						return $values['error'];
					}
				}
				else if ($var == 'min_length') {
					if (!empty($this->$varName) && strlen($this->$varName) < $val) {
						return $values['error'];
					}
				}
				else if ($var == 'required') {
					if ($val === true && strlen($this->$varName) == 0) {
						return $values['error'];
					}
				}
			}
		}
		return; // No News is Good News!
	} /*}}}*/

	/**
	 * 객체가 값을 리턴했는지 여부
	 * 각 객체의 load() 메소드에서 isEmptyStatus 의 값을 true/false 로 설정한
	 * 후에 사용할 수 있다.
	 */
	public function isEmpty() /*{{{*/
	{
		if (isset($this->isEmptyStatus) === false) {
			trigger_error('isEmpty()를 호출하려면 isEmpty를 지원하도록 load()를 호출해야 합니다.', E_USER_ERROR);
		}
		return $this->isEmptyStatus;
	} /*}}}*/
}
?>
