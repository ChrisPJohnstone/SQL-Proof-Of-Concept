SET DATEFIRST 1;

DECLARE @StartDate DATE = '2020-01-01'
DECLARE @EndDate DATE = GETDATE()
DECLARE @CurrentDay DATE = 
	CASE 
		WHEN DATEPART(dw, @StartDate) = 6 THEN DATEADD(D, 2, @StartDate) 
		WHEN DATEPART(dw, @StartDate) = 7 THEN DATEADD(D, 1, @StartDate) 	
		ELSE @StartDate 
	END
DECLARE @Weekdays AS TABLE ([Date] DATE NOT NULL);

WHILE @CurrentDay <= @EndDate
BEGIN
	
	INSERT INTO @Weekdays ([Date])
	Select @CurrentDay

	SET @CurrentDay = CASE WHEN DATEPART(dw, @CurrentDay) = 5 THEN DATEADD(D, 3, @CurrentDay) ELSE DATEADD(D, 1, @CurrentDay) END

END

Select * From @Weekdays
