SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



/* =====================================================================
	���α׷�ID : SXWBBulletinMainQ
	��  ��  �� : ���俹��
	���α׷��� : ��� ����Ʈ����-  ����
	�����ۼ��� : 2002/11/11
	�����ۼ��� : 2002/11/11
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */


CREATE    PROCEDURE dbo.SXWBBulletinMainQ
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWBBulletinMainQ:'	-- ���� ���� �ʱ�ȭ

            	SELECT TOP 7  --�Ե������ 7�� ���ڵ带 ��������
              idx,
	parkclass,
	title,
	contents,
	startdate,
	enddate
	FROM dbo.txbbulletin 
	WHERE parkclass='�Ե�����' 
	ORDER BY idx DESC  

	SELECT TOP 5  --��������� 5���� ���ڵ�
              idx,
	parkclass,
	title,
	contents,
	startdate,
	enddate
	FROM dbo.txbbulletin 
	WHERE parkclass='��������' 
	ORDER BY idx DESC  

	SELECT TOP 5  --���﷣��� 5������ �����´�.
              idx,
	parkclass,
	title,
	contents,
	startdate,
	enddate
	FROM dbo.txbbulletin 
	WHERE parkclass='���﷣��' 
	ORDER BY idx DESC  

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

