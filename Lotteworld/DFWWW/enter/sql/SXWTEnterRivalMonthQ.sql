SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




/* =====================================================================
	���α׷�ID : SXWTEnterRivalMonthQ
	��  ��  �� : ���俹��
	���α׷��� : ����� ����- ǥ�� (�� )
	�����ۼ��� : 2002/11/11
	�����ۼ��� : 2002/11/11
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */


CREATE     PROCEDURE dbo.SXWTEnterRivalMonthQ
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterRivalMonthQ:'	-- ���� ���� �ʱ�ȭ

	SELECT year, --����� �� ����
	month,
	evertotal,
	seoultotal
	FROM dbo.txtrivalmonth 
	WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  (year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or (year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate()))) 

	SELECT year, --���Ž���
	month,
	sum(everindiv+everorg) as evertotal, 
	sum(seoulindiv+seoulorg) as seoultotal 
	FROM dbo.txtrivalenter 
	WHERE (year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or  (year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or (year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate()))) 
	GROUP BY year,month

	SELECT sum(evertotal) as evertotal,  --����� �� ���� �հ�
	sum(seoultotal) as seoultotal 
	FROM dbo.txtrivalmonth 
	WHERE year=year(getdate())

	SELECT sum(everindiv+everorg) as evertotal,  --���� �Ǡ� �հ�
	sum(seoulindiv+seoulorg) as seoultotal 
	FROM txtrivalenter 
	WHERE year=year(getdate())-1


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

