SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/*====================================================================================
	���α׷�ID : SXWBWeatherViewQ
	��  ��  �� : ���俹��
	���α׷��� : ���� ǥ�� -  ���
	�����ۼ��� : 2002/11/28
	�����ۼ��� : 2002/11/28
	��  ��  �� : �ڼ���
	��  ��  �� :
	��  ��  �� :
	����  ���� :
====================================================================================*/
CREATE   PROCEDURE dbo.SXWBWeatherViewQ
	@vcAreaCode VARCHAR(10)='������'
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWBWeatherViewQ:'	-- ���� ���� �ʱ�ȭ

	SELECT *   --������Ȳ ��������    1
	FROM dbo.txbweatheroverview
	WHERE left(ForecastDate,4)=year(getdate()) and substring(ForecastDate,5,2)=month(getdate()) and right(ForecastDate,2)=day(getdate()-3)

	SELECT *  --���󿹺� ��������     2
	FROM dbo.txbweatherland
	WHERE left(ForecastDate,4)=year(getdate()) and substring(ForecastDate,5,2)=month(getdate()) and right(ForecastDate,2)=day(getdate()-3)

	SELECT *  --�ػ󿹺� ��������     3
	FROM dbo.txbweatherSea
	WHERE left(ForecastDate,4)=year(getdate()) and substring(ForecastDate,5,2)=month(getdate()) and right(ForecastDate,2)=day(getdate()-3)

	SELECT *  --�ְ����� ��������     4
	FROM dbo.txbweatherweek
	WHERE left(ForecastDate,4)=year(getdate()) and substring(ForecastDate,5,2)=month(getdate()) and right(ForecastDate,2)=day(getdate()-4)

	SELECT areaname  --�������� ��ϰ�������     5
	FROM dbo.txbweatherlifeindex

	SELECT sdate,areaname,  --���� ���� ��������    6
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

	SELECT *    --����Ʈ ���� ���� ��������   7
	FROM dbo.txbweatherseoul
	WHERE left(sDate,4)=year(dateadd(dd,-3,getdate())) and substring(sDate,5,2)=month(dateadd(dd,-3,getdate())) and right(sDate,2)=day(dateadd(dd,-3,getdate())) or
		left(sDate,4)=year(dateadd(dd,-2,getdate())) and substring(sDate,5,2)=month(dateadd(dd,-2,getdate())) and right(sDate,2)=day(dateadd(dd,-2,getdate())) or	
		left(sDate,4)=year(dateadd(dd,-1,getdate())) and substring(sDate,5,2)=month(dateadd(dd,-1,getdate())) and right(sDate,2)=day(dateadd(dd,-1,getdate())) or
		left(sDate,4)=year(dateadd(dd,0,getdate())) and substring(sDate,5,2)=month(dateadd(dd,0,getdate())) and right(sDate,2)=day(dateadd(dd,0,getdate())) or
		left(sDate,4)=year(dateadd(dd,1,getdate())) and substring(sDate,5,2)=month(dateadd(dd,1,getdate())) and right(sDate,2)=day(dateadd(dd,1,getdate())) or
		left(sDate,4)=year(dateadd(dd,2,getdate())) and substring(sDate,5,2)=month(dateadd(dd,2,getdate())) and right(sDate,2)=day(dateadd(dd,2,getdate())) or
		left(sDate,4)=year(dateadd(dd,3,getdate())) and substring(sDate,5,2)=month(dateadd(dd,3,getdate())) and right(sDate,2)=day(dateadd(dd,3,getdate())) or
		left(sDate,4)=year(dateadd(dd,4,getdate())) and substring(sDate,5,2)=month(dateadd(dd,4,getdate())) and right(sDate,2)=day(dateadd(dd,4,getdate())) 

	SELECT *    --����Ʈ ���� ���� �������� 8
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
		SET @vcError = @vcSpname + '���� ����'
--Error �߻� �� log ���
		EXEC dbo.SXBWriteLogI 'X.dbo.SP', @vcError

	END
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

