SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/*====================================================================================
	���α׷�ID : SXWEElectConstructionI
	��  ��  �� : ���俹��
	���α׷��� : ���� �Է� - �����̷� �Է�
	�����ۼ��� : 2002/11/27
	�����ۼ��� : 2002/11/27
	��  ��  �� : �ڼ���
	��  ��  �� :
	��  ��  �� :
	����  ���� :
====================================================================================*/
CREATE   PROCEDURE dbo.SXWEElectConstructionI
 @varInputMode VARCHAR(10)='No'
,@dtStartday DATETIME='1900-01-01'
,@dtEndday DATETIME='1900-01-01'
,@varConstructionName VARCHAR(50)='1'
,@varConstructionType VARCHAR(10)='1'
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWEElectConstructionI:'	-- ���� ���� �ʱ�ȭ

	SELECT repairtype, repairtypename  --���� ���� �ڷ� ��������
	FROM dbo.txbmasterrepair

	IF @varInputMode='ok'
	BEGIN
		DELETE FROM dbo.txerepairlist   -- ���� �ڷ�� ����
		WHERE repairstartday=@dtStartday and repairendday=@dtEndday and repairname=@varConstructionName

		INSERT INTO dbo.txerepairlist    --�ڷ� �Է�
		(repairname,repairtype,repairstartday,repairendday) 
		VALUES(@varConstructionName,
			@varConstructionType,
			@dtStartday,
			@dtEndday)
	END

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

