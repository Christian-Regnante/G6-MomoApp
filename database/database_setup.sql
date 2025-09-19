CREATE DATABASE IF NOT EXISTS MomoApp DEFAULT CHARACTER SET = 'utf8mb4';

USE MomoApp;

CREATE TABLE IF NOT EXISTS Users (
    Id INT(255) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Primary key: unique user identifier',
    Fullnames VARCHAR(255) NOT NULL COMMENT 'User full names (first and last names)',
    PhoneNumber VARCHAR(10) NOT NULL UNIQUE COMMENT 'Mobile phone number in national format (10 digits)'
);

CREATE TABLE IF NOT EXISTS Transactions_categories (
    Id INT(255) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Primary key: unique category identifier',
    UserId INT(255) NOT NULL COMMENT 'References Users(Id): the user whose transactions fall under this category',
    CategoryName VARCHAR(255) NOT NULL UNIQUE COMMENT 'Name of the transaction category (unique)',
    Messages VARCHAR(255) NOT NULL COMMENT 'Actual full message from the body xml data format.',
    FOREIGN KEY (UserId) REFERENCES Users (Id)
);

CREATE TABLE IF NOT EXISTS Transactions (
    Id INT(255) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Primary key: unique transaction identifier',
    UserId INT(255) NOT NULL COMMENT 'References Users(Id): the user who performed/owns the transaction',
    CategoryId INT(255) NOT NULL COMMENT 'References Transactions_categories(Id): category for the transaction',
    Amount DECIMAL(10, 0) NOT NULL CHECK (Amount >= 0) COMMENT 'Transaction amount (non-negative). Stored as DECIMAL without fractional part',
    Date DATETIME NOT NULL COMMENT 'Date and time when the transaction occurred',
    Fee INT(10) NOT NULL CHECK (Fee >= 0) COMMENT 'Fee charged for the transaction (non-negative, same currency units)',
    NewBalance DECIMAL(10, 0) NOT NULL CHECK (NewBalance >= 0) COMMENT 'User balance after this transaction (non-negative)',
    Currency VARCHAR(10) DEFAULT 'RWF' NOT NULL COMMENT 'Currency code for the transaction (default: RWF)',
    CategoryType ENUM(
        'Transfer',
        'Payments',
        'Received',
        'Deposit',
        'Withdraw',
        'Services',
        'MTN-Messages'
    ) NOT NULL COMMENT 'High-level type of transaction',
    ServiceCenter VARCHAR(255) COMMENT 'Optional: service center or vendor related to the transaction',
    Status INT COMMENT 'Optional: Based on the xml data format status',
    Locked INT COMMENT 'Optional: Flag indicating if the transaction is locked/immutable (e.g., 0 = unlocked, 1 = locked)',
    FOREIGN KEY (UserId) REFERENCES Users (Id),
    FOREIGN KEY (CategoryId) REFERENCES Transactions_categories (Id)
);

CREATE TABLE IF NOT EXISTS System_logs (
    LogId INT(255) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Primary key: unique log entry identifier',
    TransactionId INT(255) NOT NULL COMMENT 'References Transactions(Id): transaction related to this log entry',
    LogMessage VARCHAR(255) NOT NULL COMMENT 'Short log message/title or maybe the message that came with alongside the transaction issue',
    Issue ENUM('ERROR', 'WARNING', 'INFO') NOT NULL COMMENT 'Severity level of the log entry',
    Description TEXT COMMENT 'Detailed description of the log event or issue',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT 'Using current timestamp as default value to record when the log entry was created',
    FOREIGN KEY (TransactionId) REFERENCES Transactions (Id)
);
