SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/*====================================================================================
	���α׷�ID : SXWEElectRideInputI
	��  ��  �� : ���俹��
	���α׷��� : ���� ���̵� �Է� - ���̵� �Է�
	�����ۼ��� : 2002/11/27
	�����ۼ��� : 2002/11/27
	��  ��  �� : �ڼ���
	��  ��  �� :
	��  ��  �� :
	����  ���� :
====================================================================================*/
CREATE  PROCEDURE dbo.SXWEElectRideInputI
	@varInsert VARCHAR(5)='no'
	,@dtInput_Date DATETIME='1900-01-01'
	,@varRideName VARCHAR(50)='�Է¾���'
	,@varExamRide VARCHAR(20)='�Է¾���'
AS
BEGIN
	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWEElectRideInputI:'	-- ���� ���� �ʱ�ȭ


	SELECT ridetype,examride   --���̵� ���� ��������
	FROM dbo.txbmasterride

	IF @varInsert='ok'  --�Է� ����϶�
	BEGIN
		DELETE FROM dbo.txeridelist   --���� �ڷ�� �����
		WHERE ridestartday=@dtInput_Date and ridename=@varRideName
 
		INSERT INTO dbo.txeridelist  --�Է��Ѵ�
		(ridename,examride,ridestartday) 
		VALUES(@varRideName,
		@varExamRide,
		@dtinput_date)
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

