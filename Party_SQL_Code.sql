-- Create the database if not exists
CREATE DATABASE IF NOT EXISTS FarewellPartyDB;

-- Use the created database
USE FarewellPartyDB;

-- Create table for storing contact information
CREATE TABLE IF NOT EXISTS contacts (
    contact_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    subject VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    submission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create table for storing student registration information
CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    batch VARCHAR(50) NOT NULL,
    roll_no VARCHAR(20) NOT NULL,
    dietary_preferences VARCHAR(50),
    family_members INT,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create table for storing login credentials
CREATE TABLE IF NOT EXISTS login_credentials (
    credential_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL,
    student_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Add foreign key constraint for student_id in login_credentials table
ALTER TABLE login_credentials
ADD CONSTRAINT fk_student_id
FOREIGN KEY (student_id)
REFERENCES students(student_id)
ON DELETE CASCADE;

-- Create table for menu suggestions
CREATE TABLE IF NOT EXISTS menu_suggestions (
    suggestion_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    suggested_by INT,
    submission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (suggested_by) REFERENCES students(student_id)
);

-- Create table for storing votes on menu suggestions
CREATE TABLE IF NOT EXISTS menu_votes (
    vote_id INT AUTO_INCREMENT PRIMARY KEY,
    suggestion_id INT NOT NULL,
    voter_id INT NOT NULL,
    submission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (suggestion_id) REFERENCES menu_suggestions(suggestion_id),
    FOREIGN KEY (voter_id) REFERENCES students(student_id),
    UNIQUE KEY unique_vote (suggestion_id, voter_id)
);

-- Create table for storing the final menu
CREATE TABLE IF NOT EXISTS final_menu (
    menu_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    vote_count INT DEFAULT 0,
    UNIQUE KEY unique_item (item_name)
);

-- Create table for budget categories
CREATE TABLE IF NOT EXISTS budget_categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL,
    allocated_budget DECIMAL(10, 2) NOT NULL,
    CONSTRAINT unique_category_name UNIQUE (category_name)
);

-- Create table for expenses
CREATE TABLE IF NOT EXISTS expenses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    expense_name VARCHAR(255) NOT NULL,
    category_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    date DATE NOT NULL,
    description TEXT,
    CONSTRAINT fk_category
        FOREIGN KEY (category_id)
        REFERENCES budget_categories (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Create table for budget adjustments
CREATE TABLE IF NOT EXISTS adjustments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    adjustment_type ENUM('increase', 'decrease') NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_adjustment_category
        FOREIGN KEY (category_id)
        REFERENCES budget_categories (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Add sample data to budget_categories table
INSERT INTO budget_categories (category_name, allocated_budget)
VALUES ('Venue', 1000.00),
       ('Catering', 1500.00),
       ('Decorations', 800.00),
       ('Entertainment', 1200.00);

-- Add constraints to expenses table
ALTER TABLE expenses
ADD CONSTRAINT chk_amount_positive
    CHECK (amount >= 0);

-- Add constraints to adjustments table
ALTER TABLE adjustments
ADD CONSTRAINT chk_amount_positive_adjustments
    CHECK (amount >= 0);

-- Create table for storing task assignments
CREATE TABLE IF NOT EXISTS tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    task_name VARCHAR(255) NOT NULL,
    assignment VARCHAR(255) NOT NULL,
    status ENUM('Not Started', 'In Progress', '80% Done', 'Completed') NOT NULL,
    submission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add constraints to ensure valid task status
ALTER TABLE tasks
ADD CONSTRAINT chk_valid_status
CHECK (status IN ('Not Started', 'In Progress', '80% Done', 'Completed'));

-- Create table for attendance tracking
CREATE TABLE IF NOT EXISTS attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type ENUM('student', 'teacher') NOT NULL,
    email VARCHAR(100) NOT NULL,
    roll_no VARCHAR(20),
    family_members INT,
    notes TEXT,
    submission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create table for teachers and family registration
CREATE TABLE IF NOT EXISTS teachers_registration (
    registration_id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    family_members INT NOT NULL
);

-- Create table for storing invitations
CREATE TABLE IF NOT EXISTS invitations (
    invitation_id INT AUTO_INCREMENT PRIMARY KEY,
    recipient_type ENUM('student', 'faculty') NOT NULL,
    batch_year INT NOT NULL,
    venue VARCHAR(100) NOT NULL,
    timing VARCHAR(100) NOT NULL,
    dress_code_theme TEXT,
    submission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create table for storing recipients' information
CREATE TABLE IF NOT EXISTS recipients (
    recipient_id INT AUTO_INCREMENT PRIMARY KEY,
    recipient_name VARCHAR(100) NOT NULL,
    recipient_email VARCHAR(100) NOT NULL
);

-- Create table for storing the relationship between invitations and recipients
CREATE TABLE IF NOT EXISTS invitation_recipients (
    invitation_id INT,
    recipient_id INT,
    FOREIGN KEY (invitation_id) REFERENCES invitations(invitation_id) ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES recipients(recipient_id) ON DELETE CASCADE,
    UNIQUE KEY unique_invitation_recipient (invitation_id, recipient_id)
);