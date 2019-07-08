SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




/* =====================================================================
	프로그램ID : SXWTTodayMainQ
	업  무  명 : 수요예측
	프로그램명 : Today Main - 표출
	최초작성일 : 2002/11/11
	최종작성일 : 2002/11/11
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */


CREATE   PROCEDURE dbo.SXWTTodayMainQ
@vcLastdate datetime
,@vcLastweekdate datetime
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTTodayMainQ:'	-- 오류 내용 초기화

	SELECT indivadult+indivschool+indivchild+isnull(orgadult+orgschool+orgchild,0) as total, --예측값
	indivadult+indivschool+indivchild as indivtotal,
	indivadult,
	indivschool,
	indivchild,
	orgadult+orgschool+orgchild as orgtotal,
	orgadult,
	orgschool,
	orgchild
	FROM dbo.vxtday

	SELECT indivadult+indivschool+indivchild+isnull(orgadult+orgschool+orgchild,0) as total, --실입장 예측값
	indivadult+indivschool+indivchild as indivtotal,
	indivadult,
	indivschool,
	indivchild,
	orgadult+orgschool+orgchild as orgtotal,
	orgadult,
	orgschool,
	orgchild
	FROM dbo.vxteday

	SELECT xdate,  --전년 동일 실적
	indivtotal+grouptotal as total,
	indivtotal, 
	indivadult, 
	indivschool, 
	indivchild,
	grouptotal, 
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxthistoryday 
	WHERE xdate=@vcLastdate

	SELECT xdate,  --전년 동일 실적 실입장
	indivtotal+grouptotal as total,
	indivtotal, 
	indivadult, 
	indivschool, 
	indivchild,
	grouptotal, 
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxtehistoryday 
	WHERE xdate=@vcLastdate

	SELECT xdate,	--전년 동요일 실적
	indivtotal+grouptotal as total,
	indivtotal, 
	indivadult, 
	indivschool, 
	indivchild,
	grouptotal, 
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxthistoryday 
	WHERE xdate=@vcLastweekdate

	SELECT xdate,	--전년 동요일 실적 실입장
	indivtotal+grouptotal as total,
	indivtotal, 
	indivadult, 
	indivschool, 
	indivchild,
	grouptotal, 
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxtehistoryday 
	WHERE xdate=@vcLastweekdate

	IF @@ERROR <> 0
	BEGIN
		SET @vcError = @vcSpname + '쿼리 실패'
--Error 발생 및 log 기록
		EXEC dbo.SXBWriteLogI 'X.dbo.SP', @vcError
	END		  
END 







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

