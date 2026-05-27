-- PROJECT  : FLearn
-- DATABASE : SQL Server
-- TABLES   : 11
-- TEAM     : Nhóm 5 - SWP
================================================================

USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'FlearnDB')
BEGIN
    ALTER DATABASE FlearnDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE FlearnDB;
END
GO

CREATE DATABASE FlearnDB;
GO

USE FLearnDB;
GO

-- 1. USERS
CREATE TABLE Users (
    UserID          INT IDENTITY(1,1)   NOT NULL,
    Username        VARCHAR(50)         NOT NULL,
    PasswordHash    VARCHAR(255)        NOT NULL,
    FullName        NVARCHAR(100)       NOT NULL,
    Email           VARCHAR(100)        NOT NULL,
    Role            TINYINT             NOT NULL    DEFAULT 2,
    IsActive        BIT                 NOT NULL    DEFAULT 1,
    CreatedAt       DATETIME            NOT NULL    DEFAULT GETDATE(),

    CONSTRAINT PK_Users            PRIMARY KEY (UserID),
    CONSTRAINT UQ_Users_Username   UNIQUE (Username),
    CONSTRAINT UQ_Users_Email      UNIQUE (Email),
    CONSTRAINT CK_Users_Role       CHECK (Role IN (0, 1, 2))
);
GO

-- 2. CLASSES
CREATE TABLE Classes (
    ClassID         INT IDENTITY(1,1)   NOT NULL,
    ClassName       NVARCHAR(100)       NOT NULL,
    TeacherID       INT                 NOT NULL,
    InviteCode      VARCHAR(10)         NOT NULL,
    IsActive        BIT                 NOT NULL    DEFAULT 1,
    CreatedAt       DATETIME            NOT NULL    DEFAULT GETDATE(),

    CONSTRAINT PK_Classes           PRIMARY KEY (ClassID),
    CONSTRAINT UQ_Classes_Code      UNIQUE (InviteCode),
    CONSTRAINT FK_Classes_Teacher   FOREIGN KEY (TeacherID) REFERENCES Users(UserID)
);
GO

-- 3. CLASSMEMBERS
CREATE TABLE ClassMembers (
    MemberID        INT IDENTITY(1,1)   NOT NULL,
    ClassID         INT                 NOT NULL,
    StudentID       INT                 NOT NULL,
    JoinedAt        DATETIME            NOT NULL    DEFAULT GETDATE(),

    CONSTRAINT PK_ClassMembers          PRIMARY KEY (MemberID),
    CONSTRAINT UQ_ClassMembers          UNIQUE (ClassID, StudentID),
    CONSTRAINT FK_ClassMembers_Class    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID),
    CONSTRAINT FK_ClassMembers_Student  FOREIGN KEY (StudentID) REFERENCES Users(UserID)
);
GO

-- 4. NODES
CREATE TABLE Nodes (
    NodeID          INT IDENTITY(1,1)   NOT NULL,
    ClassID         INT                 NOT NULL,
    Title           NVARCHAR(200)       NOT NULL,
    VideoURL        VARCHAR(500)        NULL,
    OrderIndex      INT                 NOT NULL    DEFAULT 0,
    NodeType        TINYINT             NOT NULL    DEFAULT 0,
    UnlockAt        DATETIME            NULL,
    IsActive        BIT                 NOT NULL    DEFAULT 1,
    PrerequisiteNodeID INT              NULL,

    CONSTRAINT PK_Nodes             PRIMARY KEY (NodeID),
    CONSTRAINT FK_Nodes_Class       FOREIGN KEY (ClassID) REFERENCES Classes(ClassID),
    CONSTRAINT FK_Nodes_Prerequisite FOREIGN KEY (PrerequisiteNodeID) REFERENCES Nodes(NodeID),
    CONSTRAINT CK_Nodes_Type        CHECK (NodeType IN (0, 1, 2))
);
GO

-- 5. QUESTIONS
CREATE TABLE Questions (
    QuestionID      INT IDENTITY(1,1)   NOT NULL,
    NodeID          INT                 NULL,
    ClassID         INT                 NULL,
    QuestionText    NVARCHAR(MAX)       NOT NULL,
    QuestionType    TINYINT             NOT NULL    DEFAULT 0,
    PopUpTime       INT                 NULL,
    BonusPoint      INT                 NOT NULL    DEFAULT 0,
    Scope           TINYINT             NOT NULL    DEFAULT 0,
    IsActive        BIT                 NOT NULL    DEFAULT 1,

    CONSTRAINT PK_Questions             PRIMARY KEY (QuestionID),
    CONSTRAINT FK_Questions_Node        FOREIGN KEY (NodeID) REFERENCES Nodes(NodeID),
    CONSTRAINT FK_Questions_Class       FOREIGN KEY (ClassID) REFERENCES Classes(ClassID),
    CONSTRAINT CK_Questions_QType       CHECK (QuestionType IN (0, 1, 2)),
    CONSTRAINT CK_Questions_Scope       CHECK (Scope IN (0, 1, 2)),
    CONSTRAINT CK_Questions_Bonus       CHECK (BonusPoint >= 0),
    CONSTRAINT CK_Questions_NoSurveyBonus CHECK (Scope != 2 OR BonusPoint = 0),
    CONSTRAINT CK_Questions_Source      CHECK (
        (NodeID IS NOT NULL AND ClassID IS NULL) OR
        (NodeID IS NULL  AND ClassID IS NOT NULL)
    )
);
GO

-- 6. ANSWERS
CREATE TABLE Answers (
    AnswerID        INT IDENTITY(1,1)   NOT NULL,
    QuestionID      INT                 NOT NULL,
    AnswerText      NVARCHAR(MAX)       NOT NULL,
    IsCorrect       BIT                 NOT NULL    DEFAULT 0,

    CONSTRAINT PK_Answers               PRIMARY KEY (AnswerID),
    CONSTRAINT FK_Answers_Question      FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID)
);
GO

-- 7. LIVESESSIONS
CREATE TABLE LiveSessions (
    SessionID       INT IDENTITY(1,1)   NOT NULL,
    ClassID         INT                 NOT NULL,
    TeacherID       INT                 NOT NULL,
    StartedAt       DATETIME            NOT NULL    DEFAULT GETDATE(),
    EndedAt         DATETIME            NULL,

    CONSTRAINT PK_LiveSessions          PRIMARY KEY (SessionID),
    CONSTRAINT FK_LiveSessions_Class    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID),
    CONSTRAINT FK_LiveSessions_Teacher  FOREIGN KEY (TeacherID) REFERENCES Users(UserID)
);
GO

-- 8. STUDENTPROGRESS
CREATE TABLE StudentProgress (
    ProgressID      INT IDENTITY(1,1)   NOT NULL,
    StudentID       INT                 NOT NULL,
    NodeID          INT                 NOT NULL,
    IsCompleted     BIT                 NOT NULL    DEFAULT 0,
    LastWatchedSec  INT                 NOT NULL    DEFAULT 0,
    TotalBonus      INT                 NOT NULL    DEFAULT 0,
    UpdatedAt       DATETIME            NOT NULL    DEFAULT GETDATE(),

    CONSTRAINT PK_StudentProgress       PRIMARY KEY (ProgressID),
    CONSTRAINT UQ_StudentProgress       UNIQUE (StudentID, NodeID),
    CONSTRAINT FK_Progress_Student      FOREIGN KEY (StudentID) REFERENCES Users(UserID),
    CONSTRAINT FK_Progress_Node         FOREIGN KEY (NodeID) REFERENCES Nodes(NodeID),
    CONSTRAINT CK_Progress_Sec          CHECK (LastWatchedSec >= 0),
    CONSTRAINT CK_Progress_Bonus        CHECK (TotalBonus >= 0)
);
GO

-- 9. STUDENTANSWERS
CREATE TABLE StudentAnswers (
    ID                  INT IDENTITY(1,1)   NOT NULL,
    StudentID           INT                 NOT NULL,
    QuestionID          INT                 NOT NULL,
    SelectedAnswerID    INT                 NULL,
    EssayText           NVARCHAR(MAX)       NULL,
    IsCorrect           BIT                 NOT NULL    DEFAULT 0,
    Score               DECIMAL(5,2)        NULL,
    TeacherFeedback     NVARCHAR(MAX)       NULL,
    Context             TINYINT             NOT NULL    DEFAULT 0,
    SessionID           INT                 NULL,
    CreatedAt           DATETIME            NOT NULL    DEFAULT GETDATE(),

    CONSTRAINT PK_StudentAnswers            PRIMARY KEY (ID),
    CONSTRAINT FK_SA_Student                FOREIGN KEY (StudentID) REFERENCES Users(UserID),
    CONSTRAINT FK_SA_Question               FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID),
    CONSTRAINT FK_SA_Answer                 FOREIGN KEY (SelectedAnswerID) REFERENCES Answers(AnswerID),
    CONSTRAINT FK_SA_Session                FOREIGN KEY (SessionID) REFERENCES LiveSessions(SessionID),
    CONSTRAINT CK_SA_Context                CHECK (Context IN (0, 1)),
    CONSTRAINT CK_SA_LiveNeedsSession       CHECK (Context != 1 OR SessionID IS NOT NULL),
    CONSTRAINT CK_SA_AnswerNotEmpty         CHECK (SelectedAnswerID IS NOT NULL OR EssayText IS NOT NULL)
);
GO

-- 10. MILESTONEASSIGNMENTS
CREATE TABLE MilestoneAssignments (
    ID              INT IDENTITY(1,1)   NOT NULL,
    NodeID          INT                 NOT NULL,
    StudentID       INT                 NOT NULL,
    Role            TINYINT             NOT NULL    DEFAULT 0,
    IsCompleted     BIT                 NOT NULL    DEFAULT 0,
    SubmissionURL   VARCHAR(500)        NULL,
    SubmissionText  NVARCHAR(MAX)       NULL,
    Score           DECIMAL(5,2)        NULL,
    Feedback        NVARCHAR(MAX)       NULL,
    UpdatedAt       DATETIME            NOT NULL    DEFAULT GETDATE(),

    CONSTRAINT PK_MilestoneAssignments      PRIMARY KEY (ID),
    CONSTRAINT UQ_MilestoneAssignment       UNIQUE (NodeID, StudentID, Role),
    CONSTRAINT FK_MA_Node                   FOREIGN KEY (NodeID) REFERENCES Nodes(NodeID),
    CONSTRAINT FK_MA_Student                FOREIGN KEY (StudentID) REFERENCES Users(UserID),
    CONSTRAINT CK_MA_Role                   CHECK (Role IN (0, 1))
);
GO

-- 11. SURVEYRESPONSES
CREATE TABLE SurveyResponses (
    ID              INT IDENTITY(1,1)   NOT NULL,
    StudentID       INT                 NOT NULL,
    QuestionID      INT                 NOT NULL,
    ResponseText    NVARCHAR(MAX)       NOT NULL,
    CreatedAt       DATETIME            NOT NULL    DEFAULT GETDATE(),

    CONSTRAINT PK_SurveyResponses       PRIMARY KEY (ID),
    CONSTRAINT UQ_SurveyResponse        UNIQUE (StudentID, QuestionID),
    CONSTRAINT FK_SR_Student            FOREIGN KEY (StudentID) REFERENCES Users(UserID),
    CONSTRAINT FK_SR_Question           FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID)
);
GO

-- 12. STUDENTQUESTIONS
CREATE TABLE StudentQuestions (
    QuestionID      INT IDENTITY(1,1)   NOT NULL,
    ClassID         INT                 NOT NULL,
    StudentID       INT                 NOT NULL,
    TopicTitle      NVARCHAR(200)       NOT NULL,
    Description     NVARCHAR(MAX)       NULL,
    Upvotes         INT                 NOT NULL    DEFAULT 0,
    IsResolved      BIT                 NOT NULL    DEFAULT 0,
    CreatedAt       DATETIME            NOT NULL    DEFAULT GETDATE(),

    CONSTRAINT PK_StudentQuestions          PRIMARY KEY (QuestionID),
    CONSTRAINT FK_SQ_Class                  FOREIGN KEY (ClassID) REFERENCES Classes(ClassID),
    CONSTRAINT FK_SQ_Student                FOREIGN KEY (StudentID) REFERENCES Users(UserID)
);
GO

-- INDEXES
CREATE INDEX IX_ClassMembers_Class      ON ClassMembers     (ClassID, StudentID);
GO
CREATE INDEX IX_Nodes_Class             ON Nodes            (ClassID, OrderIndex) WHERE IsActive = 1;
GO
CREATE INDEX IX_Questions_Node          ON Questions        (NodeID, Scope) WHERE IsActive = 1;
GO
CREATE INDEX IX_Questions_Class         ON Questions        (ClassID, Scope) WHERE IsActive = 1;
GO
CREATE INDEX IX_Progress_Student        ON StudentProgress  (StudentID, NodeID);
GO
CREATE INDEX IX_SA_Student              ON StudentAnswers   (StudentID, QuestionID);
GO
CREATE INDEX IX_SA_Session              ON StudentAnswers   (SessionID) WHERE SessionID IS NOT NULL;
GO
CREATE INDEX IX_MA_Node                 ON MilestoneAssignments (NodeID, Role);
GO
