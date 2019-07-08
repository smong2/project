SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



/* =====================================================================
	���α׷�ID : SXWTEnterDayExcelQ
	��  ��  �� : ���俹��
	���α׷��� : ���尴 �� ���� - ���� ǥ��
	�����ۼ��� : 2002/11/12
	�����ۼ��� : 2002/11/12
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */


CREATE   PROCEDURE dbo.SXWTEnterDayExcelQ
@vcModelType varchar(10)
,@vcEnterType varchar(10)
,@vcLastdate datetime
,@vcLastweekdate datetime
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterDayExcelQ:'	-- ���� ���� �ʱ�ȭ


IF @vcModelType='vxt' and @vcEnterType='group' --��ǥ, ��ü
BEGIN

	SELECT xdate,  --���� ���� ����
	grouptotal, 
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastdate-60 and xdate<=@vcLastdate+2
              ORDER BY xdate

	SELECT xdate,  --���� ������ ����
	grouptotal, 
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastweekdate-60  and xdate<=@vcLastweekdate+2
              ORDER BY xdate

END
IF @vcModelType='vxt' and @vcEnterType='indiv' --��ǥ, ����
BEGIN
	SELECT xdate,   --���� ���� ����
	indivtotal, 
	indivadult, 
	indivschool, 
	indivchild 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastdate-60 and xdate<=@vcLastdate+2
              ORDER BY xdate

	SELECT xdate,  --���� ������ ����
	indivtotal, 
	indivadult, 
	indivschool, 
	indivchild 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastweekdate-60 and xdate<=@vcLastweekdate+2
              ORDER BY xdate

END
IF @vcModelType='vxt' and @vcEnterType='total' --��ǥ, ����
BEGIN
	SELECT xdate,  --���� ���� ����
	indivtotal+grouptotal as total, 
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastdate-60 and xdate<=@vcLastdate+2
              ORDER BY xdate

	SELECT indivtotal+grouptotal as total,  --���� ������ ����
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastweekdate-60  and xdate<=@vcLastweekdate+2
              ORDER BY xdate

END
IF @vcModelType='vxte' and @vcEnterType='group' --��ǥ, ��ü
BEGIN

	SELECT xdate,  --���� ���� ����
	grouptotal, 
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastdate-60 and xdate<=@vcLastdate+2
              ORDER BY xdate

	SELECT  --���� ������ ����
	xdate,
	grouptotal, 
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastweekdate-60  and xdate<=@vcLastweekdate+2
              ORDER BY xdate

END
IF @vcModelType='vxte' and @vcEnterType='indiv' --��ǥ, ����
BEGIN
	SELECT xdate,  --���� ���� ����
	indivtotal, 
	indivadult, 
	indivschool, 
	indivchild 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastdate-60 and xdate<=@vcLastdate+2
              ORDER BY xdate

	SELECT  xdate,--���� ������ ����
	indivtotal, 
	indivadult, 
	indivschool, 
	indivchild 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastweekdate-60  and xdate<=@vcLastweekdate+2
              ORDER BY xdate

END
IF @vcModelType='vxte' and @vcEnterType='total' --��ǥ, ����
BEGIN
	SELECT xdate,  --���� ���� ����
	indivtotal+grouptotal as total, 
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastdate-60 and xdate<=@vcLastdate+2
              ORDER BY xdate

	SELECT indivtotal+grouptotal as total,  --���� ������ ����
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastweekdate-60  and xdate<=@vcLastweekdate+2
              ORDER BY xdate
END



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

