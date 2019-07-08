SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/*====================================================================================
	프로그램ID : SXWEElectMonthQ
	업  무  명 : 수요예측
	프로그램명 : 전기 예측 - 월
	최초작성일 : 2002/11/26
	최종작성일 : 2002/11/26
	개  발  자 : 박순몽
	입  력  값 :
	출  력  값 :
	참고  사항 :
====================================================================================*/
CREATE      PROCEDURE dbo.SXWEElectMonthQ
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWElectMonthQ:'	-- 오류 내용 초기화

	SELECT *   --예측값 가져오기
	FROM dbo.txemonth
	WHERE year=2002 and Month>=5 and Month<=7  --where year>=year(getdate()) and month>=month(getdate()) or year<=year(dateadd(mm,2,getdate())) and month<=month(dateadd(mm,2,getdate()))

	SELECT * 
	FROM dbo.txeeachbuildmonth   --전년 동월 과거치 가져오기 (3개월)
	WHERE (year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or  
		(year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or 
		(year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT sum(total) as total,    --예측값 합계
		sum(adventure) as adventure, 
		sum(magicisland) as magicisland, 
		sum(hotel) as hotel, 
		sum(departmentstore) as departmentstore, 
		sum(mart) as mart, 
		sum(sports) as sports, 
		sum(shoppingmall) as shoppingmall   
	FROM dbo.txemonth
	WHERE year=2002 and Month>=5 and Month<=7	

	SELECT sum(total) as total,    --전년 동월 합계
		sum(adventure) as adventure, 
		sum(magicisland) as magicisland, 
		sum(hotel) as hotel, 
		sum(departmentstore) as departmentstore, 
		sum(mart) as mart, 
		sum(sports) as sports, 
		sum(shoppingmall) as shoppingmall 
	FROM dbo.txeeachbuildmonth 
	WHERE year=year(getdate())-1 and month<=month(getdate())

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

