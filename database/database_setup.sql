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

-- DML Inserting records into every table for testing purposes

INSERT INTO Users (Fullnames, PhoneNumber) VALUES
('Samuel Carter', '95464'),
('Samuel Carter', '0790777777'),
('Bank of Kigali', '0795963036'),
('Jane Smith', '0782345683');
('Linda Green', '0788999999');

INSERT INTO Transactions_categories (UserId, CategoryName, Messages) VALUES
(13, 'Received', 'You have received 135983 RWF from Jane Smith (*********683) on your mobile money account at 2024-12-31 13:42:07. Message from sender: . Your new balance:164962 RWF. Financial Transaction Id: 42280278088.'),
(14, 'Transfer', '*165*S*8000 RWF transferred to Linda Green (250788999999) from 36521838 at 2024-12-30 14:10:06 . Fee was: 100 RWF. New balance: 51779 RWF. Kugura ama inite cg interineti kuri MoMo, Kanda *182*2*1# .*EN#'),
(11, 'Transfer', '*165*S*21000 RWF transferred to Samuel Carter (250790777777) from 36521838 at 2025-01-01 13:38:05 . Fee was: 250 RWF. New balance: 45012 RWF. Kugura ama inite cg interineti kuri MoMo, Kanda *182*2*1# .*EN#'),
(12, 'Deposit', '*113*R*A bank deposit of 10000 RWF has been added to your mobile money account at 2025-01-02 23:14:15. Your NEW BALANCE :11922 RWF. Cash Deposit::CASH::::0::250795963036.Thank you for using MTN MobileMoney.*EN#'),
(10, 'Payments', 'TxId: 51732411227. Your payment of 600 RWF to Samuel Carter 95464 has been completed at 2024-05-10 21:32:32. Your new balance: 400 RWF. Fee was 0 RWF.Kanda*182*16# wiyandikishe muri poromosiyo ya BivaMoMotima, ugire amahirwe yo gutsindira ibihembo bishimishije.');

INSERT INTO Transactions (UserId, CategoryId, Amount, Date, Fee, NewBalance, Currency, CategoryType, ServiceCenter, Status, Locked) VALUES
(10, 8, 600, '2024-05-10 21:32:32', 0, 400, 'RWF', 'Payments', '+250788110383', -1, 0),
(11, 6, 21000, '2025-01-01 13:38:05', 250, 45012, 'RWF', 'Transfer', '+250788110383', -1, 0),
(12, 7, 10000, '2025-01-02 23:14:15', 0, 11922, 'RWF', 'Deposit', '+250788110383', -1, 0),
(14, 9, 8000, '2025-01-02 23:14:15', 100, 51779, 'RWF', 'Transfer', '+250788110383', -1, 0),
(13, 5, 135983, '2024-12-31 13:42:07', 0, 164962, 'RWF', 'Received', '+250788110383', -1, 0);

INSERT INTO System_logs (TransactionId, LogMessage, Issue, Description) VALUES
(1, 'Payment processed', 'INFO', 'The payment for the electricity bill was successfully processed.'),
(2, 'Low balance warning', 'WARNING', 'User balance is low after grocery purchase.'),
(3, 'Salary received', 'INFO', 'Monthly salary has been credited to the account.'),
(4, 'Money Transfer Failed', 'ERROR', 'The money transfer could not be processed due to insufficient funds on your account.'),
(5, 'Payment processed', 'INFO', 'The payment for the electricity bill was successfully processed.');

