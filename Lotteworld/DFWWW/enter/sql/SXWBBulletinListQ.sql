SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



/* =====================================================================
	프로그램ID : SXWBBulletinMainQ
	업  무  명 : 수요예측
	프로그램명 : 행사 리스트보기-  메인
	최초작성일 : 2002/11/11
	최종작성일 : 2002/11/11
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */


CREATE    PROCEDURE dbo.SXWBBulletinMainQ
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWBBulletinMainQ:'	-- 오류 내용 초기화

            	SELECT TOP 7  --롯데월드는 7개 레코드를 가져오고
              idx,
	parkclass,
	title,
	contents,
	startdate,
	enddate
	FROM dbo.txbbulletin 
	WHERE parkclass='롯데월드' 
	ORDER BY idx DESC  

	SELECT TOP 5  --에버랜드는 5개의 레코드
              idx,
	parkclass,
	title,
	contents,
	startdate,
	enddate
	FROM dbo.txbbulletin 
	WHERE parkclass='에버랜드' 
	ORDER BY idx DESC  

	SELECT TOP 5  --서울랜드는 5개씩을 가져온다.
              idx,
	parkclass,
	title,
	contents,
	startdate,
	enddate
	FROM dbo.txbbulletin 
	WHERE parkclass='서울랜드' 
	ORDER BY idx DESC  

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

