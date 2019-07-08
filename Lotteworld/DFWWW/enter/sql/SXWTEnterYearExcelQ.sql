SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



/* =====================================================================
	프로그램ID : SXWTEnterYearExcelQ
	업  무  명 : 수요예측
	프로그램명 : 입장객 년 예측 - 엑셀 표출
	최초작성일 : 2002/11/11
	최종작성일 : 2002/11/11
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */


CREATE   PROCEDURE dbo.SXWTEnterYearExcelQ
@vcModelType varchar(10)
,@vcEnterType varchar(10)
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterYearExcelQ:'	-- 오류 내용 초기화


IF @vcModelType='vxt' and @vcEnterType='group' --매표, 단체
BEGIN
	SELECT  year,  	--예측치 가져오기 2년
	groupadult,    
	groupschool, 
	groupchild, 
	grouptotal 
	FROM  dbo.vxtyear 
	WHERE year<=year(getdate())+1  and year >=year(getdate()) 
	ORDER BY year

	SELECT  year,	--과거치 가져오기  1년
	groupadult,   	
	groupschool, 
	groupchild, 
	grouptotal 
	FROM  dbo.vxthistoryyear 
	WHERE year=year(getdate())-1 or
	year=year(getdate())-2 or 
	year=year(getdate())-3 or 
	year=year(getdate())-4
END
IF @vcModelType='vxt' and @vcEnterType='indiv' --매표, 개인
BEGIN
	SELECT  year,  	--예측치 가져오기 2년
	indivadult,    
	indivschool, 
	indivchild, 
	indivtotal 
	FROM  dbo.vxtyear 
	WHERE year<=year(getdate())+1  and year >=year(getdate()) 
	ORDER BY year

	SELECT  year,	--과거치 가져오기  1년
	indivadult,   	
	indivschool, 
	indivchild, 
	indivtotal 
	FROM  dbo.vxthistoryyear 
	WHERE year=year(getdate())-1 or
	year=year(getdate())-2 or 
	year=year(getdate())-3 or 
	year=year(getdate())-4
END
IF @vcModelType='vxt' and @vcEnterType='total' --매표, 개인
BEGIN
	SELECT  year,  	--예측치 가져오기 2년
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child, 
	indivtotal+grouptotal as total 	
	FROM  dbo.vxtyear 
	WHERE year<=year(getdate())+1  and year >=year(getdate()) 
	ORDER BY year

	SELECT  year,	--과거치 가져오기  4년
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child, 
	indivtotal+grouptotal as total,
	grouptotal
	FROM  dbo.vxthistoryyear 
	WHERE year=year(getdate())-1 or
	year=year(getdate())-2 or 
	year=year(getdate())-3 or 
	year=year(getdate())-4
END
IF @vcModelType='vxte' and @vcEnterType='group' --매표, 단체
BEGIN
	SELECT  year,  	--예측치 가져오기 2년
	groupadult,    
	groupschool, 
	groupchild, 
	grouptotal 
	FROM  dbo.vxteyear 
	WHERE year<=year(getdate())+1  and year >=year(getdate()) 
	ORDER BY year

	SELECT  year,	--과거치 가져오기  1년
	groupadult,   	
	groupschool, 
	groupchild, 
	grouptotal 
	FROM  dbo.vxtehistoryyear 
	WHERE year=year(getdate())-1 or
	year=year(getdate())-2 or 
	year=year(getdate())-3 or 
	year=year(getdate())-4
END
IF @vcModelType='vxte' and @vcEnterType='indiv' --매표, 개인
BEGIN
	SELECT  year,  	--예측치 가져오기 2년
	indivadult,    
	indivschool, 
	indivchild, 
	indivtotal 
	FROM  dbo.vxteyear 
	WHERE year<=year(getdate())+1  and year >=year(getdate()) 
	ORDER BY year

	SELECT  year,	--과거치 가져오기  1년
	indivadult,   	
	indivschool, 
	indivchild, 
	indivtotal 
	FROM  dbo.vxtehistoryyear 
	WHERE year=year(getdate())-1 or
	year=year(getdate())-2 or 
	year=year(getdate())-3 or 
	year=year(getdate())-4
END
IF @vcModelType='vxte' and @vcEnterType='total' --매표, 개인
BEGIN
	SELECT  year,  	--예측치 가져오기 2년
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child, 
	indivtotal+grouptotal as total 	
	FROM  dbo.vxteyear 
	WHERE year<=year(getdate())+1  and year >=year(getdate()) 
	ORDER BY year

	SELECT  year,	--과거치 가져오기  1년
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child, 
	indivtotal+grouptotal as total 	
	FROM  dbo.vxtehistoryyear 
	WHERE year=year(getdate())-1 or
	year=year(getdate())-2 or 
	year=year(getdate())-3 or 
	year=year(getdate())-4
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

