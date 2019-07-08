SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/* =====================================================================
	프로그램ID : SXWTEnterYearQ
	업  무  명 : 수요예측
	프로그램명 : 입장객 예측- 표출 (연예측 )
	최초작성일 : 2002/11/11
	최종작성일 : 2002/11/11
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */
CREATE  PROCEDURE dbo.SXWTEnterYearQ
    @vcModelType varchar(10)  	 --매표 입장 / 실입장 구분
    ,@vcEnterType varchar(10)	 --개인,단체,전체 구분
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterYearQ:'	-- 오류 내용 초기화

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
	WHERE year=year(getdate())-1
END

IF @vcModelType='vxt' and  @vcEnterType='indiv'  --매표, 개인
 BEGIN
	SELECT year,	--예측치 가져오기 2년
	indivadult,     
	indivschool, 
	indivchild, 
	indivtotal 
	FROM dbo.vxtyear 
	WHERE year<=year(getdate())+1  and year >=year(getdate()) 
	ORDER BY year

	SELECT year,	--과거치 가져오기  1년
	indivadult,  	
	indivschool, 
	indivchild, 
	indivtotal 
	FROM dbo.vxthistoryyear 
	WHERE year=year(getdate())-1
 END

IF @vcModelType='vxt' and @vcEnterType='total'  --매표, 전체
 BEGIN 
	SELECT 	year,	  --예측치 가져오기 2년
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child, 
	(indivtotal+grouptotal) as total 
	FROM dbo.vxtyear 
	WHERE year<=year(getdate())+1  and year >=year(getdate()) 
	ORDER BY year

	SELECT year, 		--과거치 가져오기  1년
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child, 
	(indivtotal+grouptotal) as total 
	FROM dbo.vxthistoryyear 
	WHERE year=year(getdate())-1
 END

 IF @vcModelType='vxte' and @vcEnterType='group'  --실, 단체
 BEGIN

	SELECT year,   		 --예측치 가져오기 2년
	groupadult, 
	groupschool, 
	groupchild, 
	grouptotal 
	FROM dbo.vxteyear 
	WHERE year<=year(getdate())+1  and year >=year(getdate()) 
	ORDER BY year

	SELECT year,		--과거치 가져오기  1년
	groupadult, 
	groupschool, 
	groupchild, 
	grouptotal 
	FROM dbo.vxtehistoryyear 
	WHERE year=year(getdate())-1
 END

 IF @vcModelType='vxte' and @vcEnterType='indiv'   --실,개인
 BEGIN
	SELECT year,    	--예측치 가져오기 2년
	indivadult, 
	indivschool, 
	indivchild, 
	indivtotal 
	FROM dbo.vxteyear 
	WHERE year<=year(getdate())+1  and year >=year(getdate()) ORDER BY year

	SELECT  year, 		--과거치 가져오기  1년
	indivadult, 
	indivschool, 
	indivchild, 
	indivtotal 
	FROM dbo.vxtehistoryyear 
	WHERE year=year(getdate())-1
 END

 IF @vcModelType='vxte' and  @vcEnterType='total'   --실,전체
 BEGIN 
	SELECT  year,  		--예측치 가져오기 2년
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child, 
	(indivtotal+grouptotal) as total 
	FROM dbo.vxteyear 
	WHERE year<=year(getdate())+1  and year >=year(getdate()) ORDER BY year

	SELECT  year,		--과거치 가져오기  1년
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child, 
	(indivtotal+grouptotal) as total 
	FROM dbo.vxtehistoryyear 
	WHERE year=year(getdate())-1
 END


	IF @@ERROR <> 0
	BEGIN
		SET @vcError = @vcSpname + '쿼리 실패' + '모델명 : ' + @vcModelType + '구분명:' + @vcEnterType
--Error 발생 및 log 기록
		EXEC dbo.SXBWriteLogI 'X.dbo.SP', @vcError
	END		  
END 


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

