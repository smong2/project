SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



/*====================================================================================
	프로그램ID : SXWEElectdayQ
	업  무  명 : 수요예측
	프로그램명 : 전기 예측 - 일
	최초작성일 : 2002/11/26
	최종작성일 : 2002/11/26
	개  발  자 : 박순몽
	입  력  값 :
	출  력  값 :
	참고  사항 :
====================================================================================*/
CREATE        PROCEDURE dbo.SXWEElectDayQ
	@dtLastDay 	DATETIME
	,@dtLastWeekDay DATETIME
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWElectDayQ:'	-- 오류 내용 초기화

	SELECT *    --예측치 가져오기 3일
	FROM dbo.txeday
	WHERE Year=2002 and Month=7   	-- 실제 값 들어갈때 select year(getdate()), month(getdate()), month(getdate()), year(dateadd(dd,1,getdate())), month(dateadd(dd,1,getdate())), day(dateadd(dd,1,getdate())),  year(dateadd(dd,2,getdate())), month(dateadd(dd,2,getdate())), day(dateadd(dd,2,getdate()))

	SELECT *     --전기 전년 동일 실측치 가져오기 (3일)
	FROM dbo.txeeachbuildday 
	WHERE xdate>=@dtLastday and xdate<=@dtLastday+2

	SELECT *   --전년 동요일 실측치 가져오기(3일)
	FROM dbo.txeeachbuildday 
	WHERE xdate>=@dtLastWeekDay and xdate<=@dtLastWeekDay+2

	SELECT sum(total) as total,  --예측치 합계 가져오기
		sum(magicisland) as magicisland, 
		sum(adventure) as adventure, 
		sum(departmentstore) as departmentstore, 
		sum(sports) as sports,
		sum(shoppingmall) as shoppingmall, 
		sum(mart) as mart, 
		sum(hotel) as hotel 
	FROM dbo.txeday
	WHERE YEAR=2002 and Month=7

	SELECT sum(total) as total,  --전기 전년동일 실측 합계 가져오기
		sum(magicisland) as magicisland, 
		sum(adventure) as adventure, 
		sum(departmentstore) as departmentstore, 
		sum(sports) as sports,
		sum(shoppingmall) as shoppingmall, 
		sum(mart) as mart, 
		sum(hotel) as hotel 
	FROM dbo.txeeachbuildday 
	WHERE xdate>=cast(datename(year,@dtLastday)  + '-'  + datename(month,@dtLastday) + '-' + datename(day,'01-01-01') as datetime)  and xdate<=@dtLastDay
	

	SELECT  sum(total) as total,  --전년 동요일 합계 가져오기
		sum(magicisland) as magicisland, 
		sum(adventure) as adventure, 
		sum(departmentstore) as departmentstore, 
		sum(sports) as sports,
		sum(shoppingmall) as shoppingmall, 
		sum(mart) as mart, 
		sum(hotel) as hotel 
	FROM dbo.txeeachbuildday 
	WHERE xdate>=cast(datename(year,@dtLastWeekday)  + '-'  + datename(month,@dtLastWeekday) + '-' + datename(day,'01-01-01') as datetime)   and xdate<=@dtLastWeekday

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

