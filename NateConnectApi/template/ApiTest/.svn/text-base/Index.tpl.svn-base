<html>
<head>
	<meta http-equiv="Content-Type" content="text/html" charset="utf-8"/>
	<style type="text/stylesheet">
		body {font-family : 굴림;
			  font-size : 10px;
		}

		#tabletest {font-size : 10px;}

	</style>
	<script type="text/javascript" language="javascript">
		function submitApi()
		{
			if (document.getElementById("apiName").value == '') {
				return false;
			}
			baseParam = "svc_id=" +document.getElementById("svc_id").value;
			baseParam += "&svc_pwd=" +document.getElementById("svc_pwd").value;
			baseParam += "&cmn=" + document.getElementById("cmn").value;


			param = document.getElementById("param").value;

			document.frm.method= "post";
			document.frm.action = document.getElementById("apiName").value + "?" + baseParam + "&" +  param;
			document.frm.target = "testFrame";
			document.frm.submit();
		}

	</script>
</head>
<body>
	<form name="frm" method="post" target="testFrame">
	<table id="tabletest">
		<tr>
			<td>테스트할 API 선택</td>
			<td colspan="2"><select id="apiName" name="apiName">
					<option value="">----  1. 메시지 API ----</option>
					<option value="/message/list">1) 메시지 조회</option>
					<option value="/message/timeline">2) 메시지 전체공개 목록 조회</option>
					<option value="/message/home">3) Home 메시지 목록 조회</option>
					<option value="/message/add">4) 메시지 등록</option>
					<option value="/message/delete">5) 메시지 삭제</option>
					<option value="/message/view">6) 단일 메시지 조회</option>
					<option value="/message/alarm">7) 메시지 알람</option>
					<option value="/message/reconnect">8) 리커넥팅하기</option>
					<option value="">----  2. 사용자 조회 API ----</option>
					<option value="/user/show">9) 사용자 정보 조회</option>
					<option value="/user/exist">10) 도메인, 닉네임 존재여부 체크</option>
					<option value="/user/update">11) 사용자 정보 수정</option>
					<option value="/user/updateToast">12) 토스트 사용여부 수정</option>
					<option value="/user/getMessageDefault">13) 메시지 보내기 기본값 가져오기</option>
					<option value="/user/status">14) 상태 정보 조회</option>
					<option value="/user/linkedBlogs">15) 블로그 연동 리스트 조회</option>
					<option value="/user/balloonView">16) 말풍선 보기</option>
					<option value="/user/balloonCheck">17) 말풍선 확인</option>
					<option value="/user/profileImgs">18) 프로필 이미지 조회</option>
					<option value="">----  3. 댓글 API ----</option>
					<option value="/comment/list">19) 댓글 리스트 조회</option>
					<option value="/comment/add">20) 댓글 등록</option>
					<option value="/comment/delete">21) 댓글 삭제</option>
					<option value="/comment/alarm">22) 댓글 알람</option>
					<option value="">----  4. 트위터 API ----</option>
					<option value="/twitter/link">23) 연동하기</option>
					<option value="/twitter/unlink">24) 연동끊기</option>
					<option value="/twitter/homeTimeline">25) 홈타임라인 가져오기</option>
					<option value="/twitter/userTimeline">26) 유저타임라인 가져오기</option>
					<option value="">----  5. Follow API ----</option>
					<option value="/follow/followerList">27) follower 리스트 가져오기</option>
					<option value="/follow/followingList">28) following 리스트 가져오기</option>
					<option value="/follow/add">29) following 맺기</option>
					<option value="/follow/delete">30) following 끊기</option>
					<option value="/follow/isFollowing">31) 내 Following 여부 확인</option>
					<option value="">----  6. Buddy API ----</option>
					<option value="/buddy/fList">32) 내가 추가한 친구 리스트 가져오기</option>
					<option value="/buddy/reverseFList">33) 나를 추가한 친구 리스트 가져오기</option>
					<option value="/buddy/add">34) 친구 추가</option>
					<option value="/buddy/delete">35) 친구 삭제</option>
					<option value="/buddy/updateRecieve">36) 수신여부 설정하기</option>
					<option value="/buddy/isFriend">37) 내 친구 여부 확인</option>
					<option value="">----  7. Buddy API ----</option>
					<option value="/util/shorten">38) 단축 URL 생성</option>
				</select>
			</td>
		</tr>
		<tr>
			<td rowspan="2">Param</td>
			<td> 기본 파라미터 : 
				svc_id :<input type="text" size="10" id="svc_id" value="test" style="border=0;background=#d5d5ff"/>
				&svc_pwd:<input type="text" size="10" id="svc_pwd" value="testpwd" style="border=0;background=#d5d5ff"/>
				&cmn:<input type="text" size="9" id="cmn" value="00002414321" style="border=0;background=#d5d5ff"/>
			</td>

			<td rowspan="2">
				
				<button type="button" onclick="submitApi()">테스트</button>

			</td>
		</tr>
		<tr>
			<td>
				 기타 파라미터 : 
			<input type="text" size="110" name="param" id="param"/></td>
		</tr>
	</table>
	</form>

	<iframe id="testFrame" name="testFrame" frameborder="0" width="100%" height="85%"/>


</body>
</html>
