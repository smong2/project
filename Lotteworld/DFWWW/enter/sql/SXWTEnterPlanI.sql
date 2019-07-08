SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO





/* =====================================================================
	프로그램ID : SXWTEnterPlanI
	업  무  명 : 수요예측
	프로그램명 : 입장객 계획 - 등록
	최초작성일 : 2002/11/14
	최종작성일 : 2002/11/14
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */

CREATE     PROCEDURE dbo.SXWTEnterPlanI
	@vcEnterType varchar(10)
	,@vcModelType varchar(15)
	,@vcInput_Year varchar(10)
	,@vcInput_Month varchar(10)
	,@vcInput_Day varchar(10)
	,@intSpecial int
	,@intFree int
	,@intEducinst int
	,@intDutyfree int
	,@intCompany int
	,@intMycustomer int
	,@intEtc int
	,@vcClass varchar(5)=' '

AS
	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterPlanI:'	-- 오류 내용 초기화

BEGIN

 IF @vcEnterType='vxt' --매표 입장일 경우
 BEGIN
	IF @vcModelType='model_year' --년 입력을 선택했을 경우 
 	 BEGIN
		DELETE FROM dbo.txtenterplan   --겹치는 자료는 삭제하고
		WHERE 	class=@vcClass and 
			year=@vcInput_Year and 
			month is null and 
			day is null
	
		INSERT INTO dbo.txtenterplan  --자료 추가
		(year,class,special,free,educinst,dutyfree, company, mycustomer,etc) 
		VALUES (@vcInput_Year,@vcClass,@intSpecial,@intFree,@intEducinst,@intDutyfree,@intCompany,@intMycustomer,@intEtc)
	 END
  
	IF @vcModelType='model_month' --월 입력을 선택했을 경우
	 BEGIN
		DELETE FROM dbo.txtenterplan   --겹치는 자료는 삭제하고 
		WHERE 	class=@vcClass and 
			year=@vcInput_Year and 
			Month=@vcInput_Month and 
			day is null
		
		INSERT INTO dbo.txtenterplan  --자료 추가 
		(year,month,class,special,free,educinst,dutyfree, company, mycustomer,etc) 
		VALUES (@vcInput_Year,@vcInput_Month,@vcClass,@intSpecial,@intFree,@intEducinst,@intDutyfree,@intCompany,@intMycustomer,@intEtc)
	 END
 
	IF @vcModelType='model_day'  --일 입력을 선택했을 경우
	 BEGIN
		DELETE FROM dbo.txtenterplan   --겹치는 자료는 삭제하고 
		WHERE 	class=@vcClass and 
			year=@vcInput_Year and 
			Month=@vcInput_Month and 
			day=@vcInput_Day

		INSERT INTO dbo.txtenterplan  --자료 추가 
		(year,month,day,class,special,free,educinst,dutyfree, company, mycustomer,etc) 
		VALUES (@vcInput_Year,@vcInput_Month,@vcInput_Day,@vcClass,@intSpecial,@intFree,@intEducinst,@intDutyfree,@intCompany,@intMycustomer,@intEtc)
	 END

 END

IF  @vcEnterType='vxte'  --실입장일 경우
BEGIN
	IF @vcModelType='model_year'
 	 BEGIN
		  DELETE FROM dbo.txteenterplan    --동일 값이 있으면 지우고
		  WHERE year=@vcInput_Year AND
			month is null AND
			day is null
  
		  INSERT INTO dbo.txteenterplan      --이 값으로 대신한다
		  (year,special,free,educinst,dutyfree, company, mycustomer,etc) 
		  VALUES (@vcInput_Year,@intSpecial,@intFree,@intEducinst,@intDutyfree,@intCompany,@intMycustomer,@intEtc)
	  END
  
	 IF @vcModelType='model_month'
	  BEGIN
		  DELETE FROM dbo.txteenterplan   --동일 값이 있으면 지우고
		  WHERE year=@vcInput_Year and 
			Month=@vcInput_Month and 
			day is null
  
  		  INSERT INTO dbo.txteenterplan     --이 값으로 대신한다
		  (year,month,special,free,educinst,dutyfree, company, mycustomer,etc) 
		  VALUES (@vcInput_Year,@vcInput_Month,@intSpecial,@intFree,@intEducinst,@intDutyfree,@intCompany,@intMycustomer,@intEtc)
	  END  
 
 	IF @vcModelType='model_day'
	  BEGIN
		  DELETE FROM dbo.txteenterplan   --동일 값이 있으면 지우고
		  WHERE year=@vcInput_Year and 
		  month=@vcInput_Month and 
		  day=@vcInput_Day
  
		  INSERT INTO dbo.txteenterplan    --이 값으로 대신한다
		  (year,month,day,special,free,educinst,dutyfree, company, mycustomer,etc) 
		  VALUES (@vcInput_Year,@vcInput_Month,@vcInput_Day,@intSpecial,@intFree,@intEducinst,@intDutyfree,@intCompany,@intMycustomer,@intEtc)
	  END
END

	IF @@ERROR <> 0
	BEGIN
		SET @vcError = @vcSpname + '쿼리 실패' + '모델형식' + @vcModelType
	--Error 발생 및 log 기록
		EXEC dbo.SXBWriteLogI 'X.dbo.SP', @vcError
	END		  
END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

