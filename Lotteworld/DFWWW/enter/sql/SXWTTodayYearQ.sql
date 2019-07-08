SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/* =====================================================================
	���α׷�ID : SXWTTodayYearQ
	��  ��  �� : ���俹��
	���α׷��� : Today Year - ǥ��
	�����ۼ��� : 2002/11/11
	�����ۼ��� : 2002/11/11
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */


CREATE  PROCEDURE dbo.SXWTTodayYearQ
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTTodayYearQ:'	-- ���� ���� �ʱ�ȭ

	SELECT indivadult, --��ǥ �� ����ġ
	groupadult, 
	indivschool,
	groupschool, 
	indivchild,
	groupchild, 
	indivtotal, 
	grouptotal, 
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child, 
	indivtotal+grouptotal as total 
	FROM dbo.vxtyear 
	WHERE year=year(getdate())

	SELECT indivadult,  --������ �� ����ġ
	groupadult, 
	indivschool,
	groupschool, 
	indivchild,
 	groupchild, 
	indivtotal, 
	grouptotal, 
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child, 
	indivtotal+grouptotal as total 
	FROM dbo.vxteyear 
	WHERE year=year(getdate())


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

