SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/* =====================================================================
	프로그램ID : SXWTEnterMainTodayQ
	업  무  명 : 수요예측
	프로그램명 : 경쟁사 예측 메인-  첫페이지 - 오늘
	최초작성일 : 2002/11/25
	최종작성일 : 2002/11/25
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */

CREATE    PROCEDURE dbo.SXWTEnterMainTodayQ
 @varDayMode varchar(10)
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterMainTodayQ:'	-- 오류 내용 초기화

	IF @varDayMode='Today'
	BEGIN
		SELECT TOP 5 * 
		FROM dbo.txbbulletin 
		WHERE parkclass='롯데월드'  --롯데월드는 7개 레코드를 가져오고
	
		SELECT TOP 5 * 
		FROM dbo.txbbulletin 
		WHERE parkclass='에버랜드'  --에버랜드와

		SELECT TOP 5 * 
		FROM dbo.txbbulletin 
		WHERE parkclass='서울랜드'  --서울랜드는 5개씩을 가져온다.
	END

	IF @varDayMode='Tomorrow'
	BEGIN
		SELECT TOP 5 * 
		FROM dbo.txbbulletin 
		WHERE parkclass='롯데월드'  --롯데월드는 7개 레코드를 가져오고
	
		SELECT TOP 5 * 
		FROM dbo.txbbulletin 
		WHERE parkclass='에버랜드'  --에버랜드와

		SELECT TOP 5 * 
		FROM dbo.txbbulletin 
		WHERE parkclass='서울랜드'  --서울랜드는 5개씩을 가져온다.
	END

	IF @varDayMode='AfterTo'			
	BEGIN
		SELECT TOP 5 * 
		FROM dbo.txbbulletin 
		WHERE parkclass='롯데월드'  --롯데월드는 7개 레코드를 가져오고
	
		SELECT TOP 5 * 
		FROM dbo.txbbulletin 
		WHERE parkclass='에버랜드'  --에버랜드와

		SELECT TOP 5 * 
		FROM dbo.txbbulletin 
		WHERE parkclass='서울랜드'  --서울랜드는 5개씩을 가져온다.
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

