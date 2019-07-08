SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/* =====================================================================
	���α׷�ID : SXWTEnterMainTodayQ
	��  ��  �� : ���俹��
	���α׷��� : ����� ���� ����-  ù������ - ����
	�����ۼ��� : 2002/11/25
	�����ۼ��� : 2002/11/25
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */

CREATE    PROCEDURE dbo.SXWTEnterMainTodayQ
 @varDayMode varchar(10)
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterMainTodayQ:'	-- ���� ���� �ʱ�ȭ

	IF @varDayMode='Today'
	BEGIN
		SELECT TOP 5 * 
		FROM dbo.txbbulletin 
		WHERE parkclass='�Ե�����'  --�Ե������ 7�� ���ڵ带 ��������
	
		SELECT TOP 5 * 
		FROM dbo.txbbulletin 
		WHERE parkclass='��������'  --���������

		SELECT TOP 5 * 
		FROM dbo.txbbulletin 
		WHERE parkclass='���﷣��'  --���﷣��� 5������ �����´�.
	END

	IF @varDayMode='Tomorrow'
	BEGIN
		SELECT TOP 5 * 
		FROM dbo.txbbulletin 
		WHERE parkclass='�Ե�����'  --�Ե������ 7�� ���ڵ带 ��������
	
		SELECT TOP 5 * 
		FROM dbo.txbbulletin 
		WHERE parkclass='��������'  --���������

		SELECT TOP 5 * 
		FROM dbo.txbbulletin 
		WHERE parkclass='���﷣��'  --���﷣��� 5������ �����´�.
	END

	IF @varDayMode='AfterTo'			
	BEGIN
		SELECT TOP 5 * 
		FROM dbo.txbbulletin 
		WHERE parkclass='�Ե�����'  --�Ե������ 7�� ���ڵ带 ��������
	
		SELECT TOP 5 * 
		FROM dbo.txbbulletin 
		WHERE parkclass='��������'  --���������

		SELECT TOP 5 * 
		FROM dbo.txbbulletin 
		WHERE parkclass='���﷣��'  --���﷣��� 5������ �����´�.
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

