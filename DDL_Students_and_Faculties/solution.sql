-- Custom SQL DDL exercise (MySQL)
CREATE TABLE Students (
    RollNumber INT PRIMARY KEY,
    sName VARCHAR(50),
    Address VARCHAR(100),
    ContactNumber VARCHAR(15)
);

CREATE TABLE Faculties (
    FacultyId INT PRIMARY KEY,
    fName VARCHAR(50) NOT NULL,
    class VARCHAR(25),
    email VARCHAR(100)
);

DESC Students;
DESC Faculties;
