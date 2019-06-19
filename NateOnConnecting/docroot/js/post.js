/**
 * 단축 URL 존재 여부 체크
 */
function containedUrlCheck(obj, mode)/*{{{*/
{
	if (event.keyCode != 32 && event.keyCode != 13 && mode == "") {
		return;
	}

	var content = obj.value;
	var url_pattern = /((http|ftp)(s)?:\/\/)\S+(\.[^(\"\n\t\s))]+)+/gi;
	var shortened_url_pattern = /((http|ftp)(s)?:\/\/)(zul.im|ina.tc|bit.ly|vna.tc)/gi;
	var result = content.match(url_pattern);
	  
	if(result != null) {
		result = result.join('\n');

		var urls = result.split("\n");

		for(key in urls) {
			var cURL = urls[key];

			if(typeof(cURL) == 'string') {
				cURL = cURL.replace("\"","%22");
				cURL = cURL.replace("'","%27");

				check = cURL.match(shortened_url_pattern);

				if (check == null) {
					if (cURL.length <= 10) {
						continue;
					}

					shorten_url(obj, cURL);
				}
			}
		}
	}
}/*}}}*/

/**
 * 단축 URL 변환
 */
function shorten_url(obj, url)/*{{{*/
{
	try {
		var options = {
			method: 'post',
			asynchronous: false,
			onComplete: function (transport, json)
			{
				if (json.result == false) {
					alert('잠시 후에 다시 시도해주세요.');
					return;
				}

				obj.value = obj.value.replace(url, json.result);
			},
			parameters: {url: url}
		};

		new Ajax.Request('/message/shortenUrl', options);
		
	}
	catch (e) {
	}
}/*}}}*/

/**
 * 메시지 등록
 */
function addMessage(message, open_yn, send_twitter)/*{{{*/
{
	try {
		var options = {
			method: 'post',
			asynchronous: false,
			onComplete: function (transport, json)
			{
				if (addProcCheck(json,document.getElementById('memo')) == false) {
					return;
				}
				window.location.href = 'http://nateon.connect.nate.com/';
			},
			parameters: {message: message, open_yn: open_yn, send_twitter: send_twitter}
		};
		new Ajax.Request('/message/add', options);
	}
	catch (e) {
	}
}/*}}}*/
