SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO





/* =====================================================================
	프로그램ID : SXWBBulletinUI
	업  무  명 : 수요예측
	프로그램명 : 행사 입력-  등록,삭제
	최초작성일 : 2002/11/15
	최종작성일 : 2002/11/15
	개  발  자 : 박순몽
	입  력  값 : 
	출  력  값 : 
	참고  사항 : 
  ===================================================================== */

CREATE        PROCEDURE dbo.SXWBBulletinUI

	@vcInsertModifyDelete varchar(10)
	,@vcParkClass  varchar(10)='롯데월드'
	,@intIdx int =1
	,@vcTitle varchar(150)='입력되지 않았습니다'
	,@txtContents text='입력되지 않았습니다'
	,@dtStartDate datetime='1900-01-01'
	,@dtEndDate datetime='1900-01-01'
AS

BEGIN
	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWBBulletinUI:'	-- 오류 내용 초기화

	IF @vcInsertModifyDelete='modify'  --수정모드 일 때
	 BEGIN
		UPDATE dbo.txbbulletin 
		SET title=@vcTitle,contents=@txtContents ,startdate=@dtStartDate,enddate=@dtEndDate 
		WHERE IDX=@intIdx   
	 END

	IF @vcInsertModifyDelete='insert' --입력 모드일 때
	 BEGIN
		INSERT INTO dbo.txbbulletin (parkclass,title,contents,startdate,enddate) 
		VALUES(@vcParkClass,@vcTitle,@txtContents,@dtStartDate,@dtEndDate)
	 END

	IF @vcInsertModifyDelete='delete'
	 BEGIN
		DELETE dbo.txbbulletin
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
