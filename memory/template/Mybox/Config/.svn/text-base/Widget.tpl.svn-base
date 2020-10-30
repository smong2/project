<tpl:Common_Html>
	<tpl:Admin_Head>
		<script>
			function fnSizeWidth() {
				if($('size_width').value<200) {
					alert('가로 길이는 200 이상이어야 합니다');
					$('size_width').value=200;
					$('size_width').focus();
				}
			}

			function fnpreview(addcnt) {
				if(!$("size_width").value) {
					alert('가로 길이에 숫자를 넣어주세요');
					$("size_width").focus();
					return false;
				}

				var preview = document.getElementById("tblPreview");
				preview.width=$("size_width").value;
				var tbody = preview.getElementsByTagName("tbody")[0];
				var tbodylength = tbody.childNodes.length;

				for(i=0;i<tbodylength;i++) {
					tbody.removeChild(tbody.lastChild);
				}

				for(i=0;i<addcnt;i++) {
					var trE = document.createElement("tr");
					var tdE = document.createElement("td");
					tdE.innerHTML = "<img src='http://image.nate.com/img/v2/logo_nate3.gif' width="+$("size_width").value+">";

					tdE.appendChild(tdE);
					trE.appendChild(tdE);
					tbody.appendChild(trE);
				}
			}

			function fncopy(copyobj) {
					var doc = $(copyobj).createTextRange();
					doc.execCommand('copy');
			}

			function checksize(size_width,size_height) {
				var size_width = $("size_width").value;
				var size_height = $("size_height").value;

				if(!size_width || !size_height) {
					alert("가로,세로에 들어갈 숫자를 정확하게 입력해주십시오");
					return false;
				}

				var ajax = new Ajax.Request(
					"widgetCreate?size_width="+size_width+"&size_height="+size_height,
					{
						method: "post",
						onSuccess: WidgetCallback
					}
				);
			}

			function WidgetCallback(transport, json)
			{
				if(json && json[1]) {
					$('copy_widget').style.display='block';
					$("widget_cd").value = json[1];
				} else {
					alert('처리되지 않았습니다.');
				}
			}
		</script>
	</tpl:Admin_Head>
		<tpl:Common_Body>
		<table class="contents" cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr><td class="headline">
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tr>
							<td class="title">마이기억함 -> 기억 외부공유</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<a href="Blogsync">기억배달</a> | <a href="Widget">위젯가져가기</a>
				</td>
			</tr>
			<tr height="30">
				<td></td>
			</tr>
			<tr>
				<td>
				<table width="80%">
					<tr>
						<td rowspan="2">▶ 위젯 설치 도움말</td>
						<td colspan="2">기억 위젯을 다른 블로그로 가져가기 설정 하면
						    다른 친구들도 내 기억을 공유할 수 있습니다.
						</td>
					</tr>
					<tr>
						<td>위젯 미리 보기
							<table id="tblPreview" border="1" cellpadding="0" cellspacing="0">
								<tbody>
								</tbody>
							</table>
							</td>
						<td valign="top">* 크기<br/>
						    가로 <input type="text" id="size_width" name="size_width" size="5" onblur=fnSizeWidth(); />
						    * 글이 깨져 보일 수 있으므로 200 이하로 설정할 수 없습니다.
						    <br/>
						    세로 <select id="size_height" name="size_height" onchange=fnpreview(this.value)>
						    			<option value="0">-선택-</option>
						    			<option value="3">3개</option>
						    			<option value="5">5개</option>
						    			<option value="8">8개</option>
						    			<option value="10">10개</option>
						    			<option value="15">15개</option>
						    			<option value="20">20개</option>
						    		</select> 한 화면에 노출되는 글 수

						    		<br>
						    		<div align="right"><input type="submit" value="위젯 가져가기" onclick="checksize()"/></div>

						    <br/>
						    	<div id="copy_widget" style="display:none">
						    		코드가 복사되었습니다. <br/>
						    		복사 된 코드를 블로그에 CTRL+V하여 붙여 넣으시면 기억나 위젯을 사용할 수 있습니다.
						    		<br/>
						    			<table>
						    				<tr>
						    					<td colspan="2"><textarea id="widget_cd" name="widget_cd" cols="40" rows="4" readOnly></textarea>
						    					</td>
						    				</tr>po m
						    				<tr>
						    					<td align="left">
						    						<input type="button" value="<<뒤로" onclick="document.location.reload()"/>
						    					</td>
						    					<td align="right">
						    						<input type="button" value="코드 복사하기" onclick="fncopy('widget_cd')"/>
						    					</td>
						    				</tr>
						    			</table>
					    		</div>
						</td>
					</tr>
				</table>
			</td></tr>
			</table>
		</tpl:Common_Body>
</tpl:Common_Html>