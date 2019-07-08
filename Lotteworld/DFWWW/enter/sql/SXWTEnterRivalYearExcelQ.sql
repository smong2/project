SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



/* =====================================================================
	프로그램ID : SXWTEnterRivalYearExcelQ
	업  무  명 : 수요예측
	프로그램명 : 경쟁사 예측 년-  엑셀 출력
	최초작성일 : 2002/11/11
	최종작성일 : 2002/11/11
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */

CREATE    PROCEDURE dbo.SXWTEnterRivalYearExcelQ
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterRivalYearExcelQ:'	-- 오류 내용 초기화

	SELECT year,  --예측값
	evertotal,
	seoultotal
	FROM dbo.txtrivalyear

	SELECT year, --전년 과거 실적
	sum(everindiv+everorg) as evertotal, 
	sum(seoulindiv+seoulorg) as seoultotal 
	FROM dbo.txtrivalenter 
	WHERE year=year(getdate()) or
	year=year(getdate())-1 or
	year=year(getdate())-2 or
	year=year(getdate())-3 or
	year=year(getdate())-4
	GROUP BY year 
	ORDER BY year

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

