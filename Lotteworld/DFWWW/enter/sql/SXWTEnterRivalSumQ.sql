SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



/* =====================================================================
	프로그램ID : SXWTEnterRivalSuMQ
	업  무  명 : 수요예측
	프로그램명 : 경쟁사 예측- 표출 (월누계 )
	최초작성일 : 2002/11/11
	최종작성일 : 2002/11/11
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */


CREATE  PROCEDURE dbo.SXWTEnterRivalSumQ
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterRivalSumQ:'	-- 오류 내용 초기화

	SELECT  year, --월별 (에버,서울랜드)
	month,
	evertotal,
	seoultotal
	FROM dbo.txtrivalmonth 
	WHERE year=year(getdate()) 
	ORDER BY month

	SELECT indivtotal+grouptotal as total --월별 (롯데월드)
	FROM dbo.vxtmonth 
	WHERE year=year(getdate())

	SELECT  sum(evertotal) as evertotal, --월별 누계 (에버, 서울랜드)
	sum(seoultotal) as seoultotal 
	FROM dbo.txtrivalmonth 
	WHERE year=year(getdate())

	SELECT sum(indivtotal+grouptotal) as total --월별 누계 (롯데월드)
	FROM dbo.vxtmonth 
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

