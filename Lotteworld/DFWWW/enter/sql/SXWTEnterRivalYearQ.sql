SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



/* =====================================================================
	���α׷�ID : SXWTEnterRivalYearQ
	��  ��  �� : ���俹��
	���α׷��� : ����� ����- ǥ�� (�� )
	�����ۼ��� : 2002/11/11
	�����ۼ��� : 2002/11/11
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */


CREATE    PROCEDURE dbo.SXWTEnterRivalYearQ
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterRivalYearQ:'	-- ���� ���� �ʱ�ȭ

	SELECT year, --������ ��������
              evertotal,
	seoultotal
	FROM dbo.txtrivalyear 

	SELECT year,  --���� ���Ž��� 
	sum(everindiv+everorg) as evertotal, 
	sum(seoulindiv+seoulorg) as seoultotal 
	FROM dbo.txtrivalenter 
              WHERE year=year(getdate())-1
	GROUP BY year 

	SELECT sum(evertotal) as evertotal,  --������ ����
	sum(seoultotal) as seoultotal 
	FROM dbo.txtrivalyear 
	WHERE year=year(getdate()) or year=year(getdate())+1
	
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

