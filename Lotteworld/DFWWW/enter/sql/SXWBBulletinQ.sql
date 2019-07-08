SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO





/* =====================================================================
	프로그램ID : SXWBBulletinQ
	업  무  명 : 수요예측
	프로그램명 : 행사 입력-  관리자 조회
	최초작성일 : 2002/11/15
	최종작성일 : 2002/11/15
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */

CREATE        PROCEDURE dbo.SXWBBulletinQ
              @vcViewModify varchar(3)='Q'
	,@intIdx int=1
	,@vcParkClass varchar(10)='롯데월드'
   
AS

BEGIN

          
	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWBBulletinQ:'	-- 오류 내용 초기화


		SELECT *             --기본 리스트 출력
		FROM dbo.txbbulletin
		WHERE parkclass=@vcParkClass
		ORDER BY idx DESC

	IF @vcViewModify='MQ'  --수정모드 일 때
	 BEGIN
		SELECT * 
		FROM dbo.txbbulletin 
		WHERE IDX=@intIdx
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

