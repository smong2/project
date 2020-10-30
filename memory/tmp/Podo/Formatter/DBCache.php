<?php
require_once "SimpleHttp.php";
/**
 * DBCache     1.0.7
 * DBCache.php 1.0.0
 */

/**
 * @class SimpleDBCache
 * @author JEONG, GIL-LYEOL <nanticj@skcomms.co.kr>
 * @version 1.0.0
 */
class SimpleDBCache
{
	private $http = NULL;

	const PATH_ERASE     = "/erase";
	const PATH_ERASE_ALL = "/eraseAll";
	const PATH_MCACHE    = "/mcache";
	const PATH_DBCACHE   = "/dbcache";
	const PATH_MULTI	 = "/multi";

	public function __construct()
	{
		$this->http = new SimpleHttp();
	}

	public function __destruct()
	{
		$this->disconnect();
	}

	/**
	 * bool connect(string $host, 
	 *              int $connTimeout = 0,
	 *              int $sockTimeout = 0);
	 *
	 * $host = "ip:port"
	 * $connTimeout : The connection timeout, in seconds.
	 * $sockTimeout : The socket timeout, int seconds.
	 */
	public function connect($host, $connTimeout = 0, $sockTimeout = 0)
	{
		return $this->http->reconnect($host, $connTimeout, $sockTimeout);
	}

	/**
	 * bool disconnect();
	 */
	public function disconnect()
	{
		return $this->http->disconnect();
	}

	/**
	 * string getHost()
	 */
	public function getHost()
	{
		return $this->http->getHost();
	}

	/**
	 * int errorStatus();
	 */
	public function errorStatus()
	{
		return $this->http->errorStatus();
	}

	/**
	 * string errorString();
	 */
	public function errorString()
	{
		return $this->http->errorString();
	}

	/**
	 * bool eraseAll();
	 */
	public function eraseAll()
	{
		$val;
		$path = self::PATH_ERASE_ALL . "/ALL";
		return $this->http->GET($path, $val);
	}

	/**
	 * bool getPath(string $path, string &$val);
	 */
	public function getPath($path, &$val)
	{
		return $this->http->GET($path, $val);
	}

	/**
	 * bool erasePath(string $path);
	 */
	public function erasePath($path)
	{
		$val;
		$path = self::PATH_ERASE . $path;
		return $this->http->GET($path, $val);
	}

	/**
	 * bool getScript(string $script, string $key, string &$val);
	 */
	public function getScript($script, $key, &$val)
	{
		return $this->getPath($script . "/" . $key, $val);
	}

	/**
	 * bool eraseScript(string $script, string $key);
	 */
	public function eraseScript($script, $key)
	{
		return $this->erasePath($script . "/" . $key);
	}

	/**
	 * bool put(string $key, string $val[, int $exp = 0], string $charset = NULL);
	 */
	public function put($key, $val, $exp = 0, $charset = NULL)
	{
		$result;

		$param = "?command=put";
		if ($exp > 0) {
			$param .= "&expire=" . $exp;
		}
		if ($charset != NULL) {
			$param .= "&charset=" . $charset;
		}

		$path = self::PATH_MCACHE . "/" . $key . $param;
		return $this->http->POST($path, $val, $result);
	}

	/**
	 * bool get(string $key, string &$val);
	 */
	public function get($key, &$val)
	{
		return $this->getScript(self::PATH_MCACHE, $key, $val);
	}

	/**
	 * bool del(string $key);
	 */
	public function del($key)
	{
		return $this->eraseScript(self::PATH_MCACHE, $key);
	}

	/**
	 * bool multiPut(array $keyList, array $valList [, int $exp = 0]);
	 */
	public function multiPut($keyList, $valList, $exp = 0)
	{
		if (count($keyList) != count($valList))
			return false;

		$data = array_combine($keyList, $valList);

		$result;

		$param = "?command=put";
		if ($exp > 0) {
			$param .= "&expire=" . $exp;
		}

		$path = self::PATH_MULTI . $param;
		$jsonData = json_encode($data);
		return $this->http->POST($path, $jsonData, $result);
	}

	/**
	 * bool multiGet(array $keyList, array &$retList);
	 * retList : array ( key1 => value1, key2 => value2 ... )
	 */
	public function multiGet($keyList, &$retList)
	{
		$result;

		$param = "?command=get";

		$path = self::PATH_MULTI . $param;
		$jsonKey = json_encode($keyList);
		$r = $this->http->POST($path, $jsonKey, $result);
		if ($r) {
			$retList = json_decode($result);
		}

		return $r;
	}

	/**
	 * bool multiDel(array $keyList, array &$retList);
	 * retList : array ( key1 => t/f, key2 => t/f ...)
	 */
	public function multiDel($keyList, &$retList)
	{
		$result;

		$param = "?command=del";

		$path = self::PATH_MULTI . $param;
		$jsonKey = json_encode($keyList);
		$r = $this->http->POST($path, $jsonKey, $result);
		if ($r) {
			$retList = json_decode($result);
		}

		return $r;
	}
	
	/**
	 * bool testScriptPut(string $script, string $key, string &$ret);
	 * Only for test ! 
	*/
	public function testScriptPut($script, $key, &$ret)
	{
		$result;

		$param = "/" . $key;

		$path = $script . $param;
		$jsonKey = json_encode($key);
		$r = $this->http->POST($path, $jsonKey, $result);
		if ($r) {
			$retList = json_decode($result);
		}

		return $r;
	}
	
	/**
	 * bool multiScriptGet(string $script, array $keyList, array &$retList);
	 * retList : array ( key1 => value1, key2 => value2 ... )
	 */
	public function multiScriptGet($script, $keyList, &$retList)
	{
		$result;

		$param = $script ."?command=get";

		$path = self::PATH_MULTI . $param;
		$jsonKey = json_encode($keyList);
		$r = $this->http->POST($path, $jsonKey, $result);
		if ($r) {
			$retList = json_decode($result);
		}

		return $r;
	}

	/**
	 * bool multiScriptDel(string $script, array $keyList, array &$retList);
	 * retList : array ( key1 => t/f, key2 => t/f ...)
	 */
	public function multiScriptDel($script, $keyList, &$retList)
	{
		$result;

		$param = $script ."?command=del";

		$path = self::PATH_MULTI . $param;
		$jsonKey = json_encode($keyList);
		$r = $this->http->POST($path, $jsonKey, $result);
		if ($r) {
			$retList = json_decode($result);
		}

		return $r;
	}
};

/**
 * @class ClusterDBCache
 * @author JEONG, GIL-LYEOL <nanticj@skcomms.co.kr>
 * @version 1.0.0
 */
class ClusterDBCache
{
	private $size    = 0;        // @count($this->hosts)
	private $hosts   = array();  // int index   --> string host
	private $caches  = array();  // string host --> SimpleDBCache

	private $connTimeout = 0;
	private $sockTimeout = 0;

	private $status  = -1;
	private $error   = "";

	const ERROR_INVALID_HOSTS_SIZE = "ClusterDBCache, INVALID HOSTS SIZE";
	const ERROR_INVALID_HOSTS      = "ClusterDBCache, INVALID HOSTS";
	const ERROR_NULL_CACHE         = "ClusterDBCache, NULL CACHE";

	public function __construct()
	{
	}

	public function __destruct()
	{
		$this->close();
	}

	/**
	 * int errorStatus();
	 */
	public function errorStatus()
	{
		return $this->status;
	}

	/**
	 * string errorString();
	 */
	public function errorString()
	{
		return $this->error;
	}

	/**
	 * bool open(array string $hosts, 
	 *              int $connTimeout = 0,
	 *              int $sockTimeout = 0);
	 *
	 * $hosts = array ("ip:port")
	 * $connTimeout : The connection timeout, in seconds.
	 * $sockTimeout : The socket timeout, int seconds.
	 */
	public function open(array $hosts, $connTimeout = 0, $sockTimeout = 0)
	{
		// check size
		$this->size = @count($hosts);
		if ($this->size <= 0) {
			$this->setError(-1, self::ERROR_INVALID_HOSTS_SIZE);
			return false;
		}

		// init
		$this->hosts = $hosts;
		$this->connTimeout = $connTimeout;
		$this->sockTimeout = $sockTimeout;
		return true;
	}

	/**
	 * void close();
	 */
	public function close()
	{
		foreach ($this->caches as $host => $cache) {
			$cache->disconnect();
		}
		$this->caches = array();
	}


	public function eraseAll($host)
	{
		// get cache
		$cache = $this->cacheFromHost($host);
		if ($cache === false) {
			return false;
		}

		// run
		if (!$cache->eraseAll()) {
			$this->setErrorCache($cache);
			return false;
		}
		return true;
	}

	/**
	 * bool getScript(string $script, string $key, string &$val);
	 */
	public function getScript($script, $key, &$val)
	{
		// get cache
		$cache = $this->cacheFromKey($key);
		if ($cache === false) {
			return false;
		}

		// run
		if (!$cache->getScript($script, $key, $val)) {
			$this->setErrorCache($cache);
			return false;
		}
		return true;
	}

	/**
	 * bool eraseScript(string $script, string $key);
	 */
	public function eraseScript($script, $key)
	{
		// get cache
		$cache = $this->cacheFromKey($key);
		if ($cache === false) {
			return false;
		}

		// run
		if (!$cache->eraseScript($script, $key)) {
			$this->setErrorCache($cache);
			return false;
		}
		return true;
	}

	/**
	 * bool put(string $key, string $val[, int $exp = 0]);
	 */
	public function put($key, $val, $exp = 0)
	{
		// get cache
		$cache = $this->cacheFromKey($key);
		if ($cache === false) {
			return false;
		}

		// run
		if (!$cache->put($key, $val, $exp)) {
			$this->setErrorCache($cache);
			return false;
		}
		return true;
	}

	/**
	 * bool get(string $key, string &$val);
	 */
	public function get($key, &$val)
	{
		// get cache
		$cache = $this->cacheFromKey($key);
		if ($cache === false) {
			return false;
		}

		// run
		if (!$cache->get($key, $val)) {
			$this->setErrorCache($cache);
			return false;
		}
		return true;
	}

	/**
	 * bool del(string $key);
	 */
	public function del($key)
	{
		// get cache
		$cache = $this->cacheFromKey($key);
		if ($cache === false) {
			return false;
		}

		// run
		if (!$cache->del($key)) {
			$this->setErrorCache($cache);
			return false;
		}
		return true;
	}

	/**
	 * bool multiPut(array $keyList, array $valList [, int $exp = 0]);
	 */
	public function multiPut($keyList, $valList, $exp = 0)
	{
		if (count($keyList) != count($valList))
			return false;

		// initialize key array
		$keyArr = array();
		$valArr = array();
		for ($i = 0; $i < count($this->hosts); $i++) {
			$keyArr[$this->hosts[$i]] = array();
			$valArr[$this->hosts[$i]] = array();
		}

		// split keys according to the host
		for ($i = 0; $i < count($keyList); $i++) {
			$host = $this->hostFromKey($keyList[$i]);
			array_push($keyArr[$host], $keyList[$i]);
			array_push($valArr[$host], $valList[$i]);
		}

		$result = false;

		// process multiPut if key exists
		for ($i = 0; $i < count($this->hosts); $i++) {
			$host = $this->hosts[$i];
			if (count($keyArr[$host]) > 0) {
				$simpleCache = $this->cacheFromHost($host);
				$result |= $simpleCache->multiPut($keyArr[$host], $valArr[$host], $ext);
			}
		}

		return $result;
	}

	/**
	 * bool multiGet(array $keyList, array &$retList);
	 */
	public function multiGet($keyList, &$retList)
	{
		// initialize key array
		$keyArr = array();
		for ($i = 0; $i < count($this->hosts); $i++) {
			$keyArr[$this->hosts[$i]] = array();
		}

		// split keys according to the host
		for ($i = 0; $i < count($keyList); $i++) {
			$host = $this->hostFromKey($keyList[$i]);
			array_push($keyArr[$host], $keyList[$i]);
		}

		$result = false;

		// process multiGet if key exists
		for ($i = 0; $i < count($this->hosts); $i++) {
			$host = $this->hosts[$i];
			$retArray;
			if (count($keyArr[$host]) > 0) {
				$simpleCache = $this->cacheFromHost($host);
				$r = $simpleCache->multiGet($keyArr[$host], $retArray);
				if ($r) {
					if ($retArray) {
						if ($retList === false || $retList == NULL)
							$retList = array();
						$retList = array_merge($retList, (array)$retArray);
					}
				}
				$result |= $r;
			}
		}

		return $result;
	}

	/**
	 * bool multiDel(array $keyList, array &$retList);
	 */
	public function multiDel($keyList, &$retList)
	{
		// initialize key array
		$keyArr = array();
		for ($i = 0; $i < count($this->hosts); $i++) {
			$keyArr[$this->hosts[$i]] = array();
		}

		// split keys according to the host
		for ($i = 0; $i < count($keyList); $i++) {
			$host = $this->hostFromKey($keyList[$i]);
			array_push($keyArr[$host], $keyList[$i]);
		}

		$result = false;

		// process multiDel if key exists
		for ($i = 0; $i < count($this->hosts); $i++) {
			$host = $this->hosts[$i];
			$retArray;
			if (count($keyArr[$host]) > 0) {
				$simpleCache = $this->cacheFromHost($host);
				$r = $simpleCache->multiDel($keyArr[$host], $retArray);
				if ($r) {
					if ($retArray) {
						if ($retList === false || $retList == NULL)
							$retList = array();
						$retList = array_merge($retList, (array)$retArray);
					}
				}
				$result |= $r;
			}
		}

		return $result;
	}

	/**
	 * bool testScriptPut(string $script, string $key, string &$ret);
	 * Only fot test !
	 */
	public function testScriptPut($script, $key, &$ret)
	{
		// initialize key array
		$keyArr = array();
		for ($i = 0; $i < count($this->hosts); $i++) {
			$keyArr[$this->hosts[$i]] = array();
		}

		// split keys according to the host
		$host = $this->hostFromKey($key);
		array_push($keyArr[$host], $key);

		$result = false;

		// process testScriptPut if key exists
		for ($i = 0; $i < count($this->hosts); $i++) {
			$host = $this->hosts[$i];
			$ret;
			if (count($keyArr[$host]) > 0) {
				$simpleCache = $this->cacheFromHost($host);
				$r = $simpleCache->testScriptPut($script, $key, $ret);
				$result |= $r;
			}
		}

		return $result;
	}
	
	/**
	 * bool multiScriptGet(string $script, array $keyList, array &$retList);
	 */
	public function multiScriptGet($script, $keyList, &$retList)
	{
		// initialize key array
		$keyArr = array();
		for ($i = 0; $i < count($this->hosts); $i++) {
			$keyArr[$this->hosts[$i]] = array();
		}

		// split keys according to the host
		for ($i = 0; $i < count($keyList); $i++) {
			$host = $this->hostFromKey($keyList[$i]);
			array_push($keyArr[$host], $keyList[$i]);
		}

		$result = false;

		// process multiScriptGet if key exists
		for ($i = 0; $i < count($this->hosts); $i++) {
			$host = $this->hosts[$i];
			$retArray;
			if (count($keyArr[$host]) > 0) {
				$simpleCache = $this->cacheFromHost($host);
				$r = $simpleCache->multiScriptGet($script, $keyArr[$host], $retArray);
				if ($r) {
					if ($retArray) {
						if ($retList === false || $retList == NULL)
							$retList = array();
						$retList = array_merge($retList, (array)$retArray);
					}
				}
				$result |= $r;
			}
		}

		return $result;
	}

	/**
	 * bool multiScriptDel(string $script, array $keyList, array &$retList);
	 */
	public function multiScriptDel($script, $keyList, &$retList)
	{
		// initialize key array
		$keyArr = array();
		for ($i = 0; $i < count($this->hosts); $i++) {
			$keyArr[$this->hosts[$i]] = array();
		}

		// split keys according to the host
		for ($i = 0; $i < count($keyList); $i++) {
			$host = $this->hostFromKey($keyList[$i]);
			array_push($keyArr[$host], $keyList[$i]);
		}

		$result = false;

		// process multiScriptDel if key exists
		for ($i = 0; $i < count($this->hosts); $i++) {
			$host = $this->hosts[$i];
			$retArray;
			if (count($keyArr[$host]) > 0) {
				$simpleCache = $this->cacheFromHost($host);
				$r = $simpleCache->multiScriptDel($script, $keyArr[$host], $retArray);
				if ($r) {
					if ($retArray) {
						if ($retList === false || $retList == NULL)
							$retList = array();
						$retList = array_merge($retList, (array)$retArray);
					}
				}
				$result |= $r;
			}
		}

		return $result;
	}

	/**
	 * int hash(string $data);
	 */
	private function hash($data)
	{
		// using memcached php library
		return ((@crc32($data) >> 16) & 0x7fff);
	}

	/**
	 * string hostFromKey(string $key);
	 */
	private function hostFromKey($key)
	{
		// check size
		if ($this->size <= 0) {
			$this->setError(-1, self::ERROR_INVALID_HOSTS_SIZE);
			return false;
		}

		// get index
		$index = $this->hash($key) % $this->size;
		while ($index < 0) {
			$index += $this->size;
		}

		// get host
		$host = $this->hosts[$index];
		if ($host === false) {
			$this->setError(-1, self::ERROR_INVALID_HOSTS);
			return false;
		}
		return $host;
	}

	/**
	 * cache cacheFromHost(string $host);
	 */
	private function cacheFromHost($host)
	{
		// check host
		if ($host === false) {
			$this->setError(-1, self::ERROR_INVALID_HOSTS);
			return false;
		}

		// get cache
		$cache = $this->caches[$host];
		if ($cache === false || $cache == NULL) {
			$cache = new SimpleDBCache();
			$this->caches[$host] = $cache;
		}
		if (!$cache->connect($host, $this->connTimeout, $this->sockTimeout)) {
			$this->setErrorCache($cache);
			return false;
		}
		return $cache;
	}

	/**
	 * cache cacheFromKey(string $key);
	 */
	private function cacheFromKey($key)
	{
		$host = $this->hostFromKey($key);
		if ($host === false) {
			return false;
		}
		return $this->cacheFromHost($host);
	}

	/**
	 * void setError($status, $msg = "");
	 */
	private function setError($status, $msg = "")
	{
		$this->status = $status;
		$this->error  = $msg;
	}

	/**
	 * void setErrorCache($cache);
	 */
	private function setErrorCache($cache)
	{
		if ($cache === false || $cache == NULL) {
			$this->setError(-1, self::ERROR_NULL_CACHE);
		} else {
			$this->setError(
				$cache->errorStatus(), 
				$cache->getHost() . " " . $cache->errorString());
		}
	}
};
?>
