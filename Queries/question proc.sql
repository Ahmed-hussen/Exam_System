create proc selectQuestion @ID int = NULL
with encryption
as
select * from Question where Q_Id = @ID

create proc insertQuestion 
(
 @id            INTEGER = NULL,  
 @Question      VARCHAR(255) = NULL,  
 @Choices       VARCHAR(255) = NULL,
 @Answer        VARCHAR(1) = NULL,  
 @type          VARCHAR(32) = NULL,  
 @Difficulity   INTEGER = NULL,
 @Crs_Id        INTEGER = NULL
) 
with encryption
as
	   BEGIN TRY
            INSERT INTO Question  
                        (Q_id ,
                         Question,  
                         Choices ,  
                         Model_Answer,  
                         Q_type,  
                         Q_Difficulity,
				          Crs_Id)  
            VALUES     ( @id ,
                         @Question,  
                         @Choices ,  
                         @Answer,  
                         @type,  
                         @Difficulity,
				         @Crs_Id )
        END TRY
		BEGIN CATCH
		IF ERROR_NUMBER() = 2627 --error number for non unique value
			select  'insert a unique question ID' AS [ERROR] 
		ELSE if ERROR_NUMBER() = 547
			select 'No course with ID  = ' + convert(varchar(20), @Crs_Id) AS [ERROR]
		ELSE 
			select 'there was an ERROR'
		END CATCH

create proc updateQuestion 
(
 @id            INTEGER = NULL,  
 @Question      VARCHAR(255) = NULL,  
 @Choices       VARCHAR(255) = NULL,
 @Answer        VARCHAR(1) = NULL,  
 @type          VARCHAR(32) = NULL,  
 @Difficulity   INTEGER = NULL,
 @Crs_Id        INTEGER = NULL
) 
with encryption
as 
		BEGIN TRY
            UPDATE  Question  
            SET
				
				Question = case when @Question is NULL then Question else @Question end,  
                Choices = case when @Choices is NULL then Choices else @Choices end,
                Model_Answer = case when @Answer is NULL then Model_Answer else @Answer end, 
                Q_type = case when @type is NULL then Q_Type else @type end,
                Q_Difficulity = case when @Difficulity is NULL then Q_Difficulity else @Difficulity end,
				Crs_Id = case when @Crs_Id is NULL then Crs_Id else @Crs_Id end
				
            WHERE  Q_id = @id 
        END TRY
		BEGIN CATCH
			if ERROR_NUMBER() = 547
				select 'No course with ID  = ' + convert(varchar(20), @Crs_Id) AS [ERROR]
			else
				select 'There was an ERROR'
		END CATCH

create proc deleteQuestion @id int = NULL
with encryption
as
		BEGIN 
            DELETE FROM  Question
            WHERE  Q_id= @id  
        END


  -- Tests --

  selectQuestion 1
	
  selectQuestion
  -----------------------------------------
  insertQuestion

  insertQuestion 1, 'what', 'a,b,c,d', 'd', 'choice', 1, 100
  go
  selectQuestion 1  

  insertQuestion  2, @Crs_Id = 100
  go
  selectQuestion 2
  
  insertQuestion 3
  go
  selectQuestion 3

  insertQuestion 4, 'what is the best language'
  go 
  selectQuestion 4

  insertQuestion 5, 'what is the best language', 'java, c#, c++, python'
  go 
  selectQuestion 5

  insertQuestion 6, 'printf("hello world") ','a,b,c,d', 'a'
  go
  selectQuestion 6

  insertQuestion 7, 'banana color', 'a) black, b) blue, c) red, d) yellow', 'd', 'choice'
  go
  selectQuestion 7
  
  insertQuestion 8, 'banana color', 'a) black, b) blue, c) red, d) yellow', 'd', 'choice', 1
  go
  selectQuestion 8
  
  insertQuestion 9, 'banana color', 'a) black, b) blue, c) red, d) yellow', 'd', 'choice', 1, 100
  go
  selectQuestion 9

  insertQuestion 9

  insertQuestion 10, @Crs_Id = 1
  ---------------------------------------------------------
  updateQuestion

  updateQuestion 1
  go
  selectQuestion 1
  
  updateQuestion 1, 'hi', 't,f','t', 'T&F', 2, 100
  go
  selectQuestion 1

  updateQuestion 1, @Crs_Id = 1
 
  updateQuestion 10, 'new'
  ---------------------------------------------------
deleteQuestion 

deleteQuestion 9
go
selectQuestion 9

--empty the table

deleteQuestion 1
go
deleteQuestion 2
go
deleteQuestion 3
go
deleteQuestion 4
go
deleteQuestion 5
go
deleteQuestion 6
go
deleteQuestion 7
go
select * from Question








alter PROCEDURE questionTable
(
 @StatementType NVARCHAR(20) = 'select',
 @id            INTEGER = NULL,  
 @Question      VARCHAR(255) = NULL,  
 @Choices       VARCHAR(255) = NULL,
 @Answer        VARCHAR(1) = NULL,  
 @type          VARCHAR(32) = NULL,  
 @Difficulity   INTEGER = NULL,
 @Crs_Id        INTEGER = NULL
)  
AS  
  BEGIN  
	  IF lower(@StatementType) = 'select'  
        BEGIN  
            SELECT *  
            FROM    Question  
        END 
		
      ELSE IF lower(@StatementType) = 'insert'  
        BEGIN TRY
            INSERT INTO Question  
                        (Q_id ,
                         Question,  
                         Choices ,  
                         Model_Answer,  
                         Q_type,  
                         Q_Difficulity,
				          Crs_Id)  
            VALUES     ( @id ,
                         @Question,  
                         @Choices ,  
                         @Answer,  
                         @type,  
                         @Difficulity,
				         @Crs_Id )
        END TRY
		BEGIN CATCH
		IF ERROR_NUMBER() = 2627 --error number for non unique value
			select  'insert a unique question ID' AS [ERROR] 
		ELSE
			SELECT ' No course with ID = ' + convert(varchar(20), @Crs_Id) AS [ERROR]
		END CATCH
		
  
      ELSE IF lower(@StatementType) = 'update'  
        BEGIN TRY
            UPDATE  Question  
            SET
				
				Question = case when @Question is NULL then Question else @Question end,  
                Choices = case when @Choices is NULL then Choices else @Choices end,
                Model_Answer = case when @Answer is NULL then Model_Answer else @Answer end, 
                Q_type = case when @type is NULL then Q_Type else @type end,
                Q_Difficulity = case when @Difficulity is NULL then Q_Difficulity else @Difficulity end,
				Crs_Id = case when @Crs_Id is NULL then Crs_Id else @Crs_Id end
				
            WHERE  Q_id = @id 
        END TRY
		BEGIN CATCH
			select 'No course with ID  = ' + convert(varchar(20), @Crs_Id) AS [ERROR]
		END CATCH
		

      ELSE IF lower(@StatementType) = 'delete'
        BEGIN 
            DELETE FROM  Question
            WHERE  Q_id= @id  
        END
		
  END