SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/*====================================================================================
	���α׷�ID : SXWEElectMonthQ
	��  ��  �� : ���俹��
	���α׷��� : ���� ���� - ��
	�����ۼ��� : 2002/11/26
	�����ۼ��� : 2002/11/26
	��  ��  �� : �ڼ���
	��  ��  �� :
	��  ��  �� :
	����  ���� :
====================================================================================*/
CREATE      PROCEDURE dbo.SXWEElectMonthQ
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWElectMonthQ:'	-- ���� ���� �ʱ�ȭ

	SELECT *   --������ ��������
	FROM dbo.txemonth
	WHERE year=2002 and Month>=5 and Month<=7  --where year>=year(getdate()) and month>=month(getdate()) or year<=year(dateadd(mm,2,getdate())) and month<=month(dateadd(mm,2,getdate()))

	SELECT * 
	FROM dbo.txeeachbuildmonth   --���� ���� ����ġ �������� (3����)
	WHERE (year=year(dateadd(mm,  -12, getdate())) and month=month(dateadd(mm,  -12, getdate()))) or  
		(year=year(dateadd(mm,  -11, getdate())) and month=month(dateadd(mm,  -11, getdate()))) or 
		(year=year(dateadd(mm,  -10, getdate())) and month=month(dateadd(mm,  -10, getdate())))

	SELECT sum(total) as total,    --������ �հ�
		sum(adventure) as adventure, 
		sum(magicisland) as magicisland, 
		sum(hotel) as hotel, 
		sum(departmentstore) as departmentstore, 
		sum(mart) as mart, 
		sum(sports) as sports, 
		sum(shoppingmall) as shoppingmall   
	FROM dbo.txemonth
	WHERE year=2002 and Month>=5 and Month<=7	

	SELECT sum(total) as total,    --���� ���� �հ�
		sum(adventure) as adventure, 
		sum(magicisland) as magicisland, 
		sum(hotel) as hotel, 
		sum(departmentstore) as departmentstore, 
		sum(mart) as mart, 
		sum(sports) as sports, 
		sum(shoppingmall) as shoppingmall 
	FROM dbo.txeeachbuildmonth 
	WHERE year=year(getdate())-1 and month<=month(getdate())

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

