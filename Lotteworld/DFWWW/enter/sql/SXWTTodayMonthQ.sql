SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/* =====================================================================
	프로그램ID : SXWTTodayMonthQ
	업  무  명 : 수요예측
	프로그램명 : Today Month - 표출
	최초작성일 : 2002/11/11
	최종작성일 : 2002/11/11
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */


CREATE  PROCEDURE dbo.SXWTTodayMonthQ
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTTodayMonthQ:'	-- 오류 내용 초기화

	SELECT *,  --매표 입장
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child, 
	indivtotal+grouptotal as total 
	FROM dbo.vxtmonth 
	WHERE year=year(getdate()) and month=month(getdate())


	SELECT *,  --실 입장
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child, 
	indivtotal+grouptotal as total 
	FROM dbo.vxtemonth 
	WHERE year=year(getdate()) and month=month(getdate())

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

