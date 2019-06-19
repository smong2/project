<head>
	<script>
		function fetchInfoProc()
		{

		}
	</script>
</head>
<form method="post" action="userInfo">
cmn : <input type="text" name="cmn" value="{$this->cmn}" />

<button type="submit">조회</button>
</form>


<dummy podo:if="$this->cmn">
<br/>
<br/>
기본정보
<table border="1" width="500">
	<tr>
		<th>profile_image</th>
		<th>CMN</th>
		<th>ID</th>
		<th>Domain</th>
		<th>nickname</th>
		<th>profile_title</th>
	</tr>
	<tr>
		<td>{$this->user["profile_image"]}</td>
		<td>{$this->user["cmn"]}</td>
		<td>{$this->user["id"]}</td>
		<td>{$this->user["domain"]}</td>
		<td>{$this->user["nickname"]}</td>
		<td>{$this->user["profile_title"]}</td>
	</tr>
</table>

<br/>
친구, 메시지 정보
<table border="1" width="500">
	<tr>
		<th>follower_cnt</th>
		<th>following_cnt</th>
		<th>friend_cnt</th>
		<th>r_friend_cnt</th>
		<th>msg_cnt</th>
	</tr>
	<tr>
		<td>{$this->user["follower_cnt"]}</td>
		<td>{$this->user["following_cnt"]}</td>
		<td>{$this->user["friend_cnt"]}</td>
		<td>{$this->user["r_friend_cnt"]}</td>
		<td>{$this->user["msg_cnt"]}</td>
	</tr>
</table>
</dummy>
