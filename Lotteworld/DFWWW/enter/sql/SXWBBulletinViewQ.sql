SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



/* =====================================================================
	���α׷�ID : SXWBBulletinViewQ
	��  ��  �� : ���俹��
	���α׷��� : ��� ���뺸��-  ǥ��
	�����ۼ��� : 2002/11/11
	�����ۼ��� : 2002/11/11
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */


CREATE    PROCEDURE dbo.SXWBBulletinViewQ
 @intIdx int
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWBBulletinViewQ:'	-- ���� ���� �ʱ�ȭ

              SELECT idx,   --��� ���� ��������
	parkclass,
	title,
	contents,
	startdate,
	enddate
	FROM dbo.txbbulletin 
	WHERE idx=@intIdx

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

