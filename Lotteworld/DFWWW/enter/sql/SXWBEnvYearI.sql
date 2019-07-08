SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/*====================================================================================
	���α׷�ID : SXWBEnvYearI
	��  ��  �� : ���俹��
	���α׷��� : ���尴 ���� �Է� - ��
	�����ۼ��� : 2002/11/26
	�����ۼ��� : 2002/11/26
	��  ��  �� : �ڼ���
	��  ��  �� :
	��  ��  �� :
	����  ���� : 
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

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWBEnvYearI:'	-- ���� ���� �ʱ�ȭ


		DELETE dbo.txbEnvYear  --���� �⵵ �ڷ� ������ �����
		WHERE YEAR=@intYear

		INSERT INTO dbo.txbEnvYear  -- �� ������ �ִ´�
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
		SET @vcError = @vcSpname + '���� ����'
--Error �߻� �� log ���
		EXEC dbo.SXBWriteLogI 'X.dbo.SP', @vcError

	END
END




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

