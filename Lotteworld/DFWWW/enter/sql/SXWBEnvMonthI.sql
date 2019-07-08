SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/*====================================================================================
	���α׷�ID : SXWBEnvMonthI
	��  ��  �� : ���俹��
	���α׷��� : ���尴 ���� �Է� - ��
	�����ۼ��� : 2002/11/26
	�����ۼ��� : 2002/11/26
	��  ��  �� : �ڼ���
	��  ��  �� :
	��  ��  �� :
	����  ���� :
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

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWBEnvMonthI:'	-- ���� ���� �ʱ�ȭ


		DELETE dbo.txbEnvMonth  --���� �⵵ �ڷ� ������ �����
		WHERE YEAR=@intYear and MONTH=@intMonth

		INSERT INTO dbo.txbEnvMonth  -- �� ������ �ִ´�
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

