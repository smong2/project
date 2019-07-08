SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/*====================================================================================
	프로그램ID : SXWEElectMainQ
	업  무  명 : 수요예측
	프로그램명 : 전기 예측 - 메인
	최초작성일 : 2002/11/26
	최종작성일 : 2002/11/26
	개  발  자 : 박순몽
	입  력  값 :
	출  력  값 :
	참고  사항 :
====================================================================================*/
CREATE        PROCEDURE dbo.SXWEElectMainQ
	@varDateMode 	VARCHAR(15)
	,@dtLastday DATETIME
	,@dtLastWeekday DATETIME
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWElectMainQ:'	-- 오류 내용 초기화


	IF @varDateMode='today'  --오늘일 경우
	BEGIN
		SELECT *     --전기 전년 동일 실측치 가져오기 (3일)
		FROM dbo.txeeachbuildday 
		WHERE xdate=@dtLastday

		SELECT *   --전년 동요일 실측치 가져오기(3일)
		FROM dbo.txeeachbuildday 
		WHERE xdate=@dtLastWeekDay
	END

	IF @varDateMode='tomorrow'  --내일일 경우
	BEGIN
		SELECT *     --전기 전년 동일 실측치 가져오기 (3일)
		FROM dbo.txeeachbuildday 
		WHERE xdate=@dtLastday+1

		SELECT *   --전년 동요일 실측치 가져오기(3일)
		FROM dbo.txeeachbuildday 
		WHERE xdate=@dtLastWeekDay+1
	END

	IF @varDateMode='afterto' --모레일 경우
	BEGIN
		SELECT *     --전기 전년 동일 실측치 가져오기 (3일)
		FROM dbo.txeeachbuildday 
		WHERE xdate=@dtLastday+2

		SELECT *   --전년 동요일 실측치 가져오기(3일)
		FROM dbo.txeeachbuildday 
		WHERE xdate=@dtLastWeekDay+2
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

