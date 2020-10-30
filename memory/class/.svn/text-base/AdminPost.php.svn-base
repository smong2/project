<?php
require_once dirname(__FILE__).'/XML/RPC.php';

class AdminPost extends BaseObject
{
	public function Admin_Post(){
	
	$api_url = "http://apis.daum.net/blog/XMLRPC.do";	
	$token_api_url = 'https://apis.daum.net/account/token.daum';
	
	$apid = '4d438ca38cff6a7dd53c';
	$apikey = '09be45d5c079742304e9e74ebf95956fc5652d4e';
	$sig_key = '712da583827459c5cfa319c1bc0d4678dbc727b8';
	$blog_url = "http://blog.daum.net/daumdeveloper";
	
	// Parameters : 제목, 내용, 태그
	$subject = "제목 (". date("Y-m-d H:i:s").")";
	$content = "내용";
	$tag = "tag1, tag2, Mong";
	
	// API 인증
	$signed_api_call_url = AdminPostPeer::Daum_OpenAPI_Sign($api_url, $apid, $apikey, $sig_key);
	
	// 글쓰기 XML_RPC 메시지 생성
	$msg = new XML_RPC_Message("daum.blog.openapi.newPost.execute");
	
	$msg->addParam(new XML_RPC_Value("$subject"));
	$msg->addParam(new XML_RPC_Value("$content"));
	$msg->addParam(new XML_RPC_Value("$tag"));
	$msg->addParam(new XML_RPC_Value(""));
	$msg->addParam(new XML_RPC_Value(""));
	$msg->addParam(new XML_RPC_Value(""));
	$msg->addParam(new XML_RPC_Value(""));
	$msg->addParam(new XML_RPC_Value("207913"));
	
		// XML-RPC Client 생성 및 메시지 전송.
	$parsed_url = parse_url($signed_api_call_url);
	print_r($parsed_url);
	
	$cli = new XML_RPC_Client($parsed_url['path']."?".$parsed_url['query'], $parsed_url['scheme']."://".$parsed_url['host']);
	$resp = $cli->send($msg);
	
	// 불로그 방금 등록된 글번호 얻기
	//$blog_num = strip_tags($resp->value()->serialize());
	
	// 에러 처리
	if(!$resp->faultCode())
	{
	//echo "<a href=$blog_url target=_blank>포스팅 완료</a>";
	
	}
	else
	{
	//echo $resp->faultCode()."<br/>";
	//echo $resp->faultString();
	}
	
	}
}
?>
