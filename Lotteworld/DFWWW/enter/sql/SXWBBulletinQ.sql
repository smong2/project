SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO





/* =====================================================================
	���α׷�ID : SXWBBulletinQ
	��  ��  �� : ���俹��
	���α׷��� : ��� �Է�-  ������ ��ȸ
	�����ۼ��� : 2002/11/15
	�����ۼ��� : 2002/11/15
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */

CREATE        PROCEDURE dbo.SXWBBulletinQ
              @vcViewModify varchar(3)='Q'
	,@intIdx int=1
	,@vcParkClass varchar(10)='�Ե�����'
   
AS

BEGIN

          
	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWBBulletinQ:'	-- ���� ���� �ʱ�ȭ


		SELECT *             --�⺻ ����Ʈ ���
		FROM dbo.txbbulletin
		WHERE parkclass=@vcParkClass
		ORDER BY idx DESC

	IF @vcViewModify='MQ'  --������� �� ��
	 BEGIN
		SELECT * 
		FROM dbo.txbbulletin 
		WHERE IDX=@intIdx
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

