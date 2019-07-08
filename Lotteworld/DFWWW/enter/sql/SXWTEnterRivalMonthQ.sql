SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




/* =====================================================================
	프로그램ID : SXWTEnterRivalMonthQ
	업  무  명 : 수요예측
	프로그램명 : 경쟁사 예측- 표출 (월 )
	최초작성일 : 2002/11/11
	최종작성일 : 2002/11/11
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */


CREATE     PROCEDURE dbo.SXWTEnterRivalMonthQ
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterRivalMonthQ:'	-- 오류 내용 초기화

	SELECT year, --경쟁사 월 예측
	month,
	evertotal,
	seoultotal
	FROM dbo.txtrivalmonth 
	WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  (year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or (year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate()))) 

	SELECT year, --과거실적
	month,
	sum(everindiv+everorg) as evertotal, 
	sum(seoulindiv+seoulorg) as seoultotal 
	FROM dbo.txtrivalenter 
	WHERE (year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or  (year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or (year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate()))) 
	GROUP BY year,month

	SELECT sum(evertotal) as evertotal,  --경쟁사 월 예측 합계
	sum(seoultotal) as seoultotal 
	FROM dbo.txtrivalmonth 
	WHERE year=year(getdate())

	SELECT sum(everindiv+everorg) as evertotal,  --과거 실젹 합계
	sum(seoulindiv+seoulorg) as seoultotal 
	FROM txtrivalenter 
	WHERE year=year(getdate())-1


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

