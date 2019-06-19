<?php
class BaseObject
{
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
			trigger_error('BaseObject::__call() - 잘못된 메서드명(=\''.$funcName.'\')입니다.', E_USER_WARNING);
		}

		return null;
	} /*}}}*/
}
?>
