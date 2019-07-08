SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/*====================================================================================
	프로그램ID : SXWEElectConstructionI
	업  무  명 : 수요예측
	프로그램명 : 전기 입력 - 공사이력 입력
	최초작성일 : 2002/11/27
	최종작성일 : 2002/11/27
	개  발  자 : 박순몽
	입  력  값 :
	출  력  값 :
	참고  사항 :
====================================================================================*/
CREATE   PROCEDURE dbo.SXWEElectConstructionI
 @varInputMode VARCHAR(10)='No'
,@dtStartday DATETIME='1900-01-01'
,@dtEndday DATETIME='1900-01-01'
,@varConstructionName VARCHAR(50)='1'
,@varConstructionType VARCHAR(10)='1'
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWEElectConstructionI:'	-- 오류 내용 초기화

	SELECT repairtype, repairtypename  --공사 형식 자료 가져오기
	FROM dbo.txbmasterrepair

	IF @varInputMode='ok'
	BEGIN
		DELETE FROM dbo.txerepairlist   -- 동일 자료는 삭제
		WHERE repairstartday=@dtStartday and repairendday=@dtEndday and repairname=@varConstructionName

		INSERT INTO dbo.txerepairlist    --자료 입력
		(repairname,repairtype,repairstartday,repairendday) 
		VALUES(@varConstructionName,
			@varConstructionType,
			@dtStartday,
			@dtEndday)
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

