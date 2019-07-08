SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



/* =====================================================================
	프로그램ID : SXWBBulletinViewQ
	업  무  명 : 수요예측
	프로그램명 : 행사 내용보기-  표출
	최초작성일 : 2002/11/11
	최종작성일 : 2002/11/11
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */


CREATE    PROCEDURE dbo.SXWBBulletinViewQ
 @intIdx int
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWBBulletinViewQ:'	-- 오류 내용 초기화

              SELECT idx,   --행사 정보 가져오기
	parkclass,
	title,
	contents,
	startdate,
	enddate
	FROM dbo.txbbulletin 
	WHERE idx=@intIdx

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

