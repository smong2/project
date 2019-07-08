SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/*====================================================================================
	프로그램ID : SXWBEnvMonthI
	업  무  명 : 수요예측
	프로그램명 : 입장객 변수 입력 - 월
	최초작성일 : 2002/11/26
	최종작성일 : 2002/11/26
	개  발  자 : 박순몽
	입  력  값 :
	출  력  값 :
	참고  사항 :
====================================================================================*/
CREATE    PROCEDURE dbo.SXWBEnvMonthI
	@intYear 		INT
	,@intMonth 		INT
	,@intDummyGiantRoof	INT
	,@intDummyGyroDrop   	INT
	,@intDummyGyroSwing	INT
	,@intDummyIMF    	INT
	,@intDummyCard    	INT
	,@intSnowFall		INT
	,@nHOSTS      		NUMERIC(19,5)
	,@intDepartmentDutyMonth INT
	,@intRepairMonthlyIndex 	INT
	,@nKOSPI		NUMERIC(19,5)
	,@nManufacturingKOSPI   	NUMERIC(19,5)
	,@nFinancialKOSPI	NUMERIC(19,5)
	,@nDistributionKOSPI        	NUMERIC(19,5)
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- 오류처리
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWBEnvMonthI:'	-- 오류 내용 초기화


		DELETE dbo.txbEnvMonth  --동일 년도 자료 있으면 지우고
		WHERE YEAR=@intYear and MONTH=@intMonth

		INSERT INTO dbo.txbEnvMonth  -- 이 값으로 넣는다
		(Year,Month,DummyGiantRoof,DummyGyroDrop,DummyGyroSwing,DummyIMF,DummyCard,SnowFall,HOSTS,DepartmentDutyMonth,RepairMonthlyIndex,KOSPI,ManufacturingKOSPI,FinancialKOSPI,DistributionKOSPI)
		VALUES(	@intYear
			,@intMonth			
			,@intDummyGiantRoof
			,@intDummyGyroDrop
			,@intDummyGyroSwing
			,@intDummyIMF
			,@intDummyCard
			,@intSnowFall
			,@nHOSTS
			,@intDepartmentDutyMonth
			,@intRepairMonthlyIndex
			,@nKOSPI
			,@nManufacturingKOSPI
			,@nFinancialKOSPI
			,@nDistributionKOSPI)

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

