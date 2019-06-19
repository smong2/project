<tpl:Common_Html>
<tpl:Common_Head>
<body>
<h1>커넥팅 네이트온 탭</h1>
<div class="wrap">
<!-- 커넥팅 -->
	<div class="wrap_sorry">
		<h2 class="tit_sorry">정기 점검 중입니다.</h2>
			<p class="txt_sorry">
		       	커넥팅 서비스는 보다 안정된 서비스를 회원 여러분께<br/>
				제공하기 위해 정기 점검 중에 있습니다.<br/><br/>
				정기 점검 시간 동안 서비스 이용에 불편을 드리게 된 점<br/>
				양해해주시기 바라며 약속한 시간 내에 조속히 점검을<br/>
				마칠 수 있도록 최선을 다 하겠습니다. <br/>
				고맙습니다.					
			</p>

		<div class="info_sorry">
			<p>
				<dummy podo:if="$this->startTime && $this->endTime">	
					<strong>점검 시간: {date("m.d H:i",$this->startTime)} – {date("m.d H:i",$this->endTime)} </strong><br/><br/>
				</dummy>

				문의사항은 네이트/싸이월드 고객센터 메일<br/>
				<a href="mailto:cycop1@nate.com">cycop1@nate.com</a>으로 문의해 주시기 바랍니다.
			</p>
		</div>
		<!-- /커넥팅 -->
	</div>
</div>
</body>
</tpl:Common_Head>
</tpl:Common_Html>
