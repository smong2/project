SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




/* =====================================================================
	���α׷�ID : SXWTTodayMainQ
	��  ��  �� : ���俹��
	���α׷��� : Today Main - ǥ��
	�����ۼ��� : 2002/11/11
	�����ۼ��� : 2002/11/11
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */


CREATE   PROCEDURE dbo.SXWTTodayMainQ
@vcLastdate datetime
,@vcLastweekdate datetime
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTTodayMainQ:'	-- ���� ���� �ʱ�ȭ

	SELECT indivadult+indivschool+indivchild+isnull(orgadult+orgschool+orgchild,0) as total, --������
	indivadult+indivschool+indivchild as indivtotal,
	indivadult,
	indivschool,
	indivchild,
	orgadult+orgschool+orgchild as orgtotal,
	orgadult,
	orgschool,
	orgchild
	FROM dbo.vxtday

	SELECT indivadult+indivschool+indivchild+isnull(orgadult+orgschool+orgchild,0) as total, --������ ������
	indivadult+indivschool+indivchild as indivtotal,
	indivadult,
	indivschool,
	indivchild,
	orgadult+orgschool+orgchild as orgtotal,
	orgadult,
	orgschool,
	orgchild
	FROM dbo.vxteday

	SELECT xdate,  --���� ���� ����
	indivtotal+grouptotal as total,
	indivtotal, 
	indivadult, 
	indivschool, 
	indivchild,
	grouptotal, 
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxthistoryday 
	WHERE xdate=@vcLastdate

	SELECT xdate,  --���� ���� ���� ������
	indivtotal+grouptotal as total,
	indivtotal, 
	indivadult, 
	indivschool, 
	indivchild,
	grouptotal, 
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxtehistoryday 
	WHERE xdate=@vcLastdate

	SELECT xdate,	--���� ������ ����
	indivtotal+grouptotal as total,
	indivtotal, 
	indivadult, 
	indivschool, 
	indivchild,
	grouptotal, 
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxthistoryday 
	WHERE xdate=@vcLastweekdate

	SELECT xdate,	--���� ������ ���� ������
	indivtotal+grouptotal as total,
	indivtotal, 
	indivadult, 
	indivschool, 
	indivchild,
	grouptotal, 
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxtehistoryday 
	WHERE xdate=@vcLastweekdate

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

