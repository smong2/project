SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/* =====================================================================
	���α׷�ID : SXWTEnterRivalMonthI
	��  ��  �� : ���俹��
	���α׷��� : ���尴 �����- ��� -���Է�
	�����ۼ��� : 2002/11/14
	�����ۼ��� : 2002/11/14
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */

CREATE PROCEDURE dbo.SXWTEnterRivalMonthI
	@vcInput_year varchar(12)
	,@vcInput_month varchar(5)
	,@intIndivadultever int
	,@intIndivadultseoul int
	,@intGroupadultever int
	,@intGroupadultseoul int
	,@intIndivschoolever int
	,@intIndivschoolseoul int
	,@intGroupschoolever int
	,@intGroupschoolseoul int
	,@intIndivchildever int
	,@intIndivchildseoul int
	,@intGroupchildever int
	,@intGroupchildseoul int

AS
	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnteRivalMonthI:'	-- ���� ���� �ʱ�ȭ

BEGIN

DELETE FROM dbo.txtrivalenter 
WHERE year=@vcInput_year and month=@vcInput_month   --�����Ѵ�
 
--�Է� ��
INSERT INTO dbo.txtrivalenter 
(year,month,class, everindiv,everorg,seoulindiv,seoulorg) 
VALUES (@vcInput_year,@vcInput_month,'A',@intIndivadultever,@intGroupadultever,@intIndivadultseoul,@intGroupadultseoul)  --� �Է�

INSERT INTO dbo.txtrivalenter 
(year,month,class, everindiv,everorg,seoulindiv,seoulorg) 
VALUES (@vcInput_year,@vcInput_month,'C',@intIndivchildever,@intGroupchildever,@intIndivchildseoul,@intGroupchildseoul)  --��� �Է�

INSERT INTO dbo.txtrivalenter 
(year,month,class, everindiv,everorg,seoulindiv,seoulorg) 
VALUES (@vcInput_year,@vcInput_month,'S',@intIndivschoolever,@intGroupschoolever,@intIndivschoolseoul,@intGroupschoolseoul)  --�߰�� �Է�

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

