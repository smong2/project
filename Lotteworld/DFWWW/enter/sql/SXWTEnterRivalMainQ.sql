SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO






/* =====================================================================
	���α׷�ID : SXWTEnterRivalMainQ
	��  ��  �� : ���俹��
	���α׷��� : ����� ����- ǥ�� (���� )
	�����ۼ��� : 2002/11/11
	�����ۼ��� : 2002/11/11
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */


CREATE     PROCEDURE dbo.SXWTEnterRivalMainQ
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterRivalMaInQ:'	-- ���� ���� �ʱ�ȭ

	SELECT year,	--���� (����, ���﷣��) 
	month, 
	evertotal, 
	everadult,
	everschool,
	everchild,
	seoultotal,
	seouladult,
	seoulschool,
	seoulchild  
	FROM dbo.txtrivalmonth 
	WHERE year=year(getdate()) and month=month(getdate())

	SELECT indivadult+groupadult as lotteadult, --���� (�Ե�����)
	indivschool+groupschool as lotteschool, 
	indivchild+groupchild as lottechild, 
	indivtotal+grouptotal as lottetotal 
	FROM dbo.vxtmonth 
	WHERE year=year(getdate()) and month=month(getdate())

	SELECT sum(evertotal) as evertotal, --���� ���� (����, ���﷣��) 
	sum(seoultotal) as seoultotal 
	FROM dbo.txtrivalmonth 
	WHERE year=year(getdate()) and month<=month(getdate())

	

	SELECT sum(indivtotal+grouptotal) as lottetotal --���� ���� (�Ե�����) 
	FROM dbo.vxtmonth 
	WHERE year=year(getdate()) and month<=month(getdate())

	SELECT evertotal, --�⺰ (����, ���﷣��) 
	everadult,
	everschool,
	everchild,
	seoultotal,
	seouladult,
	seoulschool,
	seoulchild 
	FROM dbo.txtrivalyear 
	WHERE year=year(getdate())

	SELECT indivadult+groupadult as lotteadult, --�⺰ �Ե����� 
	indivschool+groupschool as lotteschool, 
	indivchild+groupchild as lottechild, 
	indivtotal+grouptotal as lottetotal 
	FROM dbo.vxtyear 
	WHERE year=year(getdate())

	SELECT sum(evertotal) as evertotal, --�⺰ ���� (����, ���﷣��) 
	sum(seoultotal) as seoultotal 
	FROM dbo.txtrivalyear 
	WHERE year>=year(getdate()) and year<=year(getdate())

	SELECT sum(indivtotal+grouptotal) as lottetotal --�⺰ ���� (�Ե�����) 
	FROM dbo.vxtyear 
	WHERE year>=year(getdate()) and year<=year(getdate())


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

