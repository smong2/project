SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/*====================================================================================
	프로그램ID : SXWEElectResultsInputI
	업  무  명 : 수요예측
	프로그램명 : 전기 입력 - 실적 입력
	최초작성일 : 2002/11/27
	최종작성일 : 2002/11/27
	개  발  자 : 박순몽
	입  력  값 :
	출  력  값 :
	참고  사항 :
====================================================================================*/
CREATE   PROCEDURE dbo.SXWEElectResultsInputI
	 @varModelType VARCHAR(15)
	,@varInput_Year VARCHAR(5)
	,@varInput_Month VARCHAR(5)
	,@varInput_Day VARCHAR(5)=1
	,@nMagicisland NUMERIC(19,5)
	,@nAdventure NUMERIC(19,5)
	,@nSports NUMERIC(19,5)
	,@nHotel NUMERIC(19,5)
	,@nDepartmentstore NUMERIC(19,5)
	,@nShoppingmall NUMERIC(19,5)
	,@nMart NUMERIC(19,5)
	,@nTotal NUMERIC(19,5)
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWEElectResultsInputI:'	-- 오류 내용 초기화

	IF @varModelType='results_day'  --일 입력인 경우
		BEGIN
		  	DELETE FROM dbo.txeeachbuildday    --지울 건 지우고
			WHERE xdate=@varInput_Year + '-' + @varInput_Month + '-' + @varInput_Day

	  		INSERT INTO dbo.txeeachbuildday    --입력한다
			(xdate,magicisland,adventure,sports,hotel,departmentstore,shoppingmall,mart,total) 
			values (@varInput_Year + '-' + @varInput_Month + '-' + @varInput_Day,
				@nmagicisland,
				@nadventure,
				@nsports,
				@nhotel,
				@ndepartmentstore,
				@nshoppingmall,
				@nmart,
				@ntotal)
		END
	ELSE IF @varModelType='results_month'  --월 입력인 경우
		BEGIN
	  		DELETE FROM dbo.txeeachbuildmonth   --지울 건 지우고(동일자료)
			WHERE year=@varinput_year and month=@varinput_month

	 		INSERT INTO dbo.txeeachbuildmonth   --입력한다
			(year,month,magicisland,adventure,sports,hotel,departmentstore,shoppingmall,mart,total) 
			VALUES (@varInput_Year,
				@varInput_Month,
				@nMagicisland,
				@nAdventure,
				@nSports,
				@nHotel,
				@nDepartmentstore,
				@nShoppingmall,
				@nMart,
				@nTotal)
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

