SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO





/* =====================================================================
	���α׷�ID : SXWBBulletinUI
	��  ��  �� : ���俹��
	���α׷��� : ��� �Է�-  ���,����
	�����ۼ��� : 2002/11/15
	�����ۼ��� : 2002/11/15
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */

CREATE        PROCEDURE dbo.SXWBBulletinUI

	@vcInsertModifyDelete varchar(10)
	,@vcParkClass  varchar(10)='�Ե�����'
	,@intIdx int =1
	,@vcTitle varchar(150)='�Էµ��� �ʾҽ��ϴ�'
	,@txtContents text='�Էµ��� �ʾҽ��ϴ�'
	,@dtStartDate datetime='1900-01-01'
	,@dtEndDate datetime='1900-01-01'
AS

BEGIN
	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWBBulletinUI:'	-- ���� ���� �ʱ�ȭ

	IF @vcInsertModifyDelete='modify'  --������� �� ��
	 BEGIN
		UPDATE dbo.txbbulletin 
		SET title=@vcTitle,contents=@txtContents ,startdate=@dtStartDate,enddate=@dtEndDate 
		WHERE IDX=@intIdx   
	 END

	IF @vcInsertModifyDelete='insert' --�Է� ����� ��
	 BEGIN
		INSERT INTO dbo.txbbulletin (parkclass,title,contents,startdate,enddate) 
		VALUES(@vcParkClass,@vcTitle,@txtContents,@dtStartDate,@dtEndDate)
	 END

	IF @vcInsertModifyDelete='delete'
	 BEGIN
		DELETE dbo.txbbulletin
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
