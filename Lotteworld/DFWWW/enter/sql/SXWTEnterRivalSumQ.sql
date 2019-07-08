SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



/* =====================================================================
	���α׷�ID : SXWTEnterRivalSuMQ
	��  ��  �� : ���俹��
	���α׷��� : ����� ����- ǥ�� (������ )
	�����ۼ��� : 2002/11/11
	�����ۼ��� : 2002/11/11
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */


CREATE  PROCEDURE dbo.SXWTEnterRivalSumQ
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterRivalSumQ:'	-- ���� ���� �ʱ�ȭ

	SELECT  year, --���� (����,���﷣��)
	month,
	evertotal,
	seoultotal
	FROM dbo.txtrivalmonth 
	WHERE year=year(getdate()) 
	ORDER BY month

	SELECT indivtotal+grouptotal as total --���� (�Ե�����)
	FROM dbo.vxtmonth 
	WHERE year=year(getdate())

	SELECT  sum(evertotal) as evertotal, --���� ���� (����, ���﷣��)
	sum(seoultotal) as seoultotal 
	FROM dbo.txtrivalmonth 
	WHERE year=year(getdate())

	SELECT sum(indivtotal+grouptotal) as total --���� ���� (�Ե�����)
	FROM dbo.vxtmonth 
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

