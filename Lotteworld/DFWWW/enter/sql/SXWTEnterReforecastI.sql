SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




/* =====================================================================
	프로그램ID : SXWTEnterReforecastI
	업  무  명 : 수요예측
	프로그램명 : 입장객 재예측- 등록
	최초작성일 : 2002/11/14
	최종작성일 : 2002/11/14
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */

CREATE    PROCEDURE dbo.SXWTEnterReforecastI
	@vcModelType varchar(12)
	,@vcModelType2 varchar(5)
	,@dtStartdate datetime
	,@dtEnddate datetime


AS

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	DECLARE @vcWeekName VARCHAR(5)

	SET @vcSpname = 'SP Name : SXWTEnterReforecastI:'	-- 오류 내용 초기화

BEGIN

	IF @vcModelType='Y'  --연 재예측
	 BEGIN
		WHILE @dtStartdate<=@dtEnddate 
      		BEGIN
	 	 	INSERT INTO dbo.txbreforecast 
			(year,y1,y2,y3,y4,y5,insertdate) 
		 	VALUES (year(@dtStartdate),'T','Y',LEFT(@vcModelType2,2),RIGHT(@vcModelType2,1),'-',getdate())

		IF @dtStartdate>@dtEnddate
		BREAK
	 
		 	SET @dtStartdate=dateadd("yyyy",1,@dtStartdate) --날짜 1년 증가시키고..
		END
	 END

	IF @vcModelType='M'  --월 재예측
	 BEGIN		 
		WHILE  @dtStartdate<=@dtEnddate
		 BEGIN
		 	INSERT INTO dbo.txbreforecast 
		 	(year,month,y1,y2,y3,y4,y5,insertdate) 
		 	VALUES (year(@dtStartdate),month(@dtStartdate),'T','M',LEFT(@vcModelType2,2),RIGHT(@vcModelType2,1),'-',getdate()) --넣을 건 넣자

		 IF @dtStartdate>@dtEnddate
     		 BREAK
 		
		 	SET @dtStartdate=dateadd("m",1,@dtStartdate) --날짜 1개월 증가시키고..

		 END
	END

	IF @vcModelType='D' --일 재예측
	 BEGIN
		WHILE @dtStartdate<=@dtEnddate 
		 BEGIN
			
			SELECT @vcWeekName=WEEKDAY   --요일을 구하자
			FROM dbo.txbdate
			WHERE 	year=year(@dtStartdate) and
				month=month(@dtStartdate) and
				day=day(@dtStartdate)

		 	INSERT INTO dbo.txbreforecast 
		 	(year,month,day,y1,y2,y3,y4,y5,insertdate) 
		 	VALUES (year(@dtStartdate),month(@dtStartdate),day(@dtStartdate),'T','D',LEFT(@vcModelType2,2),month(@dtStartdate),@vcWeekName,getdate()) --넣을 건 넣자
		
		 IF @dtStartdate>@dtEnddate
     		 BREAK

		 	SET @dtStartdate=dateadd("d",1,@dtStartdate) --날짜 1일 증가시키고..
		 END
	 END

	IF @@ERROR <> 0
	BEGIN
		SET @vcError = @vcSpname + '쿼리 실패' + '모델명 : ' + @vcModelType 
	--Error 발생 및 log 기록
		EXEC dbo.SXBWriteLogI 'X.dbo.SP', @vcError
	END		  
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

