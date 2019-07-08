SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/* =====================================================================
	프로그램ID : SXWTEnterRivalMonthExcelQ
	업  무  명 : 수요예측
	프로그램명 : 경쟁사 예측 월-  엑셀 출력
	최초작성일 : 2002/11/11
	최종작성일 : 2002/11/11
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */


CREATE  PROCEDURE dbo.SXWTEnterRivalMonthExcelQ
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterRivalMonthExcelQ:'	-- 오류 내용 초기화

	SELECT year, --경쟁사 월 예측
	month,
	evertotal,
	seoultotal
	FROM  dbo.txtrivalmonth 
	WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  
	(year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or 
	(year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate()))) or 
	(year=year(dateadd(mm,  -1, getdate())) and month=month(dateadd(mm,  -1, getdate()))) or 
	(year=year(dateadd(mm,  -2, getdate())) and month=month(dateadd(mm,  -2, getdate()))) or 
	(year=year(dateadd(mm,  -3, getdate())) and month=month(dateadd(mm,  -3, getdate()))) or 
	(year=year(dateadd(mm,  -4, getdate())) and month=month(dateadd(mm, -4, getdate()))) or 
	(year=year(dateadd(mm,  -5, getdate())) and month=month(dateadd(mm,  -5, getdate()))) or 
	(year=year(dateadd(mm,  -6, getdate())) and month=month(dateadd(mm,  -6, getdate()))) or 
	(year=year(dateadd(mm,  -7, getdate())) and month=month(dateadd(mm,  -7, getdate()))) or 
	(year=year(dateadd(mm,  -8, getdate())) and month=month(dateadd(mm,  -8, getdate()))) or 
	(year=year(dateadd(mm,  -9, getdate())) and month=month(dateadd(mm,  -9, getdate()))) or
	(year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT year, --과거실적
	month,
	sum(everindiv+everorg) as evertotal, 
	sum(seoulindiv+seoulorg) as seoultotal 
	FROM dbo.txtrivalenter 
	WHERE (year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or  
	(year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or 
	(year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate()))) or 
	(year=year(dateadd(mm,  -13, getdate())) and month=month(dateadd(mm,  -13, getdate()))) or 
	(year=year(dateadd(mm,  -14, getdate())) and month=month(dateadd(mm,  -14, getdate()))) or 
	(year=year(dateadd(mm,  -15, getdate())) and month=month(dateadd(mm,  -15, getdate()))) or 
	(year=year(dateadd(mm,  -16, getdate())) and month=month(dateadd(mm,  -16, getdate()))) or 
	(year=year(dateadd(mm,  -17, getdate())) and month=month(dateadd(mm,  -17, getdate()))) or 
	(year=year(dateadd(mm,  -18, getdate())) and month=month(dateadd(mm,  -18, getdate()))) or 
	(year=year(dateadd(mm,  -19, getdate())) and month=month(dateadd(mm,  -19, getdate()))) or 
	(year=year(dateadd(mm,  -20, getdate())) and month=month(dateadd(mm,  -20, getdate()))) or 
	(year=year(dateadd(mm,  -21, getdate())) and month=month(dateadd(mm,  -21, getdate()))) or
	(year=year(dateadd(mm,  -22, getdate())) and month=month(dateadd(mm,  -22, getdate()))) 
	GROUP BY year,month

	IF @@ERROR <> 0
	BEGIN
		SET @vcError = @vcSpname + '쿼리 실패'
	END		  

--Error 발생 및 log 기록
		EXEC dbo.SXBWriteLogI 'X.dbo.SP', @vcError

END 


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

