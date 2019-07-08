SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




/* =====================================================================
	���α׷�ID : SXWTEnterDayQ
	��  ��  �� : ���俹��
	���α׷��� : ���尴 ����- ǥ�� (�Ͽ��� )
	�����ۼ��� : 2002/11/11
	�����ۼ��� : 2002/11/11
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */


CREATE    PROCEDURE dbo.SXWTEnterDayQ
    @vcModelType varchar(10)  	 --��ǥ ���� / ������ ����
    ,@vcEnterType varchar(10)	 --����,��ü,��ü ����
    ,@vcLastdate datetime
    ,@vcLastweekdate datetime
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterDayQ:'	-- ���� ���� �ʱ�ȭ

IF @vcModelType='vxt' and @vcEnterType='group' --��ǥ, ��ü
BEGIN
	SELECT orgadult+orgschool+orgchild as orgtotal   --����ġ ��������
	,orgadult
	,orgschool
	,orgchild
	FROM dbo.vxtday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT grouptotal,   -- ����ġ ���� ���� �������� 3��
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastdate and xdate<=@vcLastdate+2 

	SELECT grouptotal,  --����ġ ���� ������ �������� 3��
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastweekdate and xdate<=@vcLastweekdate+2

	SELECT sum(orgadult+orgschool+orgchild) as orgtotal,  --����ġ �հ�
	sum(orgadult) as orgadult,  
	sum(orgschool) as orgschool,
	sum(orgchild) as orgchild  
	FROM dbo.vxtday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT sum(grouptotal) as grouptotal,  --����ġ ���� ���� �հ�
	sum(groupadult) as adult, 
	sum(groupschool) as school, 
	sum(groupchild) as child 
	FROM dbo.vxthistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastdate) and xdate<=@vcLastdate
	
	SELECT sum(grouptotal) as grouptotal,  --����ġ ���� ������ �հ�
	sum(groupadult) as adult, 
	sum(groupschool) as school, 
	sum(groupchild) as child 
	FROM dbo.vxthistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastweekdate) and xdate<=@vcLastweekdate
END
IF @vcModelType='vxt' and  @vcEnterType='indiv'  --��ǥ, ����
 BEGIN
	SELECT indivadult
	,indivschool
	,indivchild
	,indivadult+indivschool+indivchild as indivtotal   --����ġ ��������
	FROM dbo.vxtday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT indivtotal,   -- ����ġ ���� ���� �������� 3��ġ
	indivadult, 
	indivschool, 
	indivchild 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastdate and xdate<=@vcLastdate+2

	SELECT indivtotal,  --����ġ ���� ������ �������� 3��ġ
	indivadult, 
	indivschool, 
	indivchild 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastweekdate  and xdate<=@vcLastweekdate+2

	SELECT sum(indivadult+indivschool+indivchild) as indivtotal,
	sum(indivadult) as indivadult,  --����ġ �հ�
	sum(indivschool) as indivschool,
	sum(indivchild) as indivchild  
	FROM dbo.vxtday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT sum(indivtotal) as total, --����ġ ���� ���� �հ�
	sum(indivadult) as adult, 
	sum(indivschool) as school, 
	sum(indivchild) as child 
	FROM dbo.vxthistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastdate) and xdate<=@vcLastdate

	SELECT sum(indivtotal) as total,  -- ����ġ ���� ������ �հ�
	sum(indivadult) as adult, 
	sum(indivschool) as school, 
	sum(indivchild) as child 
	FROM dbo.vxthistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastweekdate) and xdate<=@vcLastweekdate
 END

IF @vcModelType='vxt' and @vcEnterType='total'  --��ǥ, ��ü
 BEGIN 
	SELECT indivadult+indivschool+indivchild+isnull(orgadult+orgschool+orgchild,0) as total, --����ġ �������� 
	indivadult+isnull(orgadult,0) as adult, 
	indivschool+isnull(orgschool,0) as school, 
	indivchild+isnull(orgchild,0) as child    
	FROM dbo.vxtday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT indivtotal+grouptotal as total,  --����ġ ���� ���� �������� 3��ġ
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastdate and xdate<=@vcLastdate+2

	SELECT indivtotal+grouptotal as total,  --����ġ ���� ������ �������� 3��ġ
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxthistoryday 
	WHERE xdate>=@vcLastweekdate  and xdate<=@vcLastweekdate+2

	SELECT sum(indivadult+indivschool+indivchild+isnull(orgadult+orgschool+orgchild,0)) as total, --����ġ �հ� �������� 
	sum(indivadult+isnull(orgadult,0)) as adult, 
	sum(indivschool+isnull(orgschool,0)) as school, 
	sum(indivchild+isnull(orgchild,0)) as child    
	FROM dbo.vxtday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT sum(indivtotal+grouptotal) as total,  --����ġ ���� ���� �հ�
	sum(indivadult+groupadult) as adult, 
	sum(indivschool+groupschool) as school, 
	sum(indivchild+groupchild) as child 
	FROM dbo.vxthistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastdate) and xdate<=@vcLastdate

	SELECT sum(indivtotal+grouptotal) as total,  --����ġ ���� ������ �հ�
	sum(indivadult+groupadult) as adult, 
	sum(indivschool+groupschool) as school, 
	sum(indivchild+groupchild) as child 
	FROM dbo.vxthistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastweekdate) and xdate<=@vcLastweekdate
 END

 IF @vcModelType='vxte' and @vcEnterType='group'  --��, ��ü
 BEGIN
	SELECT orgadult+orgschool+orgchild as orgtotal   --����ġ ��������
	,orgadult
	,orgschool
	,orgchild
	FROM dbo.vxteday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT grouptotal,   -- ����ġ ���� ���� �������� 3��
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastdate and xdate<=@vcLastdate+2 

	SELECT grouptotal,  --����ġ ���� ������ �������� 3��
	groupadult, 
	groupschool, 
	groupchild 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastweekdate and xdate<=@vcLastweekdate+2

	SELECT sum(orgadult+orgschool+orgchild) as orgtotal,
	sum(orgadult) as orgadult,  --����ġ �հ�
	sum(orgschool) as orgschool,
	sum(orgchild) as orgchild  
	FROM dbo.vxteday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT sum(grouptotal) as grouptotal,  --����ġ ���� ���� �հ�
	sum(groupadult) as adult, 
	sum(groupschool) as school, 
	sum(groupchild) as child 
	FROM dbo.vxtehistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastdate) and xdate<=@vcLastdate
	
	SELECT sum(grouptotal) as grouptotal,  --����ġ ���� ������ �հ�
	sum(groupadult) as adult, 
	sum(groupschool) as school, 
	sum(groupchild) as child 
	FROM dbo.vxtehistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastweekdate) and xdate<=@vcLastweekdate 
END

 IF @vcModelType='vxte' and @vcEnterType='indiv'   --��,����
 BEGIN
	SELECT indivadult+indivschool+indivchild as indivtotal  --����ġ ��������
	,indivadult
	,indivschool
	,indivchild
	FROM dbo.vxteday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT indivtotal,   -- ����ġ ���� ���� �������� 3��ġ
	indivadult, 
	indivschool, 
	indivchild 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastdate and xdate<=@vcLastdate+2

	SELECT indivtotal,  --����ġ ���� ������ �������� 3��ġ
	indivadult, 
	indivschool, 
	indivchild 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastweekdate  and xdate<=@vcLastweekdate+2

	SELECT sum(indivadult+indivschool+indivchild) as indivtotal,
	sum(indivadult) as indivadult,  --����ġ �հ�
	sum(indivschool) as indivschool,
	sum(indivchild) as indivchild  
	FROM dbo.vxteday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT sum(indivtotal) as total, --����ġ ���� ���� �հ�
	sum(indivadult) as adult, 
	sum(indivschool) as school, 
	sum(indivchild) as child 
	FROM dbo.vxtehistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastdate) and xdate<=@vcLastdate

	SELECT sum(indivtotal) as total,  -- ����ġ ���� ������ �հ�
	sum(indivadult) as adult, 
	sum(indivschool) as school, 
	sum(indivchild) as child 
	FROM dbo.vxtehistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastweekdate) and xdate<=@vcLastweekdate 
END

 IF @vcModelType='vxte' and  @vcEnterType='total'   --��,��ü
 BEGIN 
	SELECT indivadult+indivschool+indivchild+isnull(orgadult+orgschool+orgchild,0) as total, --����ġ �������� 
	indivadult+isnull(orgadult,0) as adult, 
	indivschool+isnull(orgschool,0) as school, 
	indivchild+isnull(orgchild,0) as child    
	FROM dbo.vxteday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT indivtotal+grouptotal as total,  --����ġ ���� ���� �������� 3��ġ
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastdate and xdate<=@vcLastdate+2

	SELECT indivtotal+grouptotal as total,  --����ġ ���� ������ �������� 3��ġ
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child 
	FROM dbo.vxtehistoryday 
	WHERE xdate>=@vcLastweekdate  and xdate<=@vcLastweekdate+2

	SELECT sum(indivadult+indivschool+indivchild+isnull(orgadult+orgschool+orgchild,0)) as total, --����ġ �հ� �������� 
	sum(indivadult+isnull(orgadult,0)) as adult, 
	sum(indivschool+isnull(orgschool,0)) as school, 
	sum(indivchild+isnull(orgchild,0)) as child    
	FROM dbo.vxteday
	WHERE YEAR>= year(dateadd(yy,-1,getdate())) and MONTH>=month(dateadd(yy,-1,getdate())) and DAY>=day(dateadd(yy,-1,getdate())) and year<=year(dateadd(dd,2,dateadd(yy,-1,getdate()))) and month<=month(dateadd(dd,2,dateadd(yy,-1,getdate()))) and day<=day(dateadd(dd,2,dateadd(yy,-1,getdate())))

	SELECT sum(indivtotal+grouptotal) as total,  --����ġ ���� ���� �հ�
	sum(indivadult+groupadult) as adult, 
	sum(indivschool+groupschool) as school, 
	sum(indivchild+groupchild) as child 
	FROM dbo.vxtehistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastdate) and xdate<=@vcLastdate

	SELECT sum(indivtotal+grouptotal) as total,  --����ġ ���� ������ �հ�
	sum(indivadult+groupadult) as adult, 
	sum(indivschool+groupschool) as school, 
	sum(indivchild+groupchild) as child 
	FROM dbo.vxethistoryday 
	WHERE year=year(getdate())-1 and month=month(@vcLastweekdate) and xdate<=@vcLastweekdate
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

