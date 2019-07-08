SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/*====================================================================================
	프로그램ID : SXWBEnvYearI
	업  무  명 : 수요예측
	프로그램명 : 입장객 변수 입력 - 년
	최초작성일 : 2002/11/26
	최종작성일 : 2002/11/26
	개  발  자 : 박순몽
	입  력  값 :
	출  력  값 :
	참고  사항 : 
====================================================================================*/
CREATE      PROCEDURE dbo.SXWBEnvYearI
	@intYear INT
	,@nPopNationalAdult     NUMERIC(19,5)
	,@nPopSeoulSchool     NUMERIC(19,5)
	,@nPopSeoulChild        NUMERIC(19,5)
	,@nPopMetropolisAdult NUMERIC(19,5)
	,@nKOSPI	        NUMERIC(19,5)
	,@intDummyCard    	INT
	,@intDummyIMF    	INT
	,@intDummyGyroDrop  	 INT
	,@intDummyHOSTS     	 INT
	,@nManufacturingKOSPI   NUMERIC(19,5)
	,@nFinancialKOSPI	        NUMERIC(19,5)
	,@nConstructionKOSPI    NUMERIC(19,5)
	,@nDistributionKOSPI        NUMERIC(19,5)
	,@nGNI	        		NUMERIC(19,5)
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWBEnvYearI:'	-- 오류 내용 초기화


		DELETE dbo.txbEnvYear  --동일 년도 자료 있으면 지우고
		WHERE YEAR=@intYear

		INSERT INTO dbo.txbEnvYear  -- 이 값으로 넣는다
		(Year,PopNationalAdult,PopSeoulSchool,PopSeoulChild,PopMetropolisAdult,KOSPI,DummyCard,DummyIMF,DummyGyroDrop,HOSTS,ManufacturingKOSPI,FinancialKOSPI,ConstructionKOSPI,DistributionKOSPI,GNI)
		VALUES(@intYear
			,@nPopNationalAdult
			,@nPopSeoulSchool
			,@nPopSeoulChild
			,@nPopMetropolisAdult
			,@nKOSPI
			,@intDummyCard
			,@intDummyIMF
			,@intDummyGyroDrop
			,@intDummyHOSTS
			,@nManufacturingKOSPI
			,@nFinancialKOSPI
			,@nConstructionKOSPI
			,@nDistributionKOSPI
			,@nGNI)

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

