<?php
	if (!function_exists('xml_parser_create')) {
	    include_once 'PEAR.php';
	    PEAR::loadExtension('xml');
	}
	
	define('XML_RPC_ERROR_INVALID_TYPE', 101);
	define('XML_RPC_ERROR_NON_NUMERIC_FOUND', 102);
	define('XML_RPC_ERROR_CONNECTION_FAILED', 103);
	define('XML_RPC_ERROR_ALREADY_INITIALIZED', 104);
	define('XML_RPC_ERROR_INCORRECT_PARAMS', 105);
	define('XML_RPC_ERROR_PROGRAMMING', 106);
	
	$GLOBALS['XML_RPC_I4'] = 'i4';
	$GLOBALS['XML_RPC_Int'] = 'int';
	$GLOBALS['XML_RPC_Boolean'] = 'boolean';
	$GLOBALS['XML_RPC_Double'] = 'double';
	$GLOBALS['XML_RPC_String'] = 'string';
	$GLOBALS['XML_RPC_DateTime'] = 'dateTime.iso8601';
	$GLOBALS['XML_RPC_Base64'] = 'base64';
	$GLOBALS['XML_RPC_Array'] = 'array';
	$GLOBALS['XML_RPC_Struct'] = 'struct';
	$GLOBALS['XML_RPC_Types'] = array(
	    $GLOBALS['XML_RPC_I4']       => 1,
	    $GLOBALS['XML_RPC_Int']      => 1,
	    $GLOBALS['XML_RPC_Boolean']  => 1,
	    $GLOBALS['XML_RPC_String']   => 1,
	    $GLOBALS['XML_RPC_Double']   => 1,
	    $GLOBALS['XML_RPC_DateTime'] => 1,
	    $GLOBALS['XML_RPC_Base64']   => 1,
	    $GLOBALS['XML_RPC_Array']    => 2,
	    $GLOBALS['XML_RPC_Struct']   => 3,
	);
	
	$GLOBALS['XML_RPC_err'] = array(
	    'unknown_method'      => 1,
	    'invalid_return'      => 2,
	    'incorrect_params'    => 3,
	    'introspect_unknown'  => 4,
	    'http_error'          => 5,
	    'not_response_object' => 6,
	    'invalid_request'     => 7,
	);
	
	$GLOBALS['XML_RPC_str'] = array(
	    'unknown_method'      => 'Unknown method',
	    'invalid_return'      => 'Invalid return payload: enable debugging to examine incoming payload',
	    'incorrect_params'    => 'Incorrect parameters passed to method',
	    'introspect_unknown'  => 'Can\'t introspect: method unknown',
	    'http_error'          => 'Didn\'t receive 200 OK from remote server.',
	    'not_response_object' => 'The requested method didn\'t return an XML_RPC_Response object.',
	    'invalid_request'     => 'Invalid request payload',
	);
	
	$GLOBALS['XML_RPC_defencoding'] = 'UTF-8';
	$GLOBALS['XML_RPC_erruser'] = 800;
	$GLOBALS['XML_RPC_errxml'] = 100;
	$GLOBALS['XML_RPC_backslash'] = chr(92) . chr(92);
	
	if (function_exists('mb_ereg')) {
	    $GLOBALS['XML_RPC_func_ereg'] = 'mb_eregi';
	    $GLOBALS['XML_RPC_func_ereg_replace'] = 'mb_eregi_replace';
	    $GLOBALS['XML_RPC_func_split'] = 'mb_split';
	} else {
	    $GLOBALS['XML_RPC_func_ereg'] = 'eregi';
	    $GLOBALS['XML_RPC_func_ereg_replace'] = 'eregi_replace';
	    $GLOBALS['XML_RPC_func_split'] = 'split';
	}
	
	$GLOBALS['XML_RPC_auto_base64'] = false;
	$GLOBALS['XML_RPC_valid_parents'] = array(
	    'BOOLEAN' => array('VALUE'),
	    'I4' => array('VALUE'),
	    'INT' => array('VALUE'),
	    'STRING' => array('VALUE'),
	    'DOUBLE' => array('VALUE'),
	    'DATETIME.ISO8601' => array('VALUE'),
	    'BASE64' => array('VALUE'),
	    'ARRAY' => array('VALUE'),
	    'STRUCT' => array('VALUE'),
	    'PARAM' => array('PARAMS'),
	    'METHODNAME' => array('METHODCALL'),
	    'PARAMS' => array('METHODCALL', 'METHODRESPONSE'),
	    'MEMBER' => array('STRUCT'),
	    'NAME' => array('MEMBER'),
	    'DATA' => array('ARRAY'),
	    'FAULT' => array('METHODRESPONSE'),
	    'VALUE' => array('MEMBER', 'DATA', 'PARAM', 'FAULT'),
	);
	
	$GLOBALS['XML_RPC_xh'] = array();
	
	function XML_RPC_se($parser_resource, $name, $attrs)
	{
	    global $XML_RPC_xh, $XML_RPC_valid_parents;
	
	    $parser = (int) $parser_resource;
	
	    if ($XML_RPC_xh[$parser]['isf'] >= 2) {
	        return;
	    }
	
	    if (count($XML_RPC_xh[$parser]['stack']) == 0) {
	        if ($name != 'METHODRESPONSE' && $name != 'METHODCALL') {
	            $XML_RPC_xh[$parser]['isf'] = 2;
	            $XML_RPC_xh[$parser]['isf_reason'] = 'missing top level xmlrpc element';
	            return;
	        }
	    } else {
	        if (!in_array($XML_RPC_xh[$parser]['stack'][0], $XML_RPC_valid_parents[$name])) {
	            $name = $GLOBALS['XML_RPC_func_ereg_replace']('[^a-zA-Z0-9._-]', '', $name);
	            $XML_RPC_xh[$parser]['isf'] = 2;
	            $XML_RPC_xh[$parser]['isf_reason'] = "xmlrpc element $name cannot be child of {$XML_RPC_xh[$parser]['stack'][0]}";
	            return;
	        }
	    }
	
	    switch ($name) {
	    case 'STRUCT':
	        $XML_RPC_xh[$parser]['cm']++;
	        $XML_RPC_xh[$parser]['qt'] = 0;
	
	        $cur_val = array();
	        $cur_val['value'] = array();
	        $cur_val['members'] = 1;
	        array_unshift($XML_RPC_xh[$parser]['valuestack'], $cur_val);
	        break;
	
	    case 'ARRAY':
	        $XML_RPC_xh[$parser]['cm']++;
	        $XML_RPC_xh[$parser]['qt'] = 0;
	
	        $cur_val = array();
	        $cur_val['value'] = array();
	        $cur_val['members'] = 0;
	        array_unshift($XML_RPC_xh[$parser]['valuestack'], $cur_val);
	        break;
	
	    case 'NAME':
	        $XML_RPC_xh[$parser]['ac'] = '';
	        break;
	
	    case 'FAULT':
	        $XML_RPC_xh[$parser]['isf'] = 1;
	        break;
	
	    case 'PARAM':
	        $XML_RPC_xh[$parser]['valuestack'] = array();
	        break;
	
	    case 'VALUE':
	        $XML_RPC_xh[$parser]['lv'] = 1;
	        $XML_RPC_xh[$parser]['vt'] = $GLOBALS['XML_RPC_String'];
	        $XML_RPC_xh[$parser]['ac'] = '';
	        $XML_RPC_xh[$parser]['qt'] = 0;
	        break;
	
	    case 'I4':
	    case 'INT':
	    case 'STRING':
	    case 'BOOLEAN':
	    case 'DOUBLE':
	    case 'DATETIME.ISO8601':
	    case 'BASE64':
	        $XML_RPC_xh[$parser]['ac'] = ''; // reset the accumulator
	
	        if ($name == 'DATETIME.ISO8601' || $name == 'STRING') {
	            $XML_RPC_xh[$parser]['qt'] = 1;
	
	            if ($name == 'DATETIME.ISO8601') {
	                $XML_RPC_xh[$parser]['vt'] = $GLOBALS['XML_RPC_DateTime'];
	            }
	
	        } elseif ($name == 'BASE64') {
	            $XML_RPC_xh[$parser]['qt'] = 2;
	        } else {
	            $XML_RPC_xh[$parser]['qt'] = 0;
	        }
	        break;
	
	    case 'MEMBER':
	        $XML_RPC_xh[$parser]['ac'] = '';
	        break;
	
	    case 'DATA':
	    case 'METHODCALL':
	    case 'METHODNAME':
	    case 'METHODRESPONSE':
	    case 'PARAMS':
	        break;
	    }
	
	    array_unshift($XML_RPC_xh[$parser]['stack'], $name);
	
	    if ($name != 'VALUE') {
	        $XML_RPC_xh[$parser]['lv'] = 0;
	    }
	}
	
	function XML_RPC_ee($parser_resource, $name)
	{
	    global $XML_RPC_xh;
	
	    $parser = (int) $parser_resource;
	
	    if ($XML_RPC_xh[$parser]['isf'] >= 2) {
	        return;
	    }
	
	    $curr_elem = array_shift($XML_RPC_xh[$parser]['stack']);
	
	    switch ($name) {
	    case 'STRUCT':
	    case 'ARRAY':
	    $cur_val = array_shift($XML_RPC_xh[$parser]['valuestack']);
	    $XML_RPC_xh[$parser]['value'] = $cur_val['value'];
	        $XML_RPC_xh[$parser]['vt'] = strtolower($name);
	        $XML_RPC_xh[$parser]['cm']--;
	        break;
	
	    case 'NAME':
	    $XML_RPC_xh[$parser]['valuestack'][0]['name'] = $XML_RPC_xh[$parser]['ac'];
	        break;
	
	    case 'BOOLEAN':
	        if ($XML_RPC_xh[$parser]['ac'] == '1') {
	            $XML_RPC_xh[$parser]['ac'] = 'true';
	        } else {
	            $XML_RPC_xh[$parser]['ac'] = 'false';
	        }
	
	        $XML_RPC_xh[$parser]['vt'] = strtolower($name);
	
	    case 'I4':
	    case 'INT':
	    case 'STRING':
	    case 'DOUBLE':
	    case 'DATETIME.ISO8601':
	    case 'BASE64':
	        if ($XML_RPC_xh[$parser]['qt'] == 1) {
	            $XML_RPC_xh[$parser]['value'] = $XML_RPC_xh[$parser]['ac'];
	        } elseif ($XML_RPC_xh[$parser]['qt'] == 2) {
	            $XML_RPC_xh[$parser]['value'] = base64_decode($XML_RPC_xh[$parser]['ac']);
	        } elseif ($name == 'BOOLEAN') {
	            $XML_RPC_xh[$parser]['value'] = $XML_RPC_xh[$parser]['ac'];
	        } else {
	            if (!$GLOBALS['XML_RPC_func_ereg']("^[+-]?[0123456789 \t\.]+$", $XML_RPC_xh[$parser]['ac'])) {
	                XML_RPC_Base::raiseError('Non-numeric value received in INT or DOUBLE',
	                                         XML_RPC_ERROR_NON_NUMERIC_FOUND);
	                $XML_RPC_xh[$parser]['value'] = XML_RPC_ERROR_NON_NUMERIC_FOUND;
	            } else {
	                $XML_RPC_xh[$parser]['value'] = $XML_RPC_xh[$parser]['ac'];
	            }
	        }
	
	        $XML_RPC_xh[$parser]['ac'] = '';
	        $XML_RPC_xh[$parser]['qt'] = 0;
	        $XML_RPC_xh[$parser]['lv'] = 3; // indicate we've found a value
	        break;
	
	    case 'VALUE':
	        if ($XML_RPC_xh[$parser]['vt'] == $GLOBALS['XML_RPC_String']) {
	            if (strlen($XML_RPC_xh[$parser]['ac']) > 0) {
	                $XML_RPC_xh[$parser]['value'] = $XML_RPC_xh[$parser]['ac'];
	            } elseif ($XML_RPC_xh[$parser]['lv'] == 1) {
	                // The <value> element was empty.
	                $XML_RPC_xh[$parser]['value'] = '';
	            }
	        }
	
	        $temp = new XML_RPC_Value($XML_RPC_xh[$parser]['value'], $XML_RPC_xh[$parser]['vt']);
	
	        $cur_val = array_shift($XML_RPC_xh[$parser]['valuestack']);
	        if (is_array($cur_val)) {
	            if ($cur_val['members']==0) {
	                $cur_val['value'][] = $temp;
	            } else {
	                $XML_RPC_xh[$parser]['value'] = $temp;
	            }
	            array_unshift($XML_RPC_xh[$parser]['valuestack'], $cur_val);
	        } else {
	            $XML_RPC_xh[$parser]['value'] = $temp;
	        }
	        break;
	
	    case 'MEMBER':
	        $XML_RPC_xh[$parser]['ac'] = '';
	        $XML_RPC_xh[$parser]['qt'] = 0;
	
	        $cur_val = array_shift($XML_RPC_xh[$parser]['valuestack']);
	        if (is_array($cur_val)) {
	            if ($cur_val['members']==1) {
	                $cur_val['value'][$cur_val['name']] = $XML_RPC_xh[$parser]['value'];
	            }
	            array_unshift($XML_RPC_xh[$parser]['valuestack'], $cur_val);
	        }
	        break;
	
	    case 'DATA':
	        $XML_RPC_xh[$parser]['ac'] = '';
	        $XML_RPC_xh[$parser]['qt'] = 0;
	        break;
	
	    case 'PARAM':
	        $XML_RPC_xh[$parser]['params'][] = $XML_RPC_xh[$parser]['value'];
	        break;
	
	    case 'METHODNAME':
	    case 'RPCMETHODNAME':
	        $XML_RPC_xh[$parser]['method'] = $GLOBALS['XML_RPC_func_ereg_replace']("^[\n\r\t ]+", '',
	                                                      $XML_RPC_xh[$parser]['ac']);
	        break;
	    }
	
	    if (isset($GLOBALS['XML_RPC_Types'][strtolower($name)])) {
	        $XML_RPC_xh[$parser]['vt'] = strtolower($name);
	    }
	}
	
	function XML_RPC_cd($parser_resource, $data)
	{
	    global $XML_RPC_xh, $XML_RPC_backslash;
	
	    $parser = (int) $parser_resource;
	
	    if ($XML_RPC_xh[$parser]['lv'] != 3) {
	        if ($XML_RPC_xh[$parser]['lv'] == 1) {	            
	            $XML_RPC_xh[$parser]['qt'] = 1;	            
	            $XML_RPC_xh[$parser]['lv'] = 2;
	        }
		        
	        if (!isset($XML_RPC_xh[$parser]['ac'])) {
	            $XML_RPC_xh[$parser]['ac'] = '';
	        }
	        $XML_RPC_xh[$parser]['ac'] .= $data;
	    }
	}
	
	class XML_RPC_Base extends BaseObject 
	{
	
	    function raiseError($msg, $code)
	    {
	        include_once 'PEAR.php';
	        if (is_object(@$this)) {
	            return PEAR::raiseError(get_class($this) . ': ' . $msg, $code);
	        } else {
	            return PEAR::raiseError('XML_RPC: ' . $msg, $code);
	        }
	    }
	
	    function isError($value)
	    {
	        return is_a($value, 'PEAR_Error');
	    }
	}
	
	class XML_RPC_Client extends XML_RPC_Base 
	{
	    var $path = '';
	    var $server = '';
	    var $protocol = 'http://';
	    var $port = 80;	
	    var $username = '';
	    var $password = '';
	    var $proxy = '';
	    var $proxy_protocol = 'http://';
	    var $proxy_port = 8080;
	    var $proxy_user = '';
	    var $proxy_pass = '';
	    var $errno = 0;
	    var $errstr = '';
	    var $debug = 0;
	    var $headers = '';

	    function XML_RPC_Client($path, $server, $port = 0,
	                            $proxy = '', $proxy_port = 0,
	                            $proxy_user = '', $proxy_pass = '')
	    {
	        $this->path       = $path;
	        $this->proxy_user = $proxy_user;
	        $this->proxy_pass = $proxy_pass;
	
	        $GLOBALS['XML_RPC_func_ereg']('^(http://|https://|ssl://)?(.*)$', $server, $match);
	        if ($match[1] == '') {
	            if ($port == 443) {
	                $this->server   = $match[2];
	                $this->protocol = 'ssl://';
	                $this->port     = 443;
	            } else {
	                $this->server = $match[2];
	                if ($port) {
	                    $this->port = $port;
	                }
	            }
	        } elseif ($match[1] == 'http://') {
	            $this->server = $match[2];
	            if ($port) {
	                $this->port = $port;
	            }
	        } else {
	            $this->server   = $match[2];
	            $this->protocol = 'ssl://';
	            if ($port) {
	                $this->port = $port;
	            } else {
	                $this->port = 443;
	            }
	        }
	
	        if ($proxy) {
	            $GLOBALS['XML_RPC_func_ereg']('^(http://|https://|ssl://)?(.*)$', $proxy, $match);
	            if ($match[1] == '') {
	                if ($proxy_port == 443) {
	                    $this->proxy          = $match[2];
	                    $this->proxy_protocol = 'ssl://';
	                    $this->proxy_port     = 443;
	                } else {
	                    $this->proxy = $match[2];
	                    if ($proxy_port) {
	                        $this->proxy_port = $proxy_port;
	                    }
	                }
	            } elseif ($match[1] == 'http://') {
	                $this->proxy = $match[2];
	                if ($proxy_port) {
	                    $this->proxy_port = $proxy_port;
	                }
	            } else {
	                $this->proxy          = $match[2];
	                $this->proxy_protocol = 'ssl://';
	                if ($proxy_port) {
	                    $this->proxy_port = $proxy_port;
	                } else {
	                    $this->proxy_port = 443;
	                }
	            }
	        }
	    }
	   
	    function setDebug($in)
	    {
	        if ($in) {
	            $this->debug = 1;
	        } else {
	            $this->debug = 0;
	        }
	    }
	
	    function setAutoBase64($in)
	    {
	        if ($in) {
	            $GLOBALS['XML_RPC_auto_base64'] = true;
	        } else {
	            $GLOBALS['XML_RPC_auto_base64'] = false;
	        }
	    }
	
	    function setCredentials($u, $p)
	    {
	        $this->username = $u;
	        $this->password = $p;
	    }
	
	    function send($msg, $timeout = 0)
	    {
	        if (!is_a($msg, 'XML_RPC_Message')) {
	            $this->errstr = 'send()\'s $msg parameter must be an'
	                          . ' XML_RPC_Message object.';
	            $this->raiseError($this->errstr, XML_RPC_ERROR_PROGRAMMING);
	            return 0;
	        }
	        $msg->debug = $this->debug;
	        return $this->sendPayloadHTTP10($msg, $this->server, $this->port,
	                                        $timeout, $this->username,
	                                        $this->password);
	    }

	    function sendPayloadHTTP10($msg, $server, $port, $timeout = 0,
	                               $username = '', $password = '')
	    {
	        if ($this->proxy) {
	            if ($this->proxy_protocol == 'http://') {
	                $protocol = '';
	            } else {
	                $protocol = $this->proxy_protocol;
	            }
	            if ($timeout > 0) {
	                $fp = @fsockopen($protocol . $this->proxy, $this->proxy_port,
	                                 $this->errno, $this->errstr, $timeout);
	            } else {
	                $fp = @fsockopen($protocol . $this->proxy, $this->proxy_port,
	                                 $this->errno, $this->errstr);
	            }
	        } else {
	            if ($this->protocol == 'http://') {
	                $protocol = '';
	            } else {
	                $protocol = $this->protocol;
	            }
	            if ($timeout > 0) {
	                $fp = @fsockopen($protocol . $server, $port,
	                                 $this->errno, $this->errstr, $timeout);
	            } else {
	                $fp = @fsockopen($protocol . $server, $port,
	                                 $this->errno, $this->errstr);
	            }
	        }
	
	        if (!$fp && $this->proxy) {
	            $this->raiseError('Connection to proxy server '
	                              . $this->proxy . ':' . $this->proxy_port
	                              . ' failed. ' . $this->errstr,
	                              XML_RPC_ERROR_CONNECTION_FAILED);
	            return 0;
	        } elseif (!$fp) {
	            $this->raiseError('Connection to RPC server '
	                              . $server . ':' . $port
	                              . ' failed. ' . $this->errstr,
	                              XML_RPC_ERROR_CONNECTION_FAILED);
	            return 0;
	        }
	
	        if ($timeout) {
	            socket_set_timeout($fp, $timeout);
	        }
	
	        if ($username != $this->username) {
	            $this->setCredentials($username, $password);
	        }
	
	        if (empty($msg->payload)) {
	            $msg->createPayload();
	        }
	        $this->createHeaders($msg);
	
	        $op  = $this->headers . "\r\n\r\n";
	        $op .= $msg->payload;
	
	        if (!fputs($fp, $op, strlen($op))) {
	            $this->errstr = 'Write error';
	            return 0;
	        }
	        $resp = $msg->parseResponseFile($fp);
	
	        $meta = socket_get_status($fp);
	        if ($meta['timed_out']) {
	            fclose($fp);
	            $this->errstr = 'RPC server did not send response before timeout.';
	            $this->raiseError($this->errstr, XML_RPC_ERROR_CONNECTION_FAILED);
	            return 0;
	        }
	
	        fclose($fp);
	        return $resp;
	    }
	
	    function createHeaders($msg)
	    {
	        if (empty($msg->payload)) {
	            return false;
	        }
	        if ($this->proxy) {
	            $this->headers = 'POST ' . $this->protocol . $this->server;
	            if ($this->proxy_port) {
	                $this->headers .= ':' . $this->port;
	            }
	        } else {
	           $this->headers = 'POST ';
	        }
	        $this->headers .= $this->path. " HTTP/1.0\r\n";
	
	        $this->headers .= "User-Agent: PEAR XML_RPC\r\n";
	        $this->headers .= 'Host: ' . $this->server . "\r\n";
	
	        if ($this->proxy && $this->proxy_user) {
	            $this->headers .= 'Proxy-Authorization: Basic '
	                     . base64_encode("$this->proxy_user:$this->proxy_pass")
	                     . "\r\n";
	        }
	
	        if ($this->username) {
	            $this->headers .= 'Authorization: Basic '
	                     . base64_encode("$this->username:$this->password")
	                     . "\r\n";
	        }
	
	        $this->headers .= "Content-Type: text/xml\r\n";
	        $this->headers .= 'Content-Length: ' . strlen($msg->payload);
	        return true;
	    }
	}
	
	class XML_RPC_Response extends XML_RPC_Base
	{
	    var $xv;
	    var $fn;
	    var $fs;
	    var $hdrs;
	
	    function XML_RPC_Response($val, $fcode = 0, $fstr = '')
	    {
	        if ($fcode != 0) {
	            $this->fn = $fcode;
	            $this->fs = htmlspecialchars($fstr);
	        } else {
	            $this->xv = $val;
	        }
	    }
	
	    function faultCode()
	    {
	        if (isset($this->fn)) {
	            return $this->fn;
	        } else {
	            return 0;
	        }
	    }
	
	    function faultString()
	    {
	        return $this->fs;
	    }
	
	    function value()
	    {
	        return $this->xv;
	    }
	
	    function serialize()
	    {
	        $rs = "<methodResponse>\n";
	        if ($this->fn) {
	            $rs .= "<fault>
	  <value>
	    <struct>
	      <member>
	        <name>faultCode</name>
	        <value><int>" . $this->fn . "</int></value>
	      </member>
	      <member>
	        <name>faultString</name>
	        <value><string>" . $this->fs . "</string></value>
	      </member>
	    </struct>
	  </value>
	</fault>";
	        } else {
	            $rs .= "<params>\n<param>\n" . $this->xv->serialize() .
	        "</param>\n</params>";
	        }
	        $rs .= "\n</methodResponse>";
	        return $rs;
	    }
	}
	
	class XML_RPC_Message extends XML_RPC_Base
	{
	   
	    var $convert_payload_encoding = false;
	    var $debug = 0;
	    var $send_encoding = '';
	    var $methodname = '';
	    var $params = array();
	    var $payload = '';
	    var $remove_extra_lines = true;
	    var $response_payload = '';

	    function XML_RPC_Message($meth, $pars = 0)
	    {
	        $this->methodname = $meth;
	        if (is_array($pars) && sizeof($pars) > 0) {
	            for ($i = 0; $i < sizeof($pars); $i++) {
	                $this->addParam($pars[$i]);
	            }
	        }
	    }
	
	    function xml_header()
	    {
	        global $XML_RPC_defencoding;
	
	        if (!$this->send_encoding) {
	            $this->send_encoding = $XML_RPC_defencoding;
	        }
	        return '<?xml version="1.0" encoding="' . $this->send_encoding . '"?>'
	               . "\n<methodCall>\n";
	    }
	
	    function xml_footer()
	    {
	        return "</methodCall>\n";
	    }
	
	    function createPayload()
	    {
	        $this->payload = $this->xml_header();
	        $this->payload .= '<methodName>' . $this->methodname . "</methodName>\n";
	        $this->payload .= "<params>\n";
	        for ($i = 0; $i < sizeof($this->params); $i++) {
	            $p = $this->params[$i];
	            $this->payload .= "<param>\n" . $p->serialize() . "</param>\n";
	        }
	        $this->payload .= "</params>\n";
	        $this->payload .= $this->xml_footer();
	        if ($this->remove_extra_lines) {
	            $this->payload = $GLOBALS['XML_RPC_func_ereg_replace']("[\r\n]+", "\r\n", $this->payload);
	        } else {
	            $this->payload = $GLOBALS['XML_RPC_func_ereg_replace']("\r\n|\n|\r|\n\r", "\r\n", $this->payload);
	        }
	        if ($this->convert_payload_encoding) {
	            $this->payload = mb_convert_encoding($this->payload, $this->send_encoding);
	        }
	    }
	
	    function method($meth = '')
	    {
	        if ($meth != '') {
	            $this->methodname = $meth;
	        }
	        return $this->methodname;
	    }
	
	    function serialize()
	    {
	        $this->createPayload();
	        return $this->payload;
	    }
	
	    function addParam($par)
	    {
	        $this->params[] = $par;
	    }
	
	    function getParam($i)
	    {
	        global $XML_RPC_err, $XML_RPC_str;
	
	        if (isset($this->params[$i])) {
	            return $this->params[$i];
	        } else {
	            $this->raiseError('The submitted request did not contain this parameter',
	                              XML_RPC_ERROR_INCORRECT_PARAMS);
	            return new XML_RPC_Response(0, $XML_RPC_err['incorrect_params'],
	                                        $XML_RPC_str['incorrect_params']);
	        }
	    }
	
	    function getNumParams()
	    {
	        return sizeof($this->params);
	    }
	
	    function setConvertPayloadEncoding($in)
	    {
	        if ($in && !function_exists('mb_convert_encoding')) {
	            return $this->raiseError('mb_convert_encoding() is not available',
	                              XML_RPC_ERROR_PROGRAMMING);
	        }
	        $this->convert_payload_encoding = $in;
	    }
	
	    function setSendEncoding($type)
	    {
	        $this->send_encoding = $type;
	    }
	
	    function getEncoding($data)
	    {
	        global $XML_RPC_defencoding;
	
	        if ($GLOBALS['XML_RPC_func_ereg']('<\?xml[^>]*[:space:]*encoding[:space:]*=[:space:]*[\'"]([^"\']*)[\'"]',
	                       $data, $match))
	        {
	            $match[1] = trim(strtoupper($match[1]));
	            switch ($match[1]) {
	                case 'ISO-8859-1':
	                case 'UTF-8':
	                case 'US-ASCII':
	                    return $match[1];
	                    break;
	
	                default:
	                    return $XML_RPC_defencoding;
	            }
	        } else {
	            return $XML_RPC_defencoding;
	        }
	    }
	
	    function parseResponseFile($fp)
	    {
	        $ipd = '';
	        while ($data = @fread($fp, 8192)) {
	            $ipd .= $data;
	        }
	        return $this->parseResponse($ipd);
	    }

	    function parseResponse($data = '')
	    {
	        global $XML_RPC_xh, $XML_RPC_err, $XML_RPC_str, $XML_RPC_defencoding;
	
	        $encoding = $this->getEncoding($data);
	        $parser_resource = xml_parser_create($encoding);
	        $parser = (int) $parser_resource;
	
	        $XML_RPC_xh = array();
	        $XML_RPC_xh[$parser] = array();
	
	        $XML_RPC_xh[$parser]['cm'] = 0;
	        $XML_RPC_xh[$parser]['isf'] = 0;
	        $XML_RPC_xh[$parser]['ac'] = '';
	        $XML_RPC_xh[$parser]['qt'] = '';
	        $XML_RPC_xh[$parser]['stack'] = array();
	        $XML_RPC_xh[$parser]['valuestack'] = array();
	
	        xml_parser_set_option($parser_resource, XML_OPTION_CASE_FOLDING, true);
	        xml_set_element_handler($parser_resource, 'XML_RPC_se', 'XML_RPC_ee');
	        xml_set_character_data_handler($parser_resource, 'XML_RPC_cd');
	
	        $hdrfnd = 0;
	        if ($this->debug) {
	            print "\n<pre>---GOT---\n";
	            print isset($_SERVER['SERVER_PROTOCOL']) ? htmlspecialchars($data) : $data;
	            print "\n---END---</pre>\n";
	        }
	
	        if ($GLOBALS['XML_RPC_func_ereg']('^HTTP', $data) &&
	            !$GLOBALS['XML_RPC_func_ereg']('^HTTP/[0-9\.]+ 200 ', $data) &&
	            !$GLOBALS['XML_RPC_func_ereg']('^HTTP/[0-9\.]+ 10[0-9]([A-Z ]+)?[\r\n]+HTTP/[0-9\.]+ 200', $data))
	        {
	                $errstr = substr($data, 0, strpos($data, "\n") - 1);
	                error_log('HTTP error, got response: ' . $errstr);
	                $r = new XML_RPC_Response(0, $XML_RPC_err['http_error'],
	                                          $XML_RPC_str['http_error'] . ' (' .
	                                          $errstr . ')');
	                xml_parser_free($parser_resource);
	                return $r;
	        }
	
	        if (!$hdrfnd && ($brpos = strpos($data,"\r\n\r\n"))) {
	            $XML_RPC_xh[$parser]['ha'] = substr($data, 0, $brpos);
	            $data = substr($data, $brpos + 4);
	            $hdrfnd = 1;
	        }
	
	        $data = substr($data, 0, strpos($data, "</methodResponse>") + 17);
	        $this->response_payload = $data;
	
	        if (!xml_parse($parser_resource, $data, sizeof($data))) {
	            if (xml_get_current_line_number($parser_resource) == 1) {
	                $errstr = 'XML error at line 1, check URL';
	            } else {
	                $errstr = sprintf('XML error: %s at line %d',
	                                  xml_error_string(xml_get_error_code($parser_resource)),
	                                  xml_get_current_line_number($parser_resource));
	            }
	            error_log($errstr);
	            $r = new XML_RPC_Response(0, $XML_RPC_err['invalid_return'],
	                                      $XML_RPC_str['invalid_return']);
	            xml_parser_free($parser_resource);
	            return $r;
	        }
	
	        xml_parser_free($parser_resource);
	
	        if ($this->debug) {
	            print "\n<pre>---PARSED---\n";
	            var_dump($XML_RPC_xh[$parser]['value']);
	            print "---END---</pre>\n";
	        }
	
	        if ($XML_RPC_xh[$parser]['isf'] > 1) {
	            $r = new XML_RPC_Response(0, $XML_RPC_err['invalid_return'],
	                                      $XML_RPC_str['invalid_return'].' '.$XML_RPC_xh[$parser]['isf_reason']);
	        } elseif (!is_object($XML_RPC_xh[$parser]['value'])) {
	            $r = new XML_RPC_Response(0, $XML_RPC_err['invalid_return'],
	                                      $XML_RPC_str['invalid_return']);
	        } else {
	            $v = $XML_RPC_xh[$parser]['value'];
	            if ($XML_RPC_xh[$parser]['isf']) {
	                $f = $v->structmem('faultCode');
	                $fs = $v->structmem('faultString');
	                $r = new XML_RPC_Response($v, $f->scalarval(),
	                                          $fs->scalarval());
	            } else {
	                $r = new XML_RPC_Response($v);
	            }
	        }
	        $r->hdrs = split("\r?\n", $XML_RPC_xh[$parser]['ha'][1]);
	        return $r;
	    }
	}
	
	class XML_RPC_Value extends XML_RPC_Base
	{
	    var $me = array();
	    var $mytype = 0;
	
	    function XML_RPC_Value($val = -1, $type = '')
	    {
	        $this->me = array();
	        $this->mytype = 0;
	        if ($val != -1 || $type != '') {
	            if ($type == '') {
	                $type = 'string';
	            }
	            if (!array_key_exists($type, $GLOBALS['XML_RPC_Types'])) {
	            } elseif ($GLOBALS['XML_RPC_Types'][$type] == 1) {
	                $this->addScalar($val, $type);
	            } elseif ($GLOBALS['XML_RPC_Types'][$type] == 2) {
	                $this->addArray($val);
	            } elseif ($GLOBALS['XML_RPC_Types'][$type] == 3) {
	                $this->addStruct($val);
	            }
	        }
	    }
	
	    function addScalar($val, $type = 'string')
	    {
	        if ($this->mytype == 1) {
	            $this->raiseError('Scalar can have only one value',
	                              XML_RPC_ERROR_INVALID_TYPE);
	            return 0;
	        }
	        $typeof = $GLOBALS['XML_RPC_Types'][$type];
	        if ($typeof != 1) {
	            $this->raiseError("Not a scalar type (${typeof})",
	                              XML_RPC_ERROR_INVALID_TYPE);
	            return 0;
	        }
	
	        if ($type == $GLOBALS['XML_RPC_Boolean']) {
	            if (strcasecmp($val, 'true') == 0
	                || $val == 1
	                || ($val == true && strcasecmp($val, 'false')))
	            {
	                $val = 1;
	            } else {
	                $val = 0;
	            }
	        }
	
	        if ($this->mytype == 2) {
	            $ar = $this->me['array'];
	            $ar[] = new XML_RPC_Value($val, $type);
	            $this->me['array'] = $ar;
	        } else {
	            $this->me[$type] = $val;
	            $this->mytype = $typeof;
	        }
	        return 1;
	    }
	
	    function addArray($vals)
	    {
	        if ($this->mytype != 0) {
	            $this->raiseError(
	                    'Already initialized as a [' . $this->kindOf() . ']',
	                    XML_RPC_ERROR_ALREADY_INITIALIZED);
	            return 0;
	        }
	        $this->mytype = $GLOBALS['XML_RPC_Types']['array'];
	        $this->me['array'] = $vals;
	        return 1;
	    }
	
	    function addStruct($vals)
	    {
	        if ($this->mytype != 0) {
	            $this->raiseError(
	                    'Already initialized as a [' . $this->kindOf() . ']',
	                    XML_RPC_ERROR_ALREADY_INITIALIZED);
	            return 0;
	        }
	        $this->mytype = $GLOBALS['XML_RPC_Types']['struct'];
	        $this->me['struct'] = $vals;
	        return 1;
	    }
	
	    function dump($ar)
	    {
	        reset($ar);
	        foreach ($ar as $key => $val) {
	            echo "$key => $val<br />";
	            if ($key == 'array') {
	                foreach ($val as $key2 => $val2) {
	                    echo "-- $key2 => $val2<br />";
	                }
	            }
	        }
	    }
	
	    function kindOf()
	    {
	        switch ($this->mytype) {
	        case 3:
	            return 'struct';
	
	        case 2:
	            return 'array';
	
	        case 1:
	            return 'scalar';
	
	        default:
	            return 'undef';
	        }
	    }
	
	    function serializedata($typ, $val)
	    {
	        $rs = '';
	        if (!array_key_exists($typ, $GLOBALS['XML_RPC_Types'])) {
	            return;
	        }
	        switch ($GLOBALS['XML_RPC_Types'][$typ]) {
	        case 3:
	            $rs .= "<struct>\n";
	            reset($val);
	            foreach ($val as $key2 => $val2) {
	                $rs .= "<member><name>${key2}</name>\n";
	                $rs .= $this->serializeval($val2);
	                $rs .= "</member>\n";
	            }
	            $rs .= '</struct>';
	            break;
	
	        case 2:
	            $rs .= "<array>\n<data>\n";
	            for ($i = 0; $i < sizeof($val); $i++) {
	                $rs .= $this->serializeval($val[$i]);
	            }
	            $rs .= "</data>\n</array>";
	            break;
	
	        case 1:
	            switch ($typ) {
	            case $GLOBALS['XML_RPC_Base64']:
	                $rs .= "<${typ}>" . base64_encode($val) . "</${typ}>";
	                break;
	            case $GLOBALS['XML_RPC_Boolean']:
	                $rs .= "<${typ}>" . ($val ? '1' : '0') . "</${typ}>";
	                break;
	            case $GLOBALS['XML_RPC_String']:
	                $rs .= "<${typ}>" . htmlspecialchars($val). "</${typ}>";
	                break;
	            default:
	                $rs .= "<${typ}>${val}</${typ}>";
	            }
	        }
	        return $rs;
	    }
	
	    function serialize()
	    {
	        return $this->serializeval($this);
	    }
	
	    function serializeval($o)
	    {
	        if (!is_object($o) || empty($o->me) || !is_array($o->me)) {
	            return '';
	        }
	        $ar = $o->me;
	        reset($ar);
	        list($typ, $val) = each($ar);
	        return '<value>' .  $this->serializedata($typ, $val) .  "</value>\n";
	    }
	
	    function structmem($m)
	    {
	        return $this->me['struct'][$m];
	    }
	
	    function structreset()
	    {
	        reset($this->me['struct']);
	    }
	
	    function structeach()
	    {
	        return each($this->me['struct']);
	    }
	
	    function getval()
	    {
	        reset($this->me);
	        $b = current($this->me);
	
	        if (is_array($b)) {
	            foreach ($b as $id => $cont) {
	                $b[$id] = $cont->scalarval();
	            }
	        }
	
	        if (is_object($b)) {
	            $t = get_object_vars($b);
	            foreach ($t as $id => $cont) {
	                $t[$id] = $cont->scalarval();
	            }
	            foreach ($t as $id => $cont) {
	                $b->$id = $cont;
	            }
	        }
	
	        return $b;
	    }
	
	    function scalarval()
	    {
	        reset($this->me);
	        $v = current($this->me);
	        if (!is_scalar($v)) {
	            $v = false;
	        }
	        return $v;
	    }
	
	    function scalartyp()
	    {
	        reset($this->me);
	        $a = key($this->me);
	        if ($a == $GLOBALS['XML_RPC_I4']) {
	            $a = $GLOBALS['XML_RPC_Int'];
	        }
	        return $a;
	    }
	
	    function arraymem($m)
	    {
	        return $this->me['array'][$m];
	    }
	
	    function arraysize()
	    {
	        reset($this->me);
	        list($a, $b) = each($this->me);
	        return sizeof($b);
	    }
	
	    function isValue($val)
	    {
	        return (strtolower(get_class($val)) == 'xml_rpc_value');
	    }
	}
	
	function XML_RPC_iso8601_encode($timet, $utc = 0)
	{
	    if (!$utc) {
	        $t = strftime('%Y%m%dT%H:%M:%S', $timet);
	    } else {
	        if (function_exists('gmstrftime')) {
	            $t = gmstrftime('%Y%m%dT%H:%M:%S', $timet);
	        } else {
	            $t = strftime('%Y%m%dT%H:%M:%S', $timet - date('Z'));
	        }
	    }
	    return $t;
	}
	
	function XML_RPC_iso8601_decode($idate, $utc = 0)
	{
	    $t = 0;
	    if ($GLOBALS['XML_RPC_func_ereg']('([0-9]{4})([0-9]{2})([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})', $idate, $regs)) {
	        if ($utc) {
	            $t = gmmktime($regs[4], $regs[5], $regs[6], $regs[2], $regs[3], $regs[1]);
	        } else {
	            $t = mktime($regs[4], $regs[5], $regs[6], $regs[2], $regs[3], $regs[1]);
	        }
	    }
	    return $t;
	}
	
	function XML_RPC_decode($XML_RPC_val)
	{
	    $kind = $XML_RPC_val->kindOf();
	
	    if ($kind == 'scalar') {
	        return $XML_RPC_val->scalarval();
	
	    } elseif ($kind == 'array') {
	        $size = $XML_RPC_val->arraysize();
	        $arr = array();
	        for ($i = 0; $i < $size; $i++) {
	            $arr[] = XML_RPC_decode($XML_RPC_val->arraymem($i));
	        }
	        return $arr;
	
	    } elseif ($kind == 'struct') {
	        $XML_RPC_val->structreset();
	        $arr = array();
	        while (list($key, $value) = $XML_RPC_val->structeach()) {
	            $arr[$key] = XML_RPC_decode($value);
	        }
	        return $arr;
	    }
	}
	
	function XML_RPC_encode($php_val)
	{
	    $type = gettype($php_val);
	    $XML_RPC_val = new XML_RPC_Value;
	
	    switch ($type) {
	    case 'array':
	        if (empty($php_val)) {
	            $XML_RPC_val->addArray($php_val);
	            break;
	        }
	        $tmp = array_diff(array_keys($php_val), range(0, count($php_val)-1));
	        if (empty($tmp)) {
	           $arr = array();
	           foreach ($php_val as $k => $v) {
	               $arr[$k] = XML_RPC_encode($v);
	           }
	           $XML_RPC_val->addArray($arr);
	           break;
	        }
	
	    case 'object':
	        $arr = array();
	        foreach ($php_val as $k => $v) {
	            $arr[$k] = XML_RPC_encode($v);
	        }
	        $XML_RPC_val->addStruct($arr);
	        break;
	
	    case 'integer':
	        $XML_RPC_val->addScalar($php_val, $GLOBALS['XML_RPC_Int']);
	        break;
	
	    case 'double':
	        $XML_RPC_val->addScalar($php_val, $GLOBALS['XML_RPC_Double']);
	        break;
	
	    case 'string':
	    case 'NULL':
	        if ($GLOBALS['XML_RPC_func_ereg']('^[0-9]{8}\T{1}[0-9]{2}\:[0-9]{2}\:[0-9]{2}$', $php_val)) {
	            $XML_RPC_val->addScalar($php_val, $GLOBALS['XML_RPC_DateTime']);
	        } elseif ($GLOBALS['XML_RPC_auto_base64']
	                  && $GLOBALS['XML_RPC_func_ereg']("[^ -~\t\r\n]", $php_val))
	        {
	            $XML_RPC_val->addScalar($php_val, $GLOBALS['XML_RPC_Base64']);
	        } else {
	            $XML_RPC_val->addScalar($php_val, $GLOBALS['XML_RPC_String']);
	        }
	        break;
	
	    case 'boolean':
	        $XML_RPC_val->addScalar($php_val, $GLOBALS['XML_RPC_Boolean']);
	        break;
	
	    case 'unknown type':
	    default:
	        $XML_RPC_val = false;
	    }
	    return $XML_RPC_val;
	}
?>
