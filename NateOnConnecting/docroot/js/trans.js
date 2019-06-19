/** 네이트온 이모티콘으로 변환
 * @author uno004
 * @return
 */
var CONNECTINGUtil = {
		/** AJAX 호출 함수 */
		oAjaxRequest:function(url,callback,param,opt) {
			var stamp=new Date().getTime();if(param)param+='&stamp='+stamp;else param='stamp='+stamp;var req=createHttpRequest();if(req==null)return false;if(/opera/gi.test(navigator.userAgent)||/safari/gi.test(navigator.userAgent)||/firefox/gi.test(navigator.userAgent)||/netscape/gi.test(navigator.userAgent)){req.onload=function(){callback(req,opt)}}else{req.onreadystatechange=function(){if(req.readyState==4&&req.status==200)callback(req,opt)}}param=uriEncode(param);req.open('POST',url+(url.match(/\?/)?'&':'?')+param,true);setEncHeader(req);req.send(null);function createHttpRequest(){if(window.ActiveXObject){try{return new ActiveXObject("Msxml2.XMLHTTP")}catch(err){try{return new ActiveXObject("Microsoft.XMLHTTP")}catch(err2){try{return new XMLHttpRequest()}catch(err3){return null}}}}else if(window.XMLHttpRequest){return new XMLHttpRequest()}else{return null}}function setEncHeader(obj){var contentTypeUrlenc='application/x-www-form-urlencode; charset=UTF-8';if(!window.opera)obj.setRequestHeader('Content-Type',contentTypeUrlenc);else{if((typeof obj.setRequestHeader)=='function')obj.setRequestHeader('Content-Type',contentTypeUrlenc)}return obj}function uriEncode(data){if(data!=''){var encdata='';if(data.charAt(0)!='&')data='&'+data;var datas=data.split('&');for(var i=1;i<datas.length;i++){var dataq=datas[i].split('=');encdata+='&'+encodeURIComponent(dataq[0])+'='+encodeURIComponent(dataq[1])}}else encdata='';return encdata}
		}
		/** script 호출 */
		,requestJSON:function(url) {
			var head = document.getElementsByTagName("head").item(0);var script = document.createElement ("script");script.src = url;head.appendChild (script);
		}

		/** encodeMessage */
		,encodeMessage:function(s) {
			var enc=s;if(enc)while(enc.indexOf("=")>-1)enc=enc.replace("=","%3D");if(enc)while(enc.indexOf("&")>-1)enc=enc.replace("&","%26");return enc
		}
		/** trim() 함수 */
		,trim:function(str) {
			if( !str )  return ''; return str.replace(/^\s*|\s*$/g,'');
		}	
};

var NOEmoticons = {
	HOST:"http://nateon.connect.nate.com",EMOTICONS:new Array("버거:79.bmp", "어묵:152.bmp", "백호:161.bmp", "붕어빵:153.bmp", "맑음:190.bmp", "호랑이:162.bmp", "폐인:19.bmp", "소:160.bmp", "주먹:148.bmp", "사탕:75.bmp", "딴청:12.bmp", "응가:114.bmp", "시계:43.bmp", "열:27.bmp", "비행기:157.bmp", "험악:41.bmp", "원숭이:184.bmp", "성탄리스:138.bmp", "벽돌:47.bmp", "여:109.bmp", "원숭:85.bmp", "램프:193.bmp", "장미:111.bmp", "빨간양말:131.bmp", "테디:105.bmp", "당근:81.bmp", "19:112.bmp", "돼지:89.bmp", "눈:97.bmp", "복:141.bmp", "양:183.bmp", "엉엉:204.gif", "주사위:175.bmp", "사과:74.bmp", "촛불:62.bmp", "박수:34.bmp", "시들:122.bmp", "모자:156.bmp", "악마:107.bmp", "잠:20.bmp", "선물:58.bmp", "총:56.bmp", "김밥:82.bmp", "쥐:150.bmp", "금메달:196.bmp", "더위:11.bmp", "빼빼로:146.bmp", "달걀:167.bmp", "아령:103.bmp", "토끼:179.bmp", "놀람:29.bmp", "별:93.bmp", "담배:61.bmp", "오락:67.bmp", "에헴:14.bmp", "농구:100.bmp", "흐림:191.bmp", "고글:189.bmp", "음흉:05.bmp", "거부:31.bmp", "거북:87.bmp", "찌릿:26.bmp", "밥:72.bmp", "독도:134.bmp", "소주:76.bmp", "눈사람:137.bmp", "폭탄:66.bmp", "휴지:115.bmp", "약:59.bmp", "달:95.bmp", "닭:185.bmp", "커피:68.bmp", "장갑:171.bmp", "야구:124.bmp", "불꽃:149.bmp", "옐카:48.bmp", "당황:16.bmp", "폭죽:127.bmp", "흐흐:42.bmp", "부끄:08.bmp", "슬픔:17.bmp", "팬더:177.bmp", "취함:22.bmp", "남포:116.bmp", "남:108.bmp", "멍멍:186.bmp", "피자:78.bmp", "복주머니:142.bmp", "전철:53.bmp", "사진:64.bmp", "비:192.bmp", "우승컵:199.bmp", "꽃:45.bmp", "안녕:07.bmp", "빵:73.bmp", "택시:50.bmp", "은메달:197.bmp", "퉤:21.bmp", "쪼옥:206.gif", "도토리:163.bmp", "티비:65.bmp", "번개:99.bmp", "짱:03.bmp", "뱀:181.bmp", "깔깔:201.gif", "윙크:04.bmp", "맥주:71.bmp", "오렌지:168.bmp", "우씨:36.bmp", "웩:23.bmp", "붕어:84.bmp", "단풍잎:195.bmp", "도넛:69.bmp", "카네이션:128.bmp", "메일:60.bmp", "태극일촌:136.bmp", "사랑:101.bmp", "땀찍:33.bmp", "호빵:147.bmp", "황금돼지:144.bmp", "버럭:24.bmp", "새싹:194.bmp", "숭례문:159.bmp", "아휴:202.gif", "냉랭:13.bmp", "말:182.bmp", "로켓:172.bmp", "우산:96.bmp", "꿀꿀:187.bmp", "여포:117.bmp", "루돌프:130.bmp", "찍찍:178.bmp", "오우:203.gif", "다람쥐:164.bmp", "용:180.bmp", "영화:125.bmp", "한숨:39.bmp", "새:91.bmp", "통곡:18.bmp", "조문:155.bmp", "레카:55.bmp", "동메달:198.bmp", "실연:123.bmp", "만족:06.bmp", "성탄종:139.bmp", "우우:37.bmp", "태극:54.bmp", "폰:57.bmp", "천사:106.bmp", "노래:110.bmp", "자장면:170.bmp", "스케이트:188.bmp", "실망:15.bmp", "무지개:98.bmp", "식빵:80.bmp", "차:63.bmp", "버그:119.bmp", "해:94.bmp", "반짝:118.bmp", "컴:52.bmp", "버스:51.bmp", "바퀴:90.bmp", "개:86.bmp", "까치:140.bmp", "나비:88.bmp", "치킨:166.bmp", "돈:113.bmp", "변기:120.bmp", "곰돌이:176.bmp", "돌:49.bmp", "파안:01.bmp", "쳇:25.bmp", "으으:38.bmp", "붉은티:135.bmp", "산타:132.bmp", "전화:44.bmp", "아기돼지:143.bmp", "레드젬:165.bmp", "파이팅:145.bmp", "귀마개:151.bmp", "초코:154.bmp", "라면:83.bmp", "뽀:121.bmp", "뻐끔:205.gif", "케익:77.bmp", "파라솔:174.bmp", "온:126.bmp", "똘똘:30.bmp", "야옹:92.bmp", "쉿:35.bmp", "지팡이:158.bmp", "크림:70.bmp", "추워:28.bmp", "보름달:129.bmp", "핫도그:169.bmp", "메롱:10.bmp", "우주선:173.bmp", "트리:133.bmp", "똥침:09.bmp", "반지:46.bmp", "기도:32.bmp", "스키:102.bmp", "축구:104.bmp", "허걱:40.bmp", "방긋:02.bmp")
	,POBJ:""
	,setDefaultEmoticons:function() {
		this.setEmoticons("real", "dd", "cList");
	}
	,setEmoticons:function(host, tagName, className) {
		var result = "";
		var path = this.HOST + "/images/emoticons/";
		var domain = "http://nateon.connect.nate.com";
		path = "http://nateon.connect.nate.com/images/emoticons/";

		var ParentObj = document;
		if(this.POBJ != "")
			ParentObj = document.getElementById(this.POBJ);
		var el = ParentObj.getElementsByTagName(tagName);	
		for(var i = 0; i < el.length; i++) {
			if(el[i].className==className) { //해당 부분이 내용이면
				var tmpMsg = el[i].innerHTML;
				var pre_link = new RegExp();
				pre_link = /<a[^>]*href(.*)>.*<\/a>/gi;
				tmpMsg = tmpMsg.replace(pre_link, "");
				
				//이모티콘으로 치환
				for(var j = 0; j < this.EMOTICONS.length; j++) {
					var emotiData = this.EMOTICONS[j].split(":");
					var img_path = "<img src=\"" + path + emotiData[1] + "\">";
					if(tmpMsg.indexOf("/" + emotiData[0] + "/") != -1) {
						tmpMsg = tmpMsg.split("/" + emotiData[0] + "/").join(img_path);
						el[i].innerHTML = tmpMsg;
					}
				}
			}
		}
	}
};
/** anchor 태그 입히기
 * @author uno004
 * @return
 */
var CONNECTINGLink = {
	POBJ:"",DIVTAG:"dd",DIVCLASS:"cList", LINKCLASS:"", STAT_CODE:""
	,start:function(pObj) {
		if(pObj != "" || pObj != undefined) this.POBJ = pObj;
		this.setLink();
	}
	,setLink:function() {
		var ParentObj = document;
		if(this.POBJ != "")
			ParentObj = document.getElementById(this.POBJ);
		var el = ParentObj.getElementsByTagName(this.DIVTAG);
		if(this.LINKCLASS != "") link_class = " class=" + this.LINKCLASS;
		for(var i = 0; i < el.length; i++) {
			if(el[i].className == this.DIVCLASS) { //해당 부분이 내용이면
				var tmpMsg = el[i].innerHTML;
				//링크값 지우기
				var pre_link = new RegExp();
				pre_link = /<a[^>]*href(.*)>.*<\/a>/gi;
				tmpMsg = tmpMsg.replace(pre_link, "");
				//모든 태그 없애기
				tmpMsg = tmpMsg.split(/[<](br|BR|Br|bR)[>]/gi).join(" ");
				var objStrip = new RegExp();
				objStrip = /[<][^>]*[>]/gi;
				tmpMsg = tmpMsg.replace(objStrip, "");
				

				//트위터 계정 팝업 으로 변경
				var reg_tw = new RegExp('(@[_0-9a-zA-Z]{1,15})', 'ig');
				if(null != tmpMsg.match(reg_tw)) {
					var tw_keys = tmpMsg.match(reg_tw).join("\n").split("\n");
					var tw_tmpMsg = tmpMsg;
					for(key in tw_keys) {
						var tw_key = tw_keys[key];
						if(typeof(tw_key) == 'string') {
							var tw_id = tw_key.split("@").join("");
							var tw_url = "<a href=\"http://twitter.com/"+tw_id+"\" target=\"_blank\""+link_class+" onfocus=\"blur();\">" + tw_key + "</a>";
							//tw_tmpMsg = tw_tmpMsg.split(tw_key).join(tw_url);
							el[i].innerHTML = el[i].innerHTML.split(tw_key).join(tw_url);
						}
					}
					//el[i].innerHTML = el[i].innerHTML.split(tmpMsg).join(tw_tmpMsg);
				}
				
				
				var re = new RegExp('((http|ftp)(s)?:\/\/\.([^#\(\)\$\>\"\' ]*))', 'ig');
				var result = tmpMsg.match(re);
				if(null != result) {
					result = result.join("\n");
					var urls = result.split("\n");
					var link_tmpMsg = tmpMsg;
					for(key in urls) {
						var cURL = urls[key];
						if(typeof(cURL) == 'string') {
							cURL = cURL.split("&gt;").join(">");
							cURL = cURL.split(/>(.*)/i).join("");
							cURL = cURL.replace(/^\s*/,'').replace(/\s*$/, '');
							if(cURL != "") {
								var reg = new RegExp('<a[^>]*href=\"'+cURL+'\"?([^>]+?)','ig');
								if(el[i].innerHTML.match(reg) == null) {
									var statCode= "";
									if(cURL.indexOf("http://bit.ly") != -1 && "" != this.STAT_CODE)  statCode = "onmousedown=" + this.STAT_CODE;
									var aLink = "<a href=\""+ cURL + "\" onfocus=\"blur()\" target=\"_blank\""+link_class+" "+statCode+">"+ cURL + "</a>";
									//link_tmpMsg = link_tmpMsg.split(cURL).join(aLink);
									el[i].innerHTML = el[i].innerHTML.split(cURL).join(aLink);
								}
							}
						}
					}
					//if(tmpMsg != link_tmpMsg)
					//	el[i].innerHTML = el[i].innerHTML.split(tmpMsg).join(link_tmpMsg);
				}
			} 
		}
	}
};
/** 이미지 태그로 변환
 * @author uno004
 * @return
 */
var CONNECTINGImg = {
	HOST:"http://connect.nate.com",DIVTAG:"dd",DIVCLASS:"cList",IMGSW:"52",IMGLW:"392",IMGCLASS:"thumb2",IMGETC:"",IMGETC2:"",POBJ:""
	,BITLY_STAT_CODE:"", IMG_STAT_CODE:"", IMG_STATIC_URL:"ina.tc,dev1.zul.im:9744,zul.im"
	,THUMBURL:"http://cthumb.nateimg.co.kr",THUMB_S:"thumb_62x0",THUMB_L:"thumb_400x0"
	,ARRSURL:new Array(),PLAINTEXT:"N", LINKCLASS:"",RESIZEFLAG:false
	,init:function(pObj, plainText, linkclass, resizeFlag) {
		if(plainText != undefined || plainText != "") this.PLAINTEXT = plainText;
		if(linkclass != undefined || linkclass != "") this.LINKCLASS = linkclass;
		if(resizeFlag != undefined || resizeFlag != "") this.RESIZEFLAG	= resizeFlag;
		this.start(pObj);
	}
	,start:function(pObj) {
		if(pObj != undefined || pObj != "") this.POBJ = pObj;
		this.changeContents();
	}
	,setImageViewerParam:function(a, b, c, d, e, f, g) {
		this.DIVTAG = a;
		this.DIVCLASS = b;
		this.IMGSW = c;
		this.IMGLW = d;
		this.IMGCLASS = e;
		this.IMGETC = f;
		this.IMGETC2 = g;
	}
	,setStatCode:function(a, b) {
		this.BITLY_STAT_CODE = a;
		this.IMG_STAT_CODE = b;
	}
	,setImgViewer:function(host, pObj, tagName, className, imgClass, imgSw, imgLw, imgEtc, imgEtc2) {
		if(imgEtc == undefined) imgEtc = "";
		if(imgEtc2 == undefined) imgEtc2 = "";
		var domain = this.HOST;
		if("real" == host || "dev" == host) {
			domain = ("real" == host)?"http://connect.nate.com":"http://dev2.connect.nate.com";
			this.HOST = domain;
		}
		
		if(tagName != undefined || tagName != "") this.DIVTAG = tagName;
		if(className != undefined || className != "") this.DIVCLASS = className;
		if(imgClass != undefined || imgClass != "") this.IMGCLASS = imgClass;
		if(imgSw != undefined || imgSw != "") this.IMGSW = imgSw;
		if(imgLw != undefined || imgLw != "") this.IMGLW = imgLw;
		if(imgEtc != undefined || imgEtc != "") this.IMGETC = imgEtc;
		if(imgEtc2 != undefined || imgEtc2 != "") this.IMGETC2 = imgEtc2;
		this.start(pObj);
	}
	,changeContents:function() {
		if(this.PLAINTEXT == "Y") {
			CONNECTINGLink.DIVTAG = this.DIVTAG;
			CONNECTINGLink.DIVCLASS = this.DIVCLASS;
			CONNECTINGLink.LINKCLASS = this.LINKCLASS;
			CONNECTINGLink.STAT_CODE = this.BITLY_STAT_CODE;
			CONNECTINGLink.start(this.POBJ);
		}
		var ParentObj = document;
		if(this.POBJ != "")
			ParentObj = document.getElementById(this.POBJ);
		var el = ParentObj.getElementsByTagName(this.DIVTAG);
		for(var i = 0; i < el.length; i++) {
			if(el[i].className == this.DIVCLASS) { //해당 부분이 내용이면
				var tmpMsg = el[i].innerHTML;
				
				var img_url = this.IMG_STATIC_URL;
				if(-1 != img_url.indexOf(",")) {
					var arr_img_url = img_url.split(",");
					for(var j = 0; j < arr_img_url.length; j ++) {
						this.transImgTag(tmpMsg, el, i, arr_img_url[j]);
					}
				} else
					this.transImgTag(tmpMsg, el, i, img_url);
					
			}
		}
	}
	,transImgTag:function(msg, el, i, url) {
		if(-1 != msg.indexOf("http://" + url)) {
			//var re = new RegExp('<a[^>]*href=\"(http:\/\/ina.tc\/?([^#>\" ]*))\"?([^>]+?)','ig');
			var re = new RegExp('[^\" ](http:\/\/'+url+'?([^>\" ]*))[^<>/]*<','ig');
			var result = msg.match(re);
			if(null != result) {
				result = result.join("\n");
				var urls = result.split("\n");
				for(key in urls) {
					var cURL = urls[key];
					if(typeof(cURL) == 'string') {
						cURL = cURL.split(">").join("").split("<").join("");
						var bImg = false;
						if(-1 !=  cURL.indexOf("zul.im")) {
							if(-1 != cURL.indexOf("\~"))
								bImg = true;
						} else {
							bImg = true;
						}
						if(true == bImg) {
							if(this.ARRSURL[cURL] == undefined) {
								this.getOriginURL(cURL, el[i].id);
							} else {
								var url = el[i].id + "||" + cURL + "||" + this.ARRSURL[cURL];
								this.getResult(url);
							}
						}
					}
				}
			}	
			if(true == this.RESIZEFLAG) ResizeIFrame();
		} 
	}
	,getOriginURL:function(url, id) {
		CONNECTINGUtil.requestJSON("http://connect.nate.com/utility/reverseShortenUrl.nate?url=" + encodeURIComponent(url) + "&id=" + id + "&functionName=CONNECTINGImg.getResult");
	}
	,getResult:function(url) {
		var tmpURL = url.split("||");
		if(tmpURL.length == 3) {
			
			var bTrans = true;
			
			var img_url = this.IMG_STATIC_URL;
			if(-1 != img_url.indexOf(",")) {
				var arr_img_url = img_url.split(",");
				for(var i = 0; i < arr_img_url.length; i++) {
					if(tmpURL[2].toLowerCase().indexOf(arr_img_url[i]) != -1) {
						bTrans = false;
						break; 
					}
				}
			} else
				if("null" != tmpURL[2] && tmpURL[2].indexOf(img_url) != -1) bTrans = false;

			if(true == bTrans) {
				this.ARRSURL[tmpURL[1]] = tmpURL[2]; 
				var contents = document.getElementById(tmpURL[0]).innerHTML;
				var imgURL = this.THUMBURL + "/" + this.THUMB_S + "/" + tmpURL[2];
				//원본 못받아 왔을때는 썸네일 url제거
				//if(tmpURL[2].indexOf("ina.tc") != -1) imgURL = tmpURL[2];
				
				var img_contents =  "<img src=\""+imgURL+"\" style=\"cursor:pointer\" width=\""+this.IMGSW+"\" class=\""+this.IMGCLASS+"\" onerror=\"this.src='http://connect.nate.com/img/2.0/ico_youtube.gif'\"  onclick=\"CONNECTINGImg.click(this)\" \>";
				if("" != this.IMG_STAT_CODE)  img_contents = "<a href=\"#none\" onfocus=\"blur();\" onmousedown=\"" + this.IMG_STAT_CODE + "\">" + img_contents + "</a>";
				var imgTag = this.IMGETC + img_contents + this.IMGETC2;
				
				//이미 링크 변환이 일어났으므로 주석
				//var reg = new RegExp('<img(.*)><a[^>]*href=\"'+tmpURL[1]+'\"?([^>]+?)','ig');
				//if(contents.match(reg) == null) {
					var re = new RegExp('<a([^>]*)href=\"('+tmpURL[1]+')\"','ig');
					contents = decodeURI(contents);
					var reArray = re.exec(contents);
					var statCode= "";
					if("" != this.BITLY_STAT_CODE)  statCode = " onmousedown=" + this.BITLY_STAT_CODE + " ";
					//url클릭시 링크 변경
					var aLink = "<a"+statCode+RegExp.$1+"href=\""+this.HOST+"/jsp/shortImgView.jsp?url=" + RegExp.$2 + "\" onfocus=\"blur();\"";
				//}
				if(reArray != null) document.getElementById(tmpURL[0]).innerHTML = contents.split(reArray[0]).join(imgTag + aLink);
				if(true == this.RESIZEFLAG) ResizeIFrame();
			}
		}
		
	}
	,click:function(obj) {
		if(obj.getAttribute("width") == this.IMGLW) {	//큰사이즈 일때
			obj.src = obj.src.split(this.THUMB_L).join(this.THUMB_S);
			obj.setAttribute("width", this.IMGSW);
		} else {
			obj.src = obj.src.split(this.THUMB_S).join(this.THUMB_L);
			obj.setAttribute("width", this.IMGLW);
		}
		if(true == this.RESIZEFLAG) ResizeIFrame();
	}
};
