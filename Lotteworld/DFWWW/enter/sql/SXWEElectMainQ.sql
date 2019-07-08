SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/*====================================================================================
	���α׷�ID : SXWEElectMainQ
	��  ��  �� : ���俹��
	���α׷��� : ���� ���� - ����
	�����ۼ��� : 2002/11/26
	�����ۼ��� : 2002/11/26
	��  ��  �� : �ڼ���
	��  ��  �� :
	��  ��  �� :
	����  ���� :
====================================================================================*/
CREATE        PROCEDURE dbo.SXWEElectMainQ
	@varDateMode 	VARCHAR(15)
	,@dtLastday DATETIME
	,@dtLastWeekday DATETIME
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWElectMainQ:'	-- ���� ���� �ʱ�ȭ


	IF @varDateMode='today'  --������ ���
	BEGIN
		SELECT *     --���� ���� ���� ����ġ �������� (3��)
		FROM dbo.txeeachbuildday 
		WHERE xdate=@dtLastday

		SELECT *   --���� ������ ����ġ ��������(3��)
		FROM dbo.txeeachbuildday 
		WHERE xdate=@dtLastWeekDay
	END

	IF @varDateMode='tomorrow'  --������ ���
	BEGIN
		SELECT *     --���� ���� ���� ����ġ �������� (3��)
		FROM dbo.txeeachbuildday 
		WHERE xdate=@dtLastday+1

		SELECT *   --���� ������ ����ġ ��������(3��)
		FROM dbo.txeeachbuildday 
		WHERE xdate=@dtLastWeekDay+1
	END

	IF @varDateMode='afterto' --���� ���
	BEGIN
		SELECT *     --���� ���� ���� ����ġ �������� (3��)
		FROM dbo.txeeachbuildday 
		WHERE xdate=@dtLastday+2

		SELECT *   --���� ������ ����ġ ��������(3��)
		FROM dbo.txeeachbuildday 
		WHERE xdate=@dtLastWeekDay+2
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

