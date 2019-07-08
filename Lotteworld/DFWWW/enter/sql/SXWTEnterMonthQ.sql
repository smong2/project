SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO





/* =====================================================================
	���α׷�ID : SXWTEnterMonthQ
	��  ��  �� : ���俹��
	���α׷��� : ���尴 ����- ǥ�� (������ )
	�����ۼ��� : 2002/11/11
	�����ۼ��� : 2002/11/11
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */


CREATE    PROCEDURE dbo.SXWTEnterMonthQ
    @vcModelType varchar(10)  	 --��ǥ ���� / ������ ����
    ,@vcEnterType varchar(10)	 --����,��ü,��ü ����
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterMonthQ:'	-- ���� ���� �ʱ�ȭ

IF @vcModelType='vxt' and @vcEnterType='group' --��ǥ, ��ü
BEGIN
	SELECT  year, -- ����ġ �������� 3��
	month,
	grouptotal,
	groupadult,
	groupschool,
	groupchild 
	FROM dbo.vxtmonth 
              WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  (year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or (year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate())))

	SELECT grouptotal, -- ����ġ �������� 3��
	groupadult,
	groupschool,
	groupchild 
	FROM dbo.vxthistorymonth 
	WHERE (year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or  (year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or (year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT sum(grouptotal) as grouptotal,  --����ġ �հ�
              sum(groupadult) as groupadult, 
              sum(groupschool) as groupschool,
	sum(groupchild) as groupchild  
	FROM dbo.vxtmonth 
	WHERE year=year(getdate())

	SELECT sum(grouptotal) as grouptotal,  --����ġ �հ�
	sum(groupadult) as groupadult, 
	sum(groupschool) as groupschool,
	sum(groupchild) as groupchild  
	FROM vxthistorymonth 
	WHERE year=year(getdate())-1
END

IF @vcModelType='vxt' and  @vcEnterType='indiv'  --��ǥ, ����
 BEGIN
	SELECT year,  --����ġ �������� 3��
	month,
	indivtotal,
	indivadult,
	indivschool,
	indivchild  
	FROM dbo.vxtmonth 
	WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  (year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or (year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate())))

	SELECT indivtotal,  --����ġ �������� 3��
	indivadult,
	indivschool,
	indivchild
	FROM dbo.vxthistorymonth 
	WHERE (year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or  (year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or (year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT sum(indivtotal) as indivtotal,  --����ġ �հ�
	sum(indivadult) as indivadult, 
	sum(indivschool) as indivschool,
	sum(indivchild) as indivchild  
	FROM dbo.vxtmonth 
	WHERE year=year(getdate())

	SELECT sum(indivtotal) as indivtotal,  --����ġ �հ�
	sum(indivadult) as indivadult, 
	sum(indivschool) as indivschool,
	sum(indivchild) as indivchild   
	FROM dbo.vxthistorymonth 
	WHERE year=year(getdate())-1
 END

IF @vcModelType='vxt' and @vcEnterType='total'  --��ǥ, ��ü
 BEGIN 
	SELECT year, --����ġ �������� 3��
	month,
	indivtotal+grouptotal as total, 
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxtmonth 
	WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  (year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or (year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate())))

	SELECT indivtotal+grouptotal as total,  --����ġ �������� 3��
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxthistorymonth 
	WHERE (year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or  (year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or (year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT sum(indivtotal+grouptotal) as total,  --����ġ �հ�
	sum(indivadult+groupadult) as adult, 
	sum(indivschool+groupschool) as school, 
	sum(indivchild+groupchild) as child  
	FROM dbo.vxtmonth 
	WHERE year=year(getdate())

	SELECT sum(indivtotal+grouptotal) as total,  --����ġ �հ�
	sum(indivadult+groupadult) as adult, 
	sum(indivschool+groupschool) as school, 
	sum(indivchild+groupchild) as child   
	FROM dbo.vxthistorymonth 
	WHERE year=year(getdate())-1
 END

 IF @vcModelType='vxte' and @vcEnterType='group'  --��, ��ü
 BEGIN

	SELECT year, --����ġ �������� 3��
	month,
	grouptotal,
	groupadult,
	groupschool,
	groupchild 
	FROM dbo.vxtemonth 
	WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  (year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or (year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate())))

	SELECT grouptotal,  --����ġ �������� 3��
	groupadult,
	groupschool,
	groupchild
	FROM dbo.vxtehistorymonth 
	WHERE (year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or  (year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or (year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT sum(grouptotal) as grouptotal,  -- ����ġ �հ�
	sum(groupadult) as groupadult, 
	sum(groupschool) as groupschool,
	sum(groupchild) as groupchild 
	FROM dbo.vxtemonth 
	WHERE year=year(getdate())

	SELECT sum(grouptotal) as grouptotal,  --����ġ �հ�
	sum(groupadult) as groupadult, 
	sum(groupschool) as groupschool,
	sum(groupchild) as groupchild 
	FROM dbo.vxtehistorymonth 
	WHERE year=year(getdate())-1
 END

 IF @vcModelType='vxte' and @vcEnterType='indiv'   --��,����
 BEGIN
	SELECT year,   --����ġ �������� 3��
	month,
	indivtotal,
	indivadult,
	indivschool,
	indivchild
	FROM dbo.vxtemonth 
	WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  (year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or (year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate())))

	SELECT indivtotal,  --����ġ �������� 3��
	indivadult,
	indivschool,
	indivchild
	FROM dbo.vxtehistorymonth 
	WHERE (year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or  (year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or (year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT sum(indivtotal) as indivtotal,  --����ġ �հ�
	sum(indivadult) as indivadult, 
	sum(indivschool) as indivschool,
	sum(indivchild) as indivchild  
	FROM dbo.vxtemonth 
	WHERE year=year(getdate())

	SELECT sum(indivtotal) as indivtotal,  --����ġ �հ�
	sum(indivadult) as indivadult, 
	sum(indivschool) as indivschool,
	sum(indivchild) as indivchild  
	FROM dbo.vxtehistorymonth 
	WHERE year=year(getdate())-1
 END

 IF @vcModelType='vxte' and  @vcEnterType='total'   --��,��ü
 BEGIN 
	SELECT year,  --����ġ �������� 3��
	month,
	indivtotal+grouptotal as total,
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxtemonth 	
	WHERE (year=year(dateadd(mm,  0, getdate())) and month=month(dateadd(mm,  0, getdate()))) or  (year=year(dateadd(mm,  1, getdate())) and month=month(dateadd(mm,  1, getdate()))) or (year=year(dateadd(mm,  2, getdate())) and month=month(dateadd(mm,  2, getdate())))

	SELECT indivtotal+grouptotal as total, --����ġ �������� 3��
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxtehistorymonth 
	WHERE (year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or  (year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or (year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT sum(indivtotal+grouptotal) as total,  --����ġ �հ�
	sum(indivadult+groupadult) as adult, 
	sum(indivschool+groupschool) as school, 
	sum(indivchild+groupchild) as child 
	FROM dbo.vxtemonth 
	WHERE year=year(getdate())

	SELECT sum(indivtotal+grouptotal) as total,  --����ġ �հ�
	sum(indivadult+groupadult) as adult, 
	sum(indivschool+groupschool) as school, 
	sum(indivchild+groupchild) as child   
	FROM dbo.vxtehistorymonth 
	WHERE year=year(getdate())-1
 END


	IF @@ERROR <> 0
	BEGIN
		SET @vcError = @vcSpname + '���� ����' + '�𵨸� : ' + @vcModelType + '���и�:' + @vcEnterType
--Error �߻� �� log ���
		EXEC dbo.SXBWriteLogI 'X.dbo.SP', @vcError
	END		  
END 





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

