SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/*====================================================================================
	프로그램ID : SXWEElectRideInputI
	업  무  명 : 수요예측
	프로그램명 : 전기 라이드 입력 - 라이드 입력
	최초작성일 : 2002/11/27
	최종작성일 : 2002/11/27
	개  발  자 : 박순몽
	입  력  값 :
	출  력  값 :
	참고  사항 :
====================================================================================*/
CREATE  PROCEDURE dbo.SXWEElectRideInputI
	@varInsert VARCHAR(5)='no'
	,@dtInput_Date DATETIME='1900-01-01'
	,@varRideName VARCHAR(50)='입력없음'
	,@varExamRide VARCHAR(20)='입력없음'
AS
BEGIN
	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWEElectRideInputI:'	-- 오류 내용 초기화


	SELECT ridetype,examride   --라이드 유형 가져오기
	FROM dbo.txbmasterride

	IF @varInsert='ok'  --입력 모드일때
	BEGIN
		DELETE FROM dbo.txeridelist   --동일 자료는 지우고
		WHERE ridestartday=@dtInput_Date and ridename=@varRideName
 
		INSERT INTO dbo.txeridelist  --입력한다
		(ridename,examride,ridestartday) 
		VALUES(@varRideName,
		@varExamRide,
		@dtinput_date)
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

