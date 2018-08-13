﻿CREATE TABLE [dbo].[Transactions]
(
	[Id] BIGINT NOT NULL PRIMARY KEY IDENTITY,
	[Hash] VARCHAR(64) NOT NULL,
	[BlockHash] VARCHAR(64) NULL,
	[Version] int NOT NULL DEFAULT 1,
    [Timestamp] BIGINT NOT NULL, 
	[LockTime] BIGINT NOT NULL DEFAULT 0,
    [TotalInput] BIGINT NOT NULL DEFAULT 0, 
    [TotalOutput] BIGINT NOT NULL DEFAULT 0, 
	[Size] INT NOT NULL DEFAULT 0,
    [Fee] BIGINT NOT NULL DEFAULT 0,
    [IsDiscarded] BIT NOT NULL DEFAULT 0
)

GO