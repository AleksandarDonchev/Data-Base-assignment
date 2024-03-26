CREATE DATABASE Bookshop12;


CREATE TABLE Author(
Id int PRIMARY KEY IDENTITY(1,1),
FirstName varchar(15),
LastName varchar(15),
Nickname varchar(30),
DateOfBirth date NOT NULL,
CountryOfBirth varchar(50) 
)

CREATE TABLE Keyword(
Id int PRIMARY KEY IDENTITY (1,1),
TypeofKeyword varchar(20) NOT NULL
)

CREATE TABLE Genre(
Id int PRIMARY KEY IDENTITY (1,1),
TypeOfGenre varchar (30) NOT NULL
)


CREATE TABLE Books(
Id int PRIMARY KEY IDENTITY(1,1),
BookName varchar (30) NOT NULL UNIQUE,
YearOfPublishing date NOT NULL,
Price decimal (4,2) NOT NULL,
Topic varchar(20) NOT NULL,
Subtopic varchar(20),
AuthorID int FOREIGN KEY REFERENCES Author(Id) NOT NULL,
GenreId int FOREIGN KEY REFERENCES Genre(Id)NOT NULL
)


CREATE TABLE BookKeywords(
Id int PRIMARY KEY IDENTITY(1,1),
BookId int FOREIGN KEY REFERENCES Books(Id)NOT NULL,
KeywordId int FOREIGN KEY REFERENCES Keyword(Id)NOT NULL
)

CREATE TABLE Sales(
Id int PRIMARY KEY IDENTITY(1,1),
BookId int FOREIGN KEY REFERENCES Books(Id)NOT NULL,
Date_Of_Sale date NOT NULL,
)

--Въвеждане на данни в таблицата Author
INSERT INTO Author(FirstName,LastName,Nickname,DateOfBirth,CountryOfBirth)
VALUES('Leo','Tolstoy',NULL,'1928-09-09','Russia'),
('Stephen' , 'King' , NULL , '1947-09-21','America'),
('William','Shakespeare',NULL,'1564-04-26','England'),
('Herman','Melville',NULL,'1819-08-01','America'),
('Miguel','de Cervantes',NULL,'1547-09-29','Spain'),
('Ivan','Vazov',NULL,'1850-07-09','Bulgaria'),
('James','Bawdwin','Popeyes','1924-08-02','Amercia'),
('George','Orwell',NULL,'1903-01-06','England'),
(NULL,NULL,'Mark Twen','1835-11-30','America'),
('Aleko','Konstantinov','The Lucky Man','1863-01-01','Bulgaria')

--Въвеждане на данни в таблицата Keyword
INSERT INTO Keyword(TypeofKeyword)
VALUES('peace'),
('war'),
('power'),
('love'),
('wisdom'),
('heroism'),
('suffering'),
('comedy'),
('scientific'),
('inspirational')

--Въвеждане на данни в таблицата Genre
INSERT INTO Genre(TypeOfGenre)
VALUES('Fiction'),
('Novel'),
('Science fiction'),
('Poetry'),
('Fantasy'),
('Drama'),
('Thriller'),
('Romance novel'),
('Comedy'),
('Tragedy')

--Въвеждане на данни в таблицата Books
INSERT INTO Books(BookName,YearOfPublishing,Price,Topic,Subtopic,AuthorID,GenreId)
VALUES(' War and Peace','1867-01-31',20.40,'Life','Violence',1,2),
('Pod igoto','1894-05-12',15.00,'Story telling','',6,2),
('Hamlet','1599-12-12',16.35,'Tradegy','Suffering',3,4),
(' Don Quixote','1605-01-16',20.00,'Story telling','',5,5),
('Bai Ganio','1899-09-15',12.50,'Comedy','Story telling',10,9),
('Romeo and Juliet','1597-08-23',18.20,'Love','Tradegy',3,10),
('Animal Farm','1945-03-15',10.00,'Friendship','',8,1),
('The Shining','1977-02-02',23.71,'Fear','',2,7),
('The Mysterious Stranger','1916-07-30',12.00,'Crime','Fiction',9,1),
('IT','1986-04-01',20.00,'Fear','Horor',2,7)

--Въвеждане на данни в таблицата BookKeywords
INSERT INTO BookKeywords(BookId,KeywordId)
VALUES(1,1),(1,2),(2,10),(3,7),(4,6),(4,8),(5,8),(6,4),
(6,6),(7,5),(7,10),(8,9),(9,3),(9,10),(10,3)

--Въвеждане на данни в таблицата Sales
INSERT INTO Sales(BookId,Date_Of_Sale)
VALUES(1,'2020-10-03'),
(3,'2020-10-16'),
(10,'2020-12-24'),
(7,'2020-12-24'),
(5,'2020-12-24'),
(1,'2020-12-29'),
(2,'2021-01-24'),
(4,'2021-02-02'),
(4,'2021-04-19'),
(6,'2021-04-24'),
(10,'2021-04-30'),
(7,'2021-05-04'),
(8,'2021-05-16'),
(5,'2021-05-28'),
(9,'2021-07-16'),
(9,'2021-07-21'),
(9,'2021-07-22'),
(3,'2021-08-10'),
(6,'2021-09-06'),
(7,'2021-09-15'),
(2,'2021-10-16'),
(9,'2022-03-05'),
(2,'2022-03-15'),
(6,'2022-07-01'),
(9,'2022-08-11'),
(9,'2022-10-14'),
(1,'2022-10-15'),
(10,'2022-10-28'),
(10,'2022-11-12'),
(5,'2022-11-26')


--Редактиране на стойността на DateOfBirth в таблицата Author
UPDATE Author
SET DateOfBirth = '1928-09-10'
WHERE Author.Id = 1


-- Заявка за извеждане на всички книги които са по-евтини от 20.00 долара,цена във възходящ ред
SELECT *
FROM Books
WHERE Books.Price < 20.00
ORDER BY Books.Price ASC


--Заявка за извеждане на най-ниската цена на книга
SELECT MIN(Books.Price)
FROM Books


-- Заявка за извеждане на всички автори и техните книги
SELECT Author.FirstName , Author.LastName , Author.Nickname , Books.BookName AS Book
FROM Author
INNER JOIN Books ON Books.AuthorID = Author.Id
ORDER BY Author.FirstName,Author.LastName,Author.Nickname,Books.BookName 

-- Заявка за извличане на направените продажби на книга с Id = 9
SELECT Sales.Date_Of_Sale AS SaleDate
FROM Sales INNER JOIN Books ON Sales.BookId = Books.Id
WHERE Books.Id = 9
GROUP BY Date_Of_Sale 


-- Заявка за извличане на книгата с най-висока цена
SELECT Books.BookName , Books.Price
FROM Books
WHERE Books.Price = (SELECT MAX(Books.Price)FROM Books)


-- Заявка за извличане на авторите,които имат буквата 'S' във фамилията си 
SELECT Author.LastName
FROM Author
WHERE Author.LastName  LIKE '%S%'; 


-- Заявка за извеждане на общата сума на всяка една книга продадена в определен период
SELECT Books.BookName AS Book ,SUM(Books.Price) as TotalSum
FROM Books INNER JOIN Sales ON Books.Id =Sales.BookId
WHERE Sales.Date_Of_Sale BETWEEN '2022-01-01' AND '2022-11-26'
GROUP BY Books.BookName

-- Заявка за извеждане на името на книгата и годината на издателство при която годината на издателство е преди 1902г. 
--Подредени по низходящ ред

SELECT Books.BookName, MAX(Books.YearOfPublishing) AS PublishYear
FROM Books
GROUP BY Books.BookName,Books.YearOfPublishing
HAVING MAX(Books.YearOfPublishing) < '1902-01-01'
ORDER BY MAX(Books.YearOfPublishing) DESC;

--Заявка за изписване на съобщение спрямо датата на раждане на писателя,чрез използване на case израз.

SELECT Author.Id, 
CASE 
WHEN Author.DateOfBirth BETWEEN '1800-01-01' AND '1899-12-31' THEN 'The Author was born in the 19th century' 
WHEN Author.DateOfBirth BETWEEN '1900-01-01' AND '1999-12-31' THEN 'The Author was born in the 20th century'
WHEN Author.DateOfBirth BETWEEN '2000-01-01' AND '2022-11-31' THEN 'The Author was born in the 21th century'
ELSE 'The Author was born before a long time ago'
END AS Century_of_birth
FROM Author

--Заявка за извеждане на името на книгата и съдържаща ключовата дума inspirational
SELECT Books.BookName, Keyword.TypeofKeyword
FROM Keyword,Books,BookKeywords
WHERE Keyword.Id = BookKeywords.KeywordId
AND Books.Id = BookKeywords.BookId
AND Keyword.TypeofKeyword = 'inspirational'

--Създаване на изглед с имената на авторите родени в 'Bulgaria'
CREATE VIEW Country AS
SELECT CONCAT( Author.FirstName,' ' , Author.LastName , '-', Author.Nickname) AS Name
FROM Author
WHERE Author.CountryOfBirth = 'Bulgaria';
SELECT * FROM [Country];
--Изтриване на изглед Country
DROP VIEW Country;

--Процедура за извеждане на направените продажби през миналата година
CREATE PROCEDURE Last_year_sales
AS
SELECT Books.BookName,Sales.Date_Of_Sale
FROM Books INNER JOIN Sales ON Books.Id = Sales.BookId
WHERE Sales.Date_Of_Sale BETWEEN '2021-01-01' AND '2021-12-31' 
GO;
EXEC Last_year_sales;
--Изтриване на процедура Last_year_sales
DROP PROCEDURE Last_year_sales

--Създаване на DML тригер който забранява изтриването на запис от таблицата Sales
CREATE TRIGGER Sales_no_delete
ON Sales
INSTEAD OF DELETE
AS
PRINT'You cannot delete column from this table!'
ROLLBACK;
--Задействане на тригера
DELETE FROM Sales
WHERE Sales.Id = 2;
-- Изтриване на тригер
DROP TRIGGER Sales_no_delete
--Създаване на тигер Edit който при спрямо вида на промяната информацията записва в колона edit какъв вид е била промяната  
CREATE TRIGGER Edit on Sales
FOR UPDATE
AS Declare
@ActionPerformed varchar(40) = ''
begin
if update(BookId)
Begin
SET @ActionPerformed = 'The Bookid was edited'
END
 if update(Date_Of_Sale)
Begin 
SET @ActionPerformed = 'The Date of sale was edited'
end
PRINT 'Successfully edited' 
UPDATE Sales SET Edit = @ActionPerformed WHERE Sales.Id IN (SELECT Id FROM inserted)
end

--промяна на датата
UPDATE Sales
Set Date_Of_Sale = GETDATE() 
WHERE Sales.Id = 29
--промяна на Id
UPDATE Sales
Set BookId = 3
Where Sales.Id= 11

SELECT * FROM Sales
--изтриване на тригера
DROP TRIGGER Edit

SELECT FirstName
FROM Author
WHERE FirstName LIKE '[^alf]%'

SELECT FirstName
FROM Author
WHERE CountryOfBirth NOT IN('Bulgaria','America')


SELECT Author.FirstName , Author.LastName , Author.Nickname , Books.BookName AS Book
FROM Author
 JOIN Books ON Books.AuthorID = Author.Id
ORDER BY Author.FirstName,Author.LastName,Author.Nickname,Books.BookName 




