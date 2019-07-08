SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/*====================================================================================
	프로그램ID : SXWBWeatherViewQ
	업  무  명 : 수요예측
	프로그램명 : 날씨 표출 -  모두
	최초작성일 : 2002/11/28
	최종작성일 : 2002/11/28
	개  발  자 : 박순몽
	입  력  값 :
	출  력  값 :
	참고  사항 :
====================================================================================*/
CREATE   PROCEDURE dbo.SXWBWeatherViewQ
	@vcAreaCode VARCHAR(10)='서울경기'
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWBWeatherViewQ:'	-- 오류 내용 초기화

	SELECT *   --날씨개황 가져오기    1
	FROM dbo.txbweatheroverview
	WHERE left(ForecastDate,4)=year(getdate()) and substring(ForecastDate,5,2)=month(getdate()) and right(ForecastDate,2)=day(getdate()-3)

	SELECT *  --육상예보 가져오기     2
	FROM dbo.txbweatherland
	WHERE left(ForecastDate,4)=year(getdate()) and substring(ForecastDate,5,2)=month(getdate()) and right(ForecastDate,2)=day(getdate()-3)

	SELECT *  --해상예보 가져오기     3
	FROM dbo.txbweatherSea
	WHERE left(ForecastDate,4)=year(getdate()) and substring(ForecastDate,5,2)=month(getdate()) and right(ForecastDate,2)=day(getdate()-3)

	SELECT *  --주간예보 가져오기     4
	FROM dbo.txbweatherweek
	WHERE left(ForecastDate,4)=year(getdate()) and substring(ForecastDate,5,2)=month(getdate()) and right(ForecastDate,2)=day(getdate()-4)

	SELECT areaname  --날씨지수 목록가져오기     5
	FROM dbo.txbweatherlifeindex

	SELECT sdate,areaname,  --날씨 지수 가져오기    6
	left(picnicindex,3) as picnicjisu,
	substring(picnicindex,6,len(picnicindex)) as picnicindex,
	left(clothwashindex,3) as clothwashjisu,
	substring(clothwashindex,6,len(clothwashindex)) as clothwashindex,
	left(carwashindex,3) as carwashjisu,
	substring(carwashindex,6,len(carwashindex)) as carwashindex,
	left(hotindex,3) as hotcooljisu,
	substring(hotindex,6,len(hotindex)) as hotcoolindex,
	left(fireindex,3) as firejisu,
	substring(fireindex,6,len(fireindex)) as fireindex,
	left(playindex,3) as playjisu,
	substring(playindex,6,len(playindex)) as playindex,
	left(discomfortindex,3) as discomfortjisu,
	substring(discomfortindex,6,len(discomfortindex)) as discomfortindex,
	left(coolindex,3) as cooljisu,
	substring(coolindex,6,len(coolindex))
	FROM dbo.txbweatherlifeindex
	WHERE areaname=@vcAreaCode and left(sDate,4)=year(getdate()) and substring(sDate,5,2)=month(getdate()) and right(sDate,2)=day(getdate()-3)

	SELECT *    --포인트 예보 서울 가져오기   7
	FROM dbo.txbweatherseoul
	WHERE left(sDate,4)=year(dateadd(dd,-3,getdate())) and substring(sDate,5,2)=month(dateadd(dd,-3,getdate())) and right(sDate,2)=day(dateadd(dd,-3,getdate())) or
		left(sDate,4)=year(dateadd(dd,-2,getdate())) and substring(sDate,5,2)=month(dateadd(dd,-2,getdate())) and right(sDate,2)=day(dateadd(dd,-2,getdate())) or	
		left(sDate,4)=year(dateadd(dd,-1,getdate())) and substring(sDate,5,2)=month(dateadd(dd,-1,getdate())) and right(sDate,2)=day(dateadd(dd,-1,getdate())) or
		left(sDate,4)=year(dateadd(dd,0,getdate())) and substring(sDate,5,2)=month(dateadd(dd,0,getdate())) and right(sDate,2)=day(dateadd(dd,0,getdate())) or
		left(sDate,4)=year(dateadd(dd,1,getdate())) and substring(sDate,5,2)=month(dateadd(dd,1,getdate())) and right(sDate,2)=day(dateadd(dd,1,getdate())) or
		left(sDate,4)=year(dateadd(dd,2,getdate())) and substring(sDate,5,2)=month(dateadd(dd,2,getdate())) and right(sDate,2)=day(dateadd(dd,2,getdate())) or
		left(sDate,4)=year(dateadd(dd,3,getdate())) and substring(sDate,5,2)=month(dateadd(dd,3,getdate())) and right(sDate,2)=day(dateadd(dd,3,getdate())) or
		left(sDate,4)=year(dateadd(dd,4,getdate())) and substring(sDate,5,2)=month(dateadd(dd,4,getdate())) and right(sDate,2)=day(dateadd(dd,4,getdate())) 

	SELECT *    --포인트 예보 송파 가져오기 8
	FROM dbo.txbweathersongpa
	WHERE left(sDate,4)=year(dateadd(dd,-3,getdate())) and substring(sDate,5,2)=month(dateadd(dd,-3,getdate())) and right(sDate,2)=day(dateadd(dd,-3,getdate())) or
		left(sDate,4)=year(dateadd(dd,-2,getdate())) and substring(sDate,5,2)=month(dateadd(dd,-2,getdate())) and right(sDate,2)=day(dateadd(dd,-2,getdate())) or	
		left(sDate,4)=year(dateadd(dd,-1,getdate())) and substring(sDate,5,2)=month(dateadd(dd,-1,getdate())) and right(sDate,2)=day(dateadd(dd,-1,getdate())) or
		left(sDate,4)=year(dateadd(dd,0,getdate())) and substring(sDate,5,2)=month(dateadd(dd,0,getdate())) and right(sDate,2)=day(dateadd(dd,0,getdate())) or
		left(sDate,4)=year(dateadd(dd,1,getdate())) and substring(sDate,5,2)=month(dateadd(dd,1,getdate())) and right(sDate,2)=day(dateadd(dd,1,getdate())) or
		left(sDate,4)=year(dateadd(dd,2,getdate())) and substring(sDate,5,2)=month(dateadd(dd,2,getdate())) and right(sDate,2)=day(dateadd(dd,2,getdate())) or
		left(sDate,4)=year(dateadd(dd,3,getdate())) and substring(sDate,5,2)=month(dateadd(dd,3,getdate())) and right(sDate,2)=day(dateadd(dd,3,getdate())) or
		left(sDate,4)=year(dateadd(dd,4,getdate())) and substring(sDate,5,2)=month(dateadd(dd,4,getdate())) and right(sDate,2)=day(dateadd(dd,4,getdate())) 


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

