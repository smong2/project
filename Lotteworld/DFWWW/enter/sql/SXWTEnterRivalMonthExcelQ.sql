SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/* =====================================================================
	���α׷�ID : SXWTEnterRivalMonthExcelQ
	��  ��  �� : ���俹��
	���α׷��� : ����� ���� ��-  ���� ���
	�����ۼ��� : 2002/11/11
	�����ۼ��� : 2002/11/11
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */


CREATE  PROCEDURE dbo.SXWTEnterRivalMonthExcelQ
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterRivalMonthExcelQ:'	-- ���� ���� �ʱ�ȭ

	SELECT year, --����� �� ����
	month,
	evertotal,
	seoultotal
	FROM  dbo.txtrivalmonth 
	WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  
	(year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or 
	(year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate()))) or 
	(year=year(dateadd(mm,  -1, getdate())) and month=month(dateadd(mm,  -1, getdate()))) or 
	(year=year(dateadd(mm,  -2, getdate())) and month=month(dateadd(mm,  -2, getdate()))) or 
	(year=year(dateadd(mm,  -3, getdate())) and month=month(dateadd(mm,  -3, getdate()))) or 
	(year=year(dateadd(mm,  -4, getdate())) and month=month(dateadd(mm, -4, getdate()))) or 
	(year=year(dateadd(mm,  -5, getdate())) and month=month(dateadd(mm,  -5, getdate()))) or 
	(year=year(dateadd(mm,  -6, getdate())) and month=month(dateadd(mm,  -6, getdate()))) or 
	(year=year(dateadd(mm,  -7, getdate())) and month=month(dateadd(mm,  -7, getdate()))) or 
	(year=year(dateadd(mm,  -8, getdate())) and month=month(dateadd(mm,  -8, getdate()))) or 
	(year=year(dateadd(mm,  -9, getdate())) and month=month(dateadd(mm,  -9, getdate()))) or
	(year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT year, --���Ž���
	month,
	sum(everindiv+everorg) as evertotal, 
	sum(seoulindiv+seoulorg) as seoultotal 
	FROM dbo.txtrivalenter 
	WHERE (year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or  
	(year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or 
	(year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate()))) or 
	(year=year(dateadd(mm,  -13, getdate())) and month=month(dateadd(mm,  -13, getdate()))) or 
	(year=year(dateadd(mm,  -14, getdate())) and month=month(dateadd(mm,  -14, getdate()))) or 
	(year=year(dateadd(mm,  -15, getdate())) and month=month(dateadd(mm,  -15, getdate()))) or 
	(year=year(dateadd(mm,  -16, getdate())) and month=month(dateadd(mm,  -16, getdate()))) or 
	(year=year(dateadd(mm,  -17, getdate())) and month=month(dateadd(mm,  -17, getdate()))) or 
	(year=year(dateadd(mm,  -18, getdate())) and month=month(dateadd(mm,  -18, getdate()))) or 
	(year=year(dateadd(mm,  -19, getdate())) and month=month(dateadd(mm,  -19, getdate()))) or 
	(year=year(dateadd(mm,  -20, getdate())) and month=month(dateadd(mm,  -20, getdate()))) or 
	(year=year(dateadd(mm,  -21, getdate())) and month=month(dateadd(mm,  -21, getdate()))) or
	(year=year(dateadd(mm,  -22, getdate())) and month=month(dateadd(mm,  -22, getdate()))) 
	GROUP BY year,month

	IF @@ERROR <> 0
	BEGIN
		SET @vcError = @vcSpname + '���� ����'
	END		  

--Error �߻� �� log ���
		EXEC dbo.SXBWriteLogI 'X.dbo.SP', @vcError

END 


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

