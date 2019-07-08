SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/* =====================================================================
	���α׷�ID : SXWTEnterYearQ
	��  ��  �� : ���俹��
	���α׷��� : ���尴 ����- ǥ�� (������ )
	�����ۼ��� : 2002/11/11
	�����ۼ��� : 2002/11/11
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */
CREATE  PROCEDURE dbo.SXWTEnterYearQ
    @vcModelType varchar(10)  	 --��ǥ ���� / ������ ����
    ,@vcEnterType varchar(10)	 --����,��ü,��ü ����
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterYearQ:'	-- ���� ���� �ʱ�ȭ

IF @vcModelType='vxt' and @vcEnterType='group' --��ǥ, ��ü
BEGIN
	SELECT  year,  	--����ġ �������� 2��
	groupadult,    
	groupschool, 
	groupchild, 
	grouptotal 
	FROM  dbo.vxtyear 
	WHERE year<=year(getdate())+1  and year >=year(getdate()) 
	ORDER BY year

	SELECT  year,	--����ġ ��������  1��
	groupadult,   	
	groupschool, 
	groupchild, 
	grouptotal 
	FROM  dbo.vxthistoryyear 
	WHERE year=year(getdate())-1
END

IF @vcModelType='vxt' and  @vcEnterType='indiv'  --��ǥ, ����
 BEGIN
	SELECT year,	--����ġ �������� 2��
	indivadult,     
	indivschool, 
	indivchild, 
	indivtotal 
	FROM dbo.vxtyear 
	WHERE year<=year(getdate())+1  and year >=year(getdate()) 
	ORDER BY year

	SELECT year,	--����ġ ��������  1��
	indivadult,  	
	indivschool, 
	indivchild, 
	indivtotal 
	FROM dbo.vxthistoryyear 
	WHERE year=year(getdate())-1
 END

IF @vcModelType='vxt' and @vcEnterType='total'  --��ǥ, ��ü
 BEGIN 
	SELECT 	year,	  --����ġ �������� 2��
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child, 
	(indivtotal+grouptotal) as total 
	FROM dbo.vxtyear 
	WHERE year<=year(getdate())+1  and year >=year(getdate()) 
	ORDER BY year

	SELECT year, 		--����ġ ��������  1��
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child, 
	(indivtotal+grouptotal) as total 
	FROM dbo.vxthistoryyear 
	WHERE year=year(getdate())-1
 END

 IF @vcModelType='vxte' and @vcEnterType='group'  --��, ��ü
 BEGIN

	SELECT year,   		 --����ġ �������� 2��
	groupadult, 
	groupschool, 
	groupchild, 
	grouptotal 
	FROM dbo.vxteyear 
	WHERE year<=year(getdate())+1  and year >=year(getdate()) 
	ORDER BY year

	SELECT year,		--����ġ ��������  1��
	groupadult, 
	groupschool, 
	groupchild, 
	grouptotal 
	FROM dbo.vxtehistoryyear 
	WHERE year=year(getdate())-1
 END

 IF @vcModelType='vxte' and @vcEnterType='indiv'   --��,����
 BEGIN
	SELECT year,    	--����ġ �������� 2��
	indivadult, 
	indivschool, 
	indivchild, 
	indivtotal 
	FROM dbo.vxteyear 
	WHERE year<=year(getdate())+1  and year >=year(getdate()) ORDER BY year

	SELECT  year, 		--����ġ ��������  1��
	indivadult, 
	indivschool, 
	indivchild, 
	indivtotal 
	FROM dbo.vxtehistoryyear 
	WHERE year=year(getdate())-1
 END

 IF @vcModelType='vxte' and  @vcEnterType='total'   --��,��ü
 BEGIN 
	SELECT  year,  		--����ġ �������� 2��
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child, 
	(indivtotal+grouptotal) as total 
	FROM dbo.vxteyear 
	WHERE year<=year(getdate())+1  and year >=year(getdate()) ORDER BY year

	SELECT  year,		--����ġ ��������  1��
	indivadult+groupadult as adult, 
	indivschool+groupschool as school, 
	indivchild+groupchild as child, 
	(indivtotal+grouptotal) as total 
	FROM dbo.vxtehistoryyear 
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

