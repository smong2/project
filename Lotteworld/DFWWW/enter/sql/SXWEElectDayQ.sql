SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



/*====================================================================================
	���α׷�ID : SXWEElectdayQ
	��  ��  �� : ���俹��
	���α׷��� : ���� ���� - ��
	�����ۼ��� : 2002/11/26
	�����ۼ��� : 2002/11/26
	��  ��  �� : �ڼ���
	��  ��  �� :
	��  ��  �� :
	����  ���� :
====================================================================================*/
CREATE        PROCEDURE dbo.SXWEElectDayQ
	@dtLastDay 	DATETIME
	,@dtLastWeekDay DATETIME
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWElectDayQ:'	-- ���� ���� �ʱ�ȭ

	SELECT *    --����ġ �������� 3��
	FROM dbo.txeday
	WHERE Year=2002 and Month=7   	-- ���� �� ���� select year(getdate()), month(getdate()), month(getdate()), year(dateadd(dd,1,getdate())), month(dateadd(dd,1,getdate())), day(dateadd(dd,1,getdate())),  year(dateadd(dd,2,getdate())), month(dateadd(dd,2,getdate())), day(dateadd(dd,2,getdate()))

	SELECT *     --���� ���� ���� ����ġ �������� (3��)
	FROM dbo.txeeachbuildday 
	WHERE xdate>=@dtLastday and xdate<=@dtLastday+2

	SELECT *   --���� ������ ����ġ ��������(3��)
	FROM dbo.txeeachbuildday 
	WHERE xdate>=@dtLastWeekDay and xdate<=@dtLastWeekDay+2

	SELECT sum(total) as total,  --����ġ �հ� ��������
		sum(magicisland) as magicisland, 
		sum(adventure) as adventure, 
		sum(departmentstore) as departmentstore, 
		sum(sports) as sports,
		sum(shoppingmall) as shoppingmall, 
		sum(mart) as mart, 
		sum(hotel) as hotel 
	FROM dbo.txeday
	WHERE YEAR=2002 and Month=7

	SELECT sum(total) as total,  --���� ���⵿�� ���� �հ� ��������
		sum(magicisland) as magicisland, 
		sum(adventure) as adventure, 
		sum(departmentstore) as departmentstore, 
		sum(sports) as sports,
		sum(shoppingmall) as shoppingmall, 
		sum(mart) as mart, 
		sum(hotel) as hotel 
	FROM dbo.txeeachbuildday 
	WHERE xdate>=cast(datename(year,@dtLastday)  + '-'  + datename(month,@dtLastday) + '-' + datename(day,'01-01-01') as datetime)  and xdate<=@dtLastDay
	

	SELECT  sum(total) as total,  --���� ������ �հ� ��������
		sum(magicisland) as magicisland, 
		sum(adventure) as adventure, 
		sum(departmentstore) as departmentstore, 
		sum(sports) as sports,
		sum(shoppingmall) as shoppingmall, 
		sum(mart) as mart, 
		sum(hotel) as hotel 
	FROM dbo.txeeachbuildday 
	WHERE xdate>=cast(datename(year,@dtLastWeekday)  + '-'  + datename(month,@dtLastWeekday) + '-' + datename(day,'01-01-01') as datetime)   and xdate<=@dtLastWeekday

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

