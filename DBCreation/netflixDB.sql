USE [master]
GO
CREATE DATABASE [netflixDB]
GO
USE [netflixDB]
GO

CREATE TABLE [dbo].[User](
[UserId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
[Username] NVARCHAR(50) NOT NULL,
[Email] NVARCHAR(100) NOT NULL
);

CREATE TABLE [dbo].[Subscription] (
    [SubscriptionId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [UserId] INT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
	[SubscribePrice] FLOAT NOT NULL,
    CONSTRAINT [FK_Subscription_User] FOREIGN KEY ([UserId]) REFERENCES [User]([UserId])
);

CREATE TABLE [dbo].[Profile] (
    [ProfileId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [UserId] INT NOT NULL,
    [ProfileName] NVARCHAR(50) NOT NULL,
	[DateOfBirth] DATE NOT NULL,
	[Avatar] NVARCHAR(250),
    CONSTRAINT [FK_Profile_User] FOREIGN KEY ([UserId]) REFERENCES [User]([UserId])
);
