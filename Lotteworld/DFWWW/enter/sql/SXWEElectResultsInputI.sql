SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/*====================================================================================
	���α׷�ID : SXWEElectResultsInputI
	��  ��  �� : ���俹��
	���α׷��� : ���� �Է� - ���� �Է�
	�����ۼ��� : 2002/11/27
	�����ۼ��� : 2002/11/27
	��  ��  �� : �ڼ���
	��  ��  �� :
	��  ��  �� :
	����  ���� :
====================================================================================*/
CREATE   PROCEDURE dbo.SXWEElectResultsInputI
	 @varModelType VARCHAR(15)
	,@varInput_Year VARCHAR(5)
	,@varInput_Month VARCHAR(5)
	,@varInput_Day VARCHAR(5)=1
	,@nMagicisland NUMERIC(19,5)
	,@nAdventure NUMERIC(19,5)
	,@nSports NUMERIC(19,5)
	,@nHotel NUMERIC(19,5)
	,@nDepartmentstore NUMERIC(19,5)
	,@nShoppingmall NUMERIC(19,5)
	,@nMart NUMERIC(19,5)
	,@nTotal NUMERIC(19,5)
AS
BEGIN

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	SET @vcSpname = 'SP Name : SXWEElectResultsInputI:'	-- ���� ���� �ʱ�ȭ

	IF @varModelType='results_day'  --�� �Է��� ���
		BEGIN
		  	DELETE FROM dbo.txeeachbuildday    --���� �� �����
			WHERE xdate=@varInput_Year + '-' + @varInput_Month + '-' + @varInput_Day

	  		INSERT INTO dbo.txeeachbuildday    --�Է��Ѵ�
			(xdate,magicisland,adventure,sports,hotel,departmentstore,shoppingmall,mart,total) 
			values (@varInput_Year + '-' + @varInput_Month + '-' + @varInput_Day,
				@nmagicisland,
				@nadventure,
				@nsports,
				@nhotel,
				@ndepartmentstore,
				@nshoppingmall,
				@nmart,
				@ntotal)
		END
	ELSE IF @varModelType='results_month'  --�� �Է��� ���
		BEGIN
	  		DELETE FROM dbo.txeeachbuildmonth   --���� �� �����(�����ڷ�)
			WHERE year=@varinput_year and month=@varinput_month

	 		INSERT INTO dbo.txeeachbuildmonth   --�Է��Ѵ�
			(year,month,magicisland,adventure,sports,hotel,departmentstore,shoppingmall,mart,total) 
			VALUES (@varInput_Year,
				@varInput_Month,
				@nMagicisland,
				@nAdventure,
				@nSports,
				@nHotel,
				@nDepartmentstore,
				@nShoppingmall,
				@nMart,
				@nTotal)
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

