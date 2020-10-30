<?php
/**
 * @class SimpleHttp
 * @author JEONG, GIL-LYEOL <nanticj@skcomms.co.kr>
 * @version 1.0.0
 */
class SimpleHttp
{
	private $sock      = NULL;
	private $host      = "";
	private $timestamp = 0;
	private $status    = -1;
	private $error     = "";

	const DEFAULT_HTTP_PORT  = 80;
	const DEFAULT_KEEP_ALIVE = 10; // reuse 10 sec

	const ERROR_SOCK_IS_CLOSED   = "SimpleHttp, SOCK IS CLOSED";
	const ERROR_SET_TIMEOUT      = "SimpleHttp, SET TIMEOUT";
	const ERROR_SEND_ERROR       = "SimpleHttp, SEND ERROR";
	const ERROR_RECV_ERROR       = "SimpleHttp, RECV ERROR";
	const ERROR_SEND_TIMEDOUT    = "SimpleHttp, SEND TIMEDOUT";
	const ERROR_RECV_TIMEDOUT    = "SimpleHttp, RECV TIMEDOUT";
	const ERROR_INVALID_RESPONSE = "SimpleHttp, INVALID RESPONSE HEADER";

	public function __construct()
	{
	}

	public function __destruct()
	{
		if ($this->sock)
			$this->disconnect();
	}

	/**
	 * string getHost()
	 */
	public function getHost()
	{
		return $this->host;
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
	 * bool connect(string $hostname, 
	 *              int $port,
	 *              int $connTimeout = 0,
	 *              int $sockTimeout = 0);
	 * $connTimeout : The connection timeout, in seconds.
	 * $sockTimeout : The socket timeout, int seconds.
	 */
	public function connect($hostname, $port, $connTimeout = 0, $sockTimeout = 0)
	{
		// set host
		$this->host = $hostname . ":" . $port;

		// clear socket
		if ($this->sock)
			$this->disconnect();

		// create socket
		if ($connTimeout > 0) {
			$sock = @fsockopen($hostname, $port, $errno, $errstr, $connTimeout);
			if ($sock === false) {
				$this->setError(-1, $errstr);
				return false;
			}
		} else {
			$sock = @fsockopen($hostname, $port, $errno, $errstr);
			if ($sock === false) {
				$this->setError(-1, $errstr);
				return false;
			}
		}
		$this->sock = $sock;

		// set socket timeout
		if ($sockTimeout > 0) {
			if (!$this->setTimeout($sockTimeout)) {
				return false;
			}
		}

		// mark timestamp
		$this->markTimestamp();
		return true;
	}

	/**
	 * bool connectHost(string $host, 
	 *              int $connTimeout = 0,
	 *              int $sockTimeout = 0);
	 *
	 * $host = "ip:port"
	 * $connTimeout : The connection timeout, in seconds.
	 * $sockTimeout : The socket timeout, int seconds.
	 */
	public function connectHost($host, $connTimeout = 0, $sockTimeout = 0)
	{
		$hostname = $host;
		$port = self::DEFAULT_HTTP_PORT;

		// HOST = HOSTNAME:PORT
		$pos1 = @strpos($host, ':');
		if ($pos1 === false) {
			// OK
		} else {
			$hostname = @trim(@substr($host, 0, $pos1));
			$port = @intval(@trim(@substr($host, $pos1 + 1)));
		}

		// connect
		return $this->connect($hostname, $port, $connTimeout, $sockTimeout);
	}

	/**
	 * bool reconnect(string $host, 
	 *              int $connTimeout = 0,
	 *              int $sockTimeout = 0);
	 *
	 * $host = "ip:port"
	 * $connTimeout : The connection timeout, in seconds.
	 * $sockTimeout : The socket timeout, int seconds.
	 */
	public function reconnect($host, $connTimeout = 0, $sockTimeout = 0)
	{
		if (!$this->isClosed()) {
			$now = @time();
			if ($now < $this->timestamp + self::DEFAULT_KEEP_ALIVE) {
				// reuse connection
				return true;
			}
		}
		return $this->connectHost($host, $connTimeout, $sockTimeout);
	}

	/**
	 * void disconnect();
	 */
	public function disconnect()
	{
		if ($this->sock) {
			@fclose($this->sock);
			$this->sock = NULL;
		}
	}

	/**
	 * bool GET(string $path, string& $result, string $header = "");
	 */
	public function GET($path, &$result, $header = "")
	{
		if ($this->isClosed()) {
			$this->setError(-1, self::ERROR_SOCK_IS_CLOSED);
			return false;
		}

		$buf =
			"GET " . $path . " HTTP/1.0\r\n" .
			"Connection: Keep-Alive\r\n" .
			$header .
			"\r\n";

		if (!$this->query($buf, $result)) {
			return false;
		}

		return true;
	}

	/**
	 * bool POST(string $path, string $data, string& $result, string $header = "");
	 */
	public function POST($path, $data, &$result, $header = "")
	{
		if ($this->isClosed()) {
			$this->setError(-1, self::ERROR_SOCK_IS_CLOSED);
			return false;
		}

		$buf =
			"POST " . $path . " HTTP/1.0\r\n" .
			"Content-Length: " . @strlen($data) . "\r\n" .
			"Connection: Keep-Alive\r\n" .
			$header .
			"\r\n" .
			$data;

		if (!$this->query($buf, $result)) {
			return false;
		}

		return true;
	}

	/**
	 * void setStatus($status, $msg);
	 */
	private function setStatus($status, $msg = "")
	{
		$this->status = $status;
		$this->error  = $msg;
	}

	/**
	 * void setError($status, $msg);
	 */
	private function setError($status, $msg)
	{
		$this->setStatus($status, $msg);
		$this->disconnect();
	}

	/**
	 * void setSendError()
	 */
	private function setSendError()
	{
		if ($this->isTimedout()) {
			$this->setError(-1, self::ERROR_SEND_TIMEDOUT);
		} else {
			$this->setError(-1, self::ERROR_SEND_ERROR);
		}
	}

	/**
	 * void setRecvError()
	 */
	private function setRecvError()
	{
		if ($this->isTimedout()) {
			$this->setError(-1, self::ERROR_RECV_TIMEDOUT);
		} else {
			$this->setError(-1, self::ERROR_RECV_ERROR);
		}
	}

	/**
	 * bool isTimedout();
	 */
	private function isTimedout()
	{
		$meta = @stream_get_meta_data($this->sock);
		return $meta['timed_out'];
	}

	/**
	 * bool writeRequest(string $request);
	 */
	private function writeRequest($request)
	{
		$n = @fwrite($this->sock, $request);
		if ($n === false || $n != @strlen($request)) {
			$this->setSendError();
			return false;
		}
		return true;
	}

	/**
	 * bool readResponse(string &$response);
	 */
	private function readResponse(&$response)
	{
		// init response
		$response = false;

		// <proto> <code> <message>\r\n
		$status = -1;
		$message = "";
		if (!@feof($this->sock)) {
			$line = @fgets($this->sock);
			if ($line === false) {
				$this->setRecvError();
				return false;
			}

			$pos1 = @strpos($line, ' ');
			if ($pos1 === false) {
				$this->setError(-1, self::ERROR_INVALID_RESPONSE);
				return false;
			}

			$pos2 = @strpos($line, ' ', $pos1 + 1);
			if ($pos2 === false) {
				$this->setError(-1, self::ERROR_INVALID_RESPONSE);
				return false;
			}

			$status = 
				@intval(@trim(@substr($line, $pos1 + 1, $pos2 - $pos1 - 1)));
			$message = @trim(@substr($line, $pos2 + 1));
		}

		// HEADER
		$contentLength = -1;
		$KeepAlive = true;
		$hasHeader = false;
		while (!@feof($this->sock)) {
			$line = @fgets($this->sock);
			if ($line === false) {
				$this->setRecvError();
				return false;
			} else if ($line == "\n" || $line == "\r\n") {
				$hasHeader = true;
				break;
			} else if (!@strncasecmp($line, "Connection:", 11)) {
				$line = @trim(@substr($line, 11));
				if (!@strncasecmp($line, "Keep-Alive", 10)) {
					// OK
				} else if (!@strncasecmp($line, "Close", 5)) {
					$KeepAlive = false;
				} else {
					$KeepAlive = false;
				}
			} else if (!@strncasecmp($line, "Content-Length:", 15)) {
				$line = @trim(@substr($line, 15));
				$contentLength = @intval($line);
			}
		}

		if ($hasHeader === false) {
			$this->setRecvError();
			return false;
		}

		// BODY
		if ($contentLength > 0) {
			$toRead = $contentLength;
			while (!@feof($this->sock) && $toRead > 0) {
				$response .= @fread($this->sock, $toRead);
				$toRead = $contentLength - strlen($response);
			}
			if ($response === false || $contentLength != @strlen($response)) {
				$response = false;
				$this->setRecvError();
				return false;
			}
		}

		// status check
		if ($status == 200) {
			// OK
			$this->setStatus($status);
		} else if ($status == 404) {
			// Not Found
			$this->setStatus($status);
			$response = false;
		} else {
			$this->setError($status, $message);
			return false;
		}

		// Keep-Alive check
		if (!$KeepAlive) {
			$this->disconnect();
		}

		return true;
	}

	/**
	 * bool query(string $request, string &$response);
	 */
	private function query($request, &$response)
	{
		if (!$this->writeRequest($request)) {
			return false;
		}
		if (!$this->readResponse($response)) {
			return false;
		}
		$this->markTimestamp();
		return true;
	}

	/**
	 * bool setTimeout(int $seconds);
	 */
	private function setTimeout($seconds)
	{
		if (!@stream_set_timeout($this->sock, $seconds)) {
			$this->setError(-1, self::ERROR_SET_TIMEOUT);
			return false;
		}
		return true;
	}

	/**
	 * void markTimestamp();
	 */
	private function markTimestamp()
	{
		$this->timestamp = @time();
	}

	/**
	 * bool isClosed();
	 */
	private function isClosed()
	{
		if ($this->sock) {
			return false;
		}
		return true;
	}

};
?>
