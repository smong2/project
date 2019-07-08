SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/* =====================================================================
	프로그램ID : SXWTTodayYearQ
	업  무  명 : 수요예측
	프로그램명 : Today Year - 표출
	최초작성일 : 2002/11/11
	최종작성일 : 2002/11/11
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */


CREATE  PROCEDURE dbo.SXWTTodayYearQ
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTTodayYearQ:'	-- 오류 내용 초기화

	SELECT indivadult, --매표 연 예측치
	groupadult, 
	indivschool,
	groupschool, 
	indivchild,
	groupchild, 
	indivtotal, 
	grouptotal, 
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child, 
	indivtotal+grouptotal as total 
	FROM dbo.vxtyear 
	WHERE year=year(getdate())

	SELECT indivadult,  --실입장 연 예측치
	groupadult, 
	indivschool,
	groupschool, 
	indivchild,
 	groupchild, 
	indivtotal, 
	grouptotal, 
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child, 
	indivtotal+grouptotal as total 
	FROM dbo.vxteyear 
	WHERE year=year(getdate())


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

