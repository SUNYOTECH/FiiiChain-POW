﻿CREATE TABLE IF NOT EXISTS [Accounts]
(
	[Id] VARCHAR(64) NOT NULL PRIMARY KEY, 
    [PrivateKey] VARCHAR(64) NULL, 
    [PublicKey] VARCHAR(64) NULL, 
    [Balance] INTEGER NOT NULL DEFAULT 0, 
    [IsDefault] BOOLEAN NOT NULL DEFAULT 0, 
    [WatchedOnly] BOOLEAN NOT NULL DEFAULT 0, 
    [Timestamp] INTEGER NOT NULL, 
    [Tag] VARCHAR(64) NULL
);

CREATE TABLE IF NOT EXISTS [Blacklist]
(
	[Id] INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
    [Address] VARCHAR(50) NOT NULL, 
    [Timestamp] INTEGER NOT NULL,
	[Expired] INTEGER NULL
);

CREATE TABLE IF NOT EXISTS [Peers]
(
	[Id] INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
    [IP] VARCHAR(50) NOT NULL, 
    [Port] INT NOT NULL, 
    [PingTime] INTEGER NULL , 
    [Timestamp] INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS [Blocks]
(
	[Id] INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
	[Hash] VARCHAR(64) NOT NULL,
    [Version] INT NOT NULL DEFAULT 1, 
    [Height] INTEGER NOT NULL, 
    [PreviousBlockHash] VARCHAR(64) NOT NULL, 
	[Bits] INTEGER NOT NULL,
    [Nonce] INTEGER NOT NULL, 
    [Timestamp] INTEGER NOT NULL, 
    [NextBlockHash] VARCHAR(64) NULL, 
    [TotalAmount] INTEGER NOT NULL DEFAULT 0, 
    [TotalFee] INTEGER NOT NULL DEFAULT 0, 
    [GeneratorId] VARCHAR(64) NULL, 
    [IsDiscarded] BOOLEAN NOT NULL DEFAULT 0,
	[IsVerified] BOOLEAN NOT NULL DEFAULT 0 
);

CREATE TABLE IF NOT EXISTS [Transactions]
(
	[Id] INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
	[Hash] VARCHAR(64) NOT NULL, 
	[BlockHash] VARCHAR(64) NULL,
	[Version] INT NOT NULL DEFAULT 1,
    [Timestamp] INTEGER NOT NULL, 
	[LockTime] INTEGER NOT NULL DEFAULT 0,
    [TotalInput] INTEGER NOT NULL DEFAULT 0, 
    [TotalOutput] INTEGER NOT NULL DEFAULT 0, 
	[Size] INTEGER NOT NULL DEFAULT 0,
    [Fee] INTEGER NOT NULL DEFAULT 0, 
    [IsDiscarded] BOOLEAN NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS [InputList]
(
	[Id] INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
    [TransactionHash] VARCHAR(64) NOT NULL, 
    [OutputTransactionHash] VARCHAR(64) NOT NULL, 
    [OutputIndex] INT NULL,
    [Size] INT NOT NULL, 
    [Amount] INTEGER NOT NULL DEFAULT 0, 
    [UnlockScript] TEXT NULL, 
    [AccountId] VARCHAR(64) NULL, 
    [IsDiscarded] BOOLEAN NOT NULL DEFAULT 0 
);

CREATE TABLE IF NOT EXISTS [OutputList]
(
	[Id] INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
	[Index] INT NOT NULL, 
    [TransactionHash] VARCHAR(64) NOT NULL, 
    [ReceiverId] VARCHAR(64) NOT NULL, 
    [Amount] INTEGER NOT NULL DEFAULT 0, 
	[Size] INT NOT NULL DEFAULT 0,
    [LockScript] TEXT NULL, 
    [Spent] BOOLEAN NOT NULL DEFAULT 0, 
    [IsDiscarded] BOOLEAN NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS [AddressBook]
(
	[Id] INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
    [Address] VARCHAR(64) NOT NULL, 
    [Tag] VARCHAR(64) NULL, 
    [Timestamp] INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS [Settings]
(
	[Id] INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
    [Confirmations] INTEGER NOT NULL DEFAULT 1, 
    [FeePerKB] INTEGER NOT NULL DEFAULT 1000,
    [Encrypt] BOOLEAN NOT NULL DEFAULT 0,
    [PassCiphertext] VARCHAR(64)
);

CREATE TABLE IF NOT EXISTS [TransactionComments]
(
	[Id] INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
    [TransactionHash] VARCHAR(64) NOT NULL, 
    [OutputIndex] INT NOT NULL DEFAULT 0, 
    [Comment] VARCHAR(200) NOT NULL, 
    [Timestamp] INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS [PaymentRequests]
(
	[Id] INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
    [AccountId] VARCHAR(64) NOT NULL, 
    [Tag] VARCHAR(64) NULL, 
    [Comment] VARCHAR(200) NULL, 
    [Amount] INTEGER NOT NULL DEFAULT 0, 
    [Timestamp] INTEGER NOT NULL DEFAULT 0
);