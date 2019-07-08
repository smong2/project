SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




/* =====================================================================
	���α׷�ID : SXWTEnterReforecastI
	��  ��  �� : ���俹��
	���α׷��� : ���尴 �翹��- ���
	�����ۼ��� : 2002/11/14
	�����ۼ��� : 2002/11/14
	��  ��  �� : �ڼ���
	��  ��  �� : 
	��  ��  �� : 
	����  ���� : 
  ===================================================================== */

CREATE    PROCEDURE dbo.SXWTEnterReforecastI
	@vcModelType varchar(12)
	,@vcModelType2 varchar(5)
	,@dtStartdate datetime
	,@dtEnddate datetime


AS

	DECLARE @vcSpname VARCHAR(40)	            -- ����ó��
	DECLARE @vcError VARCHAR(200)
	DECLARE @vcWeekName VARCHAR(5)

	SET @vcSpname = 'SP Name : SXWTEnterReforecastI:'	-- ���� ���� �ʱ�ȭ

BEGIN

	IF @vcModelType='Y'  --�� �翹��
	 BEGIN
		WHILE @dtStartdate<=@dtEnddate 
      		BEGIN
	 	 	INSERT INTO dbo.txbreforecast 
			(year,y1,y2,y3,y4,y5,insertdate) 
		 	VALUES (year(@dtStartdate),'T','Y',LEFT(@vcModelType2,2),RIGHT(@vcModelType2,1),'-',getdate())

		IF @dtStartdate>@dtEnddate
		BREAK
	 
		 	SET @dtStartdate=dateadd("yyyy",1,@dtStartdate) --��¥ 1�� ������Ű��..
		END
	 END

	IF @vcModelType='M'  --�� �翹��
	 BEGIN		 
		WHILE  @dtStartdate<=@dtEnddate
		 BEGIN
		 	INSERT INTO dbo.txbreforecast 
		 	(year,month,y1,y2,y3,y4,y5,insertdate) 
		 	VALUES (year(@dtStartdate),month(@dtStartdate),'T','M',LEFT(@vcModelType2,2),RIGHT(@vcModelType2,1),'-',getdate()) --���� �� ����

		 IF @dtStartdate>@dtEnddate
     		 BREAK
 		
		 	SET @dtStartdate=dateadd("m",1,@dtStartdate) --��¥ 1���� ������Ű��..

		 END
	END

	IF @vcModelType='D' --�� �翹��
	 BEGIN
		WHILE @dtStartdate<=@dtEnddate 
		 BEGIN
			
			SELECT @vcWeekName=WEEKDAY   --������ ������
			FROM dbo.txbdate
			WHERE 	year=year(@dtStartdate) and
				month=month(@dtStartdate) and
				day=day(@dtStartdate)

		 	INSERT INTO dbo.txbreforecast 
		 	(year,month,day,y1,y2,y3,y4,y5,insertdate) 
		 	VALUES (year(@dtStartdate),month(@dtStartdate),day(@dtStartdate),'T','D',LEFT(@vcModelType2,2),month(@dtStartdate),@vcWeekName,getdate()) --���� �� ����
		
		 IF @dtStartdate>@dtEnddate
     		 BREAK

		 	SET @dtStartdate=dateadd("d",1,@dtStartdate) --��¥ 1�� ������Ű��..
		 END
	 END

	IF @@ERROR <> 0
	BEGIN
		SET @vcError = @vcSpname + '���� ����' + '�𵨸� : ' + @vcModelType 
	--Error �߻� �� log ���
		EXEC dbo.SXBWriteLogI 'X.dbo.SP', @vcError
	END		  
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

