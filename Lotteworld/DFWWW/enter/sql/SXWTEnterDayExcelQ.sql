SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



/* =====================================================================
	프로그램ID : SXWTEnterDayExcelQ
	업  무  명 : 수요예측
	프로그램명 : 입장객 일 예측 - 엑셀 표출
	최초작성일 : 2002/11/12
	최종작성일 : 2002/11/12
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */


CREATE   PROCEDURE dbo.SXWTEnterDayExcelQ
@vcModelType varchar(10)
,@vcEnterType varchar(10)
,@vcLastdate datetime
,@vcLastweekdate datetime
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterDayExcelQ:'	-- 오류 내용 초기화


IF @vcModelType='vxt' and @vcEnterType='group' --매표, 단체
BEGIN

	SELECT xdate,  --전년 동일 실적
	grouptotal, 
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastdate-60 and xdate<=@vcLastdate+2
              ORDER BY xdate

	SELECT xdate,  --전년 동요일 실적
	grouptotal, 
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastweekdate-60  and xdate<=@vcLastweekdate+2
              ORDER BY xdate

END
IF @vcModelType='vxt' and @vcEnterType='indiv' --매표, 개인
BEGIN
	SELECT xdate,   --전년 동일 실적
	indivtotal, 
	indivadult, 
	indivschool, 
	indivchild 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastdate-60 and xdate<=@vcLastdate+2
              ORDER BY xdate

	SELECT xdate,  --전년 동요일 실적
	indivtotal, 
	indivadult, 
	indivschool, 
	indivchild 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastweekdate-60 and xdate<=@vcLastweekdate+2
              ORDER BY xdate

END
IF @vcModelType='vxt' and @vcEnterType='total' --매표, 개인
BEGIN
	SELECT xdate,  --전년 동일 실적
	indivtotal+grouptotal as total, 
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastdate-60 and xdate<=@vcLastdate+2
              ORDER BY xdate

	SELECT indivtotal+grouptotal as total,  --전년 동요일 실적
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastweekdate-60  and xdate<=@vcLastweekdate+2
              ORDER BY xdate

END
IF @vcModelType='vxte' and @vcEnterType='group' --매표, 단체
BEGIN

	SELECT xdate,  --전년 동일 실적
	grouptotal, 
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastdate-60 and xdate<=@vcLastdate+2
              ORDER BY xdate

	SELECT  --전년 동요일 실적
	xdate,
	grouptotal, 
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastweekdate-60  and xdate<=@vcLastweekdate+2
              ORDER BY xdate

END
IF @vcModelType='vxte' and @vcEnterType='indiv' --매표, 개인
BEGIN
	SELECT xdate,  --전년 동일 실적
	indivtotal, 
	indivadult, 
	indivschool, 
	indivchild 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastdate-60 and xdate<=@vcLastdate+2
              ORDER BY xdate

	SELECT  xdate,--전년 동요일 실적
	indivtotal, 
	indivadult, 
	indivschool, 
	indivchild 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastweekdate-60  and xdate<=@vcLastweekdate+2
              ORDER BY xdate

END
IF @vcModelType='vxte' and @vcEnterType='total' --매표, 개인
BEGIN
	SELECT xdate,  --전년 동일 실적
	indivtotal+grouptotal as total, 
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastdate-60 and xdate<=@vcLastdate+2
              ORDER BY xdate

	SELECT indivtotal+grouptotal as total,  --전년 동요일 실적
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastweekdate-60  and xdate<=@vcLastweekdate+2
              ORDER BY xdate
END



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

