/**
* 토스트 사용 여부 설정
*/
function updateToast(toastYN)/*{{{*/
{
	try {
		var options = {
			method: 'post',
			onComplete: function (transport, json)
			{
				if (json.result == false) {
					alert('잠시 후에 다시 시도해주세요.');
					return;
				}

				if (json.toastYN == 'y') {
					document.getElementById('toastDesc').innerHTML = '수신중';

				} else if (json.toastYN == 'n') {
					document.getElementById('toastDesc').innerHTML = '수신 거부 중';

				}
			},
			parameters: {toastYN: toastYN}
		};
		new Ajax.Request('/mine/updateToast', options);
	}
	catch (e) {
	}
}/*}}}*/

/**
 * 닉네임 사용여부 설정
 */
function updateShowNickname(show_nickname_fl)/*{{{*/
{
	try {
		show_nickname_fl = show_nickname_fl.checked ? 'y':'n';

		var options = {
			method: 'post',
			onComplete: function (transport, json)
			{
				if (json.result == false) {
					alert('잠시 후에 다시 시도해주세요.');
					return;
				}
			},
			parameters: {show_nickname : show_nickname_fl}
		};
		new Ajax.Request('/mine/updateShowNickname', options);
	}
	catch (e) {
	}

}/*}}}*/
