SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO





/* =====================================================================
	���α׷�ID : SXWTEnterPlanI
	��  ��  �� : ���俹��
	���α׷��� : ���尴 ��ȹ - ���
	�����ۼ��� : 2002/11/14
	�����ۼ��� : 2002/11/14
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */

CREATE     PROCEDURE dbo.SXWTEnterPlanI
	@vcEnterType varchar(10)
	,@vcModelType varchar(15)
	,@vcInput_Year varchar(10)
	,@vcInput_Month varchar(10)
	,@vcInput_Day varchar(10)
	,@intSpecial int
	,@intFree int
	,@intEducinst int
	,@intDutyfree int
	,@intCompany int
	,@intMycustomer int
	,@intEtc int
	,@vcClass varchar(5)=' '

AS
	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnterPlanI:'	-- ���� ���� �ʱ�ȭ

BEGIN

 IF @vcEnterType='vxt' --��ǥ ������ ���
 BEGIN
	IF @vcModelType='model_year' --�� �Է��� �������� ��� 
 	 BEGIN
		DELETE FROM dbo.txtenterplan   --��ġ�� �ڷ�� �����ϰ�
		WHERE 	class=@vcClass and 
			year=@vcInput_Year and 
			month is null and 
			day is null
	
		INSERT INTO dbo.txtenterplan  --�ڷ� �߰�
		(year,class,special,free,educinst,dutyfree, company, mycustomer,etc) 
		VALUES (@vcInput_Year,@vcClass,@intSpecial,@intFree,@intEducinst,@intDutyfree,@intCompany,@intMycustomer,@intEtc)
	 END
  
	IF @vcModelType='model_month' --�� �Է��� �������� ���
	 BEGIN
		DELETE FROM dbo.txtenterplan   --��ġ�� �ڷ�� �����ϰ� 
		WHERE 	class=@vcClass and 
			year=@vcInput_Year and 
			Month=@vcInput_Month and 
			day is null
		
		INSERT INTO dbo.txtenterplan  --�ڷ� �߰� 
		(year,month,class,special,free,educinst,dutyfree, company, mycustomer,etc) 
		VALUES (@vcInput_Year,@vcInput_Month,@vcClass,@intSpecial,@intFree,@intEducinst,@intDutyfree,@intCompany,@intMycustomer,@intEtc)
	 END
 
	IF @vcModelType='model_day'  --�� �Է��� �������� ���
	 BEGIN
		DELETE FROM dbo.txtenterplan   --��ġ�� �ڷ�� �����ϰ� 
		WHERE 	class=@vcClass and 
			year=@vcInput_Year and 
			Month=@vcInput_Month and 
			day=@vcInput_Day

		INSERT INTO dbo.txtenterplan  --�ڷ� �߰� 
		(year,month,day,class,special,free,educinst,dutyfree, company, mycustomer,etc) 
		VALUES (@vcInput_Year,@vcInput_Month,@vcInput_Day,@vcClass,@intSpecial,@intFree,@intEducinst,@intDutyfree,@intCompany,@intMycustomer,@intEtc)
	 END

 END

IF  @vcEnterType='vxte'  --�������� ���
BEGIN
	IF @vcModelType='model_year'
 	 BEGIN
		  DELETE FROM dbo.txteenterplan    --���� ���� ������ �����
		  WHERE year=@vcInput_Year AND
			month is null AND
			day is null
  
		  INSERT INTO dbo.txteenterplan      --�� ������ ����Ѵ�
		  (year,special,free,educinst,dutyfree, company, mycustomer,etc) 
		  VALUES (@vcInput_Year,@intSpecial,@intFree,@intEducinst,@intDutyfree,@intCompany,@intMycustomer,@intEtc)
	  END
  
	 IF @vcModelType='model_month'
	  BEGIN
		  DELETE FROM dbo.txteenterplan   --���� ���� ������ �����
		  WHERE year=@vcInput_Year and 
			Month=@vcInput_Month and 
			day is null
  
  		  INSERT INTO dbo.txteenterplan     --�� ������ ����Ѵ�
		  (year,month,special,free,educinst,dutyfree, company, mycustomer,etc) 
		  VALUES (@vcInput_Year,@vcInput_Month,@intSpecial,@intFree,@intEducinst,@intDutyfree,@intCompany,@intMycustomer,@intEtc)
	  END  
 
 	IF @vcModelType='model_day'
	  BEGIN
		  DELETE FROM dbo.txteenterplan   --���� ���� ������ �����
		  WHERE year=@vcInput_Year and 
		  month=@vcInput_Month and 
		  day=@vcInput_Day
  
		  INSERT INTO dbo.txteenterplan    --�� ������ ����Ѵ�
		  (year,month,day,special,free,educinst,dutyfree, company, mycustomer,etc) 
		  VALUES (@vcInput_Year,@vcInput_Month,@vcInput_Day,@intSpecial,@intFree,@intEducinst,@intDutyfree,@intCompany,@intMycustomer,@intEtc)
	  END
END

	IF @@ERROR <> 0
	BEGIN
		SET @vcError = @vcSpname + '���� ����' + '������' + @vcModelType
	--Error �߻� �� log ���
		EXEC dbo.SXBWriteLogI 'X.dbo.SP', @vcError
	END		  
END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

