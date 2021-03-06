/**********************************selecTopic*************************************/
create proc SelecTopic 
with encryption
as
  BEGIN TRY
    select * from Topic 
  END TRY
  BEGIN CATCH
			select  'there is error' AS [ERROR] 
  END CATCH	

SelecTopic 
/***********************************insertTopic*********************************/

create proc InsertTopic
(
 @Topic_Id      INTEGER= NULL,
 @Top_Name      nvarchar(50) = NULL 
 
)  
with encryption
AS 
BEGIN
    BEGIN TRY
            INSERT INTO [dbo].[Topic]  
                        (Top_Id,
                         Top_Name )  
            VALUES     ( @Topic_Id ,
                         @Top_Name  )
        END TRY
		BEGIN CATCH
		IF ERROR_NUMBER() = 2627 --error number for non unique value
			select  'insert a unique Topic ID' AS [ERROR] 
		END CATCH	
 End 
 
 
 InsertTopic 1, 'ahmed'
 

 InsertTopic 8, 'DS'

/*****************UpdateTopic****************************************************/


create proc updateTopic 
(
 @Topic_Id      INTEGER= NULL,
 @Top_Name      nvarchar(50) = NULL 
 
) 
with encryption
as 
		BEGIN TRY
            UPDATE  Topic  
            SET
				
				Top_Name = case when @Top_Name is NULL then Top_Name else @Top_Name end  

				
            WHERE  Top_Id = @Topic_Id 
        END TRY
		BEGIN CATCH
			select 'Error in Update'AS [ERROR] 
		END CATCH

updateTopic 5, 'hi'

/********delet**********************/

create proc deleteTopic @Topic_Id int = NULL
with encryption
as
		BEGIN 
            DELETE FROM  Topic 
            WHERE  Top_Id = @Topic_Id   
        END

/*****************************************************/
/***********************Course**********************************/
/**************************************************************/

/**********************************selecCourse*************************************/
Create proc SelecCourse
with encryption
as
  BEGIN TRY
    select * from Course 
  END TRY
  BEGIN CATCH
			select  'there is error' AS [ERROR] 
  END CATCH	

SelecCourse 
/***********************************insertTopic*********************************/

create proc InsertCourse
(
 @Course_Id     INTEGER= NULL,
 @Course_Name      nvarchar(50) = NULL ,
 @Course_Duration      INTEGER = NULL, 
 @Top_Id           INTEGER = NULL
 
)  
with encryption
AS 
BEGIN
    BEGIN TRY
            INSERT INTO Course 
                        (Crs_Id,
                         Crs_Name,
						 Crs_Duration,
						 Top_Id )  
            VALUES     ( @Course_Id ,
                         @Course_Name,
						 @Course_Duration,
						 @Top_Id )
        END TRY
			BEGIN CATCH
		IF ERROR_NUMBER() = 2627 --error number for non unique value
			select  'insert a unique Course ID' AS [ERROR] 
		ELSE IF ERROR_NUMBER() = 547
			SELECT ' No Topic with ID = ' + convert(varchar(20), @Top_Id ) AS [ERROR]
		ELSE
		    select  'there is error' AS [ERROR]    
		
		END CATCH
 End 




 

 InsertCourse 2,'test',20,1000
 InsertCourse 1, 'ahmed'
 

 InsertCourse 8, 'DS'

/*****************UpdateCourse****************************************************/


Create proc updateCourse
(

 @Course_Id     INTEGER= NULL,
 @Course_Name      nvarchar(50) = NULL ,
 @Course_Duration      INTEGER = NULL, 
 @Top_Id           INTEGER = NULL
 
) 
with encryption
as 
		BEGIN TRY
            UPDATE  Course  
            SET
				
				Crs_Name = case when @Course_Name is NULL then Crs_Name else @Course_Name end,  
                Crs_Duration = case when @Course_Duration is NULL then Crs_Duration else @Course_Duration end,
                Top_Id = case when @Top_Id  is NULL then Top_Id else @Top_Id end 
 
            WHERE  Crs_Id = @Course_Id 
        END TRY
				BEGIN CATCH
		IF ERROR_NUMBER() = 2627 --error number for non unique value
			select  'insert a unique Course  ID' AS [ERROR] 
		ELSE IF ERROR_NUMBER() = 547
			SELECT ' No Topic with ID = ' + convert(varchar(20), @Top_Id ) AS [ERROR]
		ELSE
		    select  'there is error' AS [ERROR]    
		
		END CATCH
 

updateCourse 5, 'hi'

/********deletCourse**********************/

create proc deleteCourse @Course_Id int = NULL
with encryption
as
		BEGIN 
            DELETE FROM  Course 
            WHERE  Crs_Id = @Course_Id 
        END

/******************************************************************/
/***********************Exam******************************/
/****************************************************************/


/**********************************selecExam*************************************/
Create proc SelecExam
with encryption
as
  BEGIN TRY
    select * from Exam 
  END TRY
  BEGIN CATCH
			select  'there is error' AS [ERROR] 
  END CATCH	

SelecExam
/***********************************insertExam*********************************/

create proc InsertExam
(
 @Exam_Id     INTEGER= NULL,
 @Exam_Name      varchar(20) = NULL ,
 @Exam_Duration      varchar(20) = NULL, 
 @course_Id           INTEGER = NULL
 
)  
with encryption
AS 
BEGIN
    BEGIN TRY
            INSERT INTO Exam
                        (Ex_Id,
                         Ex_Name,
						 Duration,
						 Crs_Id )  
            VALUES     ( @Exam_Id ,
                         @Exam_Name,
						 @Exam_Duration,
						 @course_Id )
        END TRY
			BEGIN CATCH
		IF ERROR_NUMBER() = 2627 --error number for non unique value
			select  'insert a unique Exam ID' AS [ERROR] 
		ELSE IF ERROR_NUMBER() = 547
			SELECT ' No course with ID = ' + convert(varchar(20), @course_Id ) AS [ERROR]
		ELSE
		    select  'there is error' AS [ERROR]    
		
		END CATCH
 End 




 

 InsertExam 2,'test','test2',1000000

  InsertExam 2,'test','test2',1000
 InsertExam 1, 'ahmed'
 



/*****************UpdateExam****************************************************/


Create proc updateExam
(
 @Exam_Id     INTEGER= NULL,
 @Exam_Name      varchar(20) = NULL ,
 @Exam_Duration      varchar(20) = NULL, 
 @course_Id           INTEGER = NULL
 
)
with encryption
as 
		BEGIN TRY
            UPDATE  Exam 
            SET
				
				Ex_Name = case when @Exam_Name  is NULL then Ex_Name else @Exam_Name end,  
                Duration = case when @Exam_Duration  is NULL then Duration else @Exam_Duration end,
                Ex_Id = case when @course_Id  is NULL then Ex_Id else @course_Id end 
 
            WHERE  Ex_Id = @Exam_Id
        END TRY
				BEGIN CATCH
		IF ERROR_NUMBER() = 2627 --error number for non unique value
			select  'insert a unique Exam  ID' AS [ERROR] 
		ELSE IF ERROR_NUMBER() = 547
			SELECT ' No Course with ID = ' + convert(varchar(20), @course_Id ) AS [ERROR]
		ELSE
		    select  'there is error' AS [ERROR]    
		
		END CATCH
 



/********deletExam**********************/

create proc deleteExam @Exam_Id int = NULL
with encryption
as
		BEGIN 
            DELETE FROM  Exam
            WHERE  Ex_Id = @Exam_Id 
        END

/*********************************************************/
/***************************report************************/
/*********************************************************/

create proc R_StudentAnswer
(
 @Exam_number      INTEGER= NULL,
 @Student_number     INTEGER= NULL
 
)  
with encryption
AS 
BEGIN
    BEGIN TRY
            select St_Answer, [Question] from [dbo].[St_QuestionAndAnswer]
			where 
			Exam_Id=@Exam_number
			and St_Id=@Student_number
			
			
        END TRY
		BEGIN CATCH
		
			select  'Error' AS [ERROR] 
		END CATCH	
 End 

 R_StudentAnswer 100,2


CREATE VIEW St_QuestionAndAnswer
AS SELECT *
FROM Student_Exam_Answer S, Question Q
WHERE S.[Q-Id]=Q.Q_Id




---------------------------------------------------------------
--------------------------------------------------------------
----------------------------------------------------------
----------------------
