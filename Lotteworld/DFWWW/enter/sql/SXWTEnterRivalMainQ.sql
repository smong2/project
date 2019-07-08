SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO






/* =====================================================================
	프로그램ID : SXWTEnterRivalMainQ
	업  무  명 : 수요예측
	프로그램명 : 경쟁사 예측- 표출 (메인 )
	최초작성일 : 2002/11/11
	최종작성일 : 2002/11/11
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */


CREATE     PROCEDURE dbo.SXWTEnterRivalMainQ
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterRivalMaInQ:'	-- 오류 내용 초기화

	SELECT year,	--월별 (에버, 서울랜드) 
	month, 
	evertotal, 
	everadult,
	everschool,
	everchild,
	seoultotal,
	seouladult,
	seoulschool,
	seoulchild  
	FROM dbo.txtrivalmonth 
	WHERE year=year(getdate()) and month=month(getdate())

	SELECT indivadult+groupadult as lotteadult, --월별 (롯데월드)
	indivschool+groupschool as lotteschool, 
	indivchild+groupchild as lottechild, 
	indivtotal+grouptotal as lottetotal 
	FROM dbo.vxtmonth 
	WHERE year=year(getdate()) and month=month(getdate())

	SELECT sum(evertotal) as evertotal, --월별 누계 (에버, 서울랜드) 
	sum(seoultotal) as seoultotal 
	FROM dbo.txtrivalmonth 
	WHERE year=year(getdate()) and month<=month(getdate())

	

	SELECT sum(indivtotal+grouptotal) as lottetotal --월별 누계 (롯데월드) 
	FROM dbo.vxtmonth 
	WHERE year=year(getdate()) and month<=month(getdate())

	SELECT evertotal, --년별 (에버, 서울랜드) 
	everadult,
	everschool,
	everchild,
	seoultotal,
	seouladult,
	seoulschool,
	seoulchild 
	FROM dbo.txtrivalyear 
	WHERE year=year(getdate())

	SELECT indivadult+groupadult as lotteadult, --년별 롯데월드 
	indivschool+groupschool as lotteschool, 
	indivchild+groupchild as lottechild, 
	indivtotal+grouptotal as lottetotal 
	FROM dbo.vxtyear 
	WHERE year=year(getdate())

	SELECT sum(evertotal) as evertotal, --년별 누계 (에버, 서울랜드) 
	sum(seoultotal) as seoultotal 
	FROM dbo.txtrivalyear 
	WHERE year>=year(getdate()) and year<=year(getdate())

	SELECT sum(indivtotal+grouptotal) as lottetotal --년별 누계 (롯데월드) 
	FROM dbo.vxtyear 
	WHERE year>=year(getdate()) and year<=year(getdate())


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

