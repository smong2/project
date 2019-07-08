SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




/* =====================================================================
	���α׷�ID : SXWTEnterDayInputI
	��  ��  �� : ���俹��
	���α׷��� : ���尴 ��ǥ - ��� -���Է�
	�����ۼ��� : 2002/11/14
	�����ۼ��� : 2002/11/14
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */

CREATE    PROCEDURE dbo.SXWTEnterDayInputI
	@vcModelType varchar(10)
	,@dtXdate datetime 
	,@intTotal_a int
	,@intIndiv_a int
	,@intGroup_a int
	,@intSpecial_a int
	,@intFree_a int
	,@intEducinst_a int
	,@intDutyfree_a int
	,@intCompany_a int
	,@intMycustomer_a int
	,@intEtc_a int

	,@intTotal_s int=0
	,@intIndiv_s int=0
	,@intGroup_s int=0
	,@intSpecial_s int=0
	,@intFree_s int=0
	,@intEducinst_s int=0
	,@intDutyfree_s int=0
	,@intCompany_s int=0
	,@intMycustomer_s int=0
	,@intEtc_s int=0

	,@intTotal_c int=0
	,@intIndiv_c int=0
	,@intGroup_c int=0
	,@intSpecial_c int=0
	,@intFree_c int=0
	,@intEducinst_c int=0
	,@intDutyfree_c int=0
	,@intCompany_c int=0
	,@intMycustomer_c int=0
	,@intEtc_c int=0
AS
	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWTEnteDayInputI:'	-- ���� ���� �ʱ�ȭ

BEGIN

IF @vcModelType='vxt' -- ��ǥ������ ���
	BEGIN

		DELETE FROM dbo.txtenter  --�����Ѵ�
		WHERE xdate=@dtXdate

		--�Է� ��
		INSERT INTO dbo.txtenter   --� �Է�
		(xdate,class,total,indiv,org,special,free,educinst,dutyfree,company,mycustomer,etc)   
		VALUES (@dtXdate,'A',@intTotal_a,@intIndiv_a,@intGroup_a,@intSpecial_a,@intFree_a,@intEducinst_a,@intDutyfree_a,@intCompany_a,@intMycustomer_a,@intEtc_a)

		INSERT INTO dbo.txtenter   --�л� �Է�
		(xdate,class,total,indiv,org,special,free,educinst,dutyfree,company,mycustomer,etc)   
		VALUES (@dtXdate,'S',@intTotal_s,@intIndiv_s,@intGroup_s,@intSpecial_s,@intFree_s,@intEducinst_s,@intDutyfree_s,@intCompany_s,@intMycustomer_s,@intEtc_s)

		INSERT INTO dbo.txtenter   --��� �Է�
		(xdate,class,total,indiv,org,special,free,educinst,dutyfree,company,mycustomer,etc)   
		VALUES (@dtXdate,'C',@intTotal_c,@intIndiv_c,@intGroup_c,@intSpecial_c,@intFree_c,@intEducinst_c,@intDutyfree_c,@intCompany_c,@intMycustomer_c,@intEtc_c)
	END
IF @vcModelType='vxte' --�������ϰ��
	BEGIN

		DELETE FROM dbo.txteenter  --�����Ѵ�
		WHERE xdate=@dtXdate

		--�Է� ��
		INSERT INTO dbo.txteenter   --� �Է�
		(xdate,class,total,indiv,org,special,free,educinst,dutyfree,company,mycustomer,etc)   
		VALUES (@dtXdate,'T',@intTotal_a,@intIndiv_a,@intGroup_a,@intSpecial_a,@intFree_a,@intEducinst_a,@intDutyfree_a,@intCompany_a,@intMycustomer_a,@intEtc_a)
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

