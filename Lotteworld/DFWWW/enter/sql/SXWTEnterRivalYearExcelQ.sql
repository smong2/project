SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



/* =====================================================================
	���α׷�ID : SXWTEnterRivalYearExcelQ
	��  ��  �� : ���俹��
	���α׷��� : ����� ���� ��-  ���� ���
	�����ۼ��� : 2002/11/11
	�����ۼ��� : 2002/11/11
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */

CREATE    PROCEDURE dbo.SXWTEnterRivalYearExcelQ
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterRivalYearExcelQ:'	-- ���� ���� �ʱ�ȭ

	SELECT year,  --������
	evertotal,
	seoultotal
	FROM dbo.txtrivalyear

	SELECT year, --���� ���� ����
	sum(everindiv+everorg) as evertotal, 
	sum(seoulindiv+seoulorg) as seoultotal 
	FROM dbo.txtrivalenter 
	WHERE year=year(getdate()) or
	year=year(getdate())-1 or
	year=year(getdate())-2 or
	year=year(getdate())-3 or
	year=year(getdate())-4
	GROUP BY year 
	ORDER BY year

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

