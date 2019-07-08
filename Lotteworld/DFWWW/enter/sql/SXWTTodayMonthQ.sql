SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/* =====================================================================
	���α׷�ID : SXWTTodayMonthQ
	��  ��  �� : ���俹��
	���α׷��� : Today Month - ǥ��
	�����ۼ��� : 2002/11/11
	�����ۼ��� : 2002/11/11
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */


CREATE  PROCEDURE dbo.SXWTTodayMonthQ
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTTodayMonthQ:'	-- ���� ���� �ʱ�ȭ

	SELECT *,  --��ǥ ����
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child, 
	indivtotal+grouptotal as total 
	FROM dbo.vxtmonth 
	WHERE year=year(getdate()) and month=month(getdate())


	SELECT *,  --�� ����
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child, 
	indivtotal+grouptotal as total 
	FROM dbo.vxtemonth 
	WHERE year=year(getdate()) and month=month(getdate())

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

