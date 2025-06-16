--*PLEASE ENTER YOUR DETAILS BELOW*
--T1-ml-schm.sql

--Student ID: Farayha Zaheer Alam
--Tutorial No: 03

/* Comments for your marker:




*/

-- 1.1 Add Create table statments for the Missing TABLES below
-- Ensure all column comments, and constraints (other than FK's)
-- are included. FK constraints are to be added at the end of this script

-- BOOK_COPY
CREATE TABLE book_copy (
    branch_code         NUMBER(2) NOT NULL,
    bc_id               NUMBER(6) NOT NULL,
    bc_purchase_price   NUMBER(7,2) NOT NULL,
    bc_counter_reserve  CHAR(1) NOT NULL,
    book_call_no        VARCHAR2(20) NOT NULL
);

ALTER TABLE book_copy
    ADD CONSTRAINT bc_classif_chk CHECK ( bc_counter_reserve IN ( 'Y', 'N' ));

COMMENT ON COLUMN book_copy.branch_code IS
    'Branch number';

COMMENT ON COLUMN book_copy.bc_id IS
    'Branch assigned local id number';
    
COMMENT ON COLUMN book_copy.bc_purchase_price IS
    'Book Copy Purchase Price';

COMMENT ON COLUMN book_copy.bc_purchase_price IS
    'Book Reservation Status - (Y)es or (N)o';

COMMENT ON COLUMN book_copy.book_call_no IS
    'Books call number - identifies a book';
    

ALTER TABLE book_copy ADD CONSTRAINT book_copy_pk PRIMARY KEY ( branch_code, bc_id );


-- LOAN
CREATE TABLE loan (
    branch_code         NUMBER(2) NOT NULL,
    bc_id               NUMBER(6) NOT NULL,
    loan_date_time      DATE NOT NULL,
    loan_due_date       DATE NOT NULL,
    loan_actual_return_date DATE,
    bor_no              NUMBER(6) NOT NULL
);

COMMENT ON COLUMN loan.branch_code IS
    'Branch number';

COMMENT ON COLUMN loan.bc_id IS
    'Branch assigned local id number';
    
COMMENT ON COLUMN loan.loan_date_time IS
    'Loan Date Time';

COMMENT ON COLUMN loan.loan_due_date IS
    'Loan Due Date';

COMMENT ON COLUMN loan.loan_actual_return_date IS
    'Loan Actual Return Date';
    
COMMENT ON COLUMN loan.bor_no IS
    'Borrow No';

ALTER TABLE loan ADD CONSTRAINT loan_pk PRIMARY KEY ( branch_code, bc_id, loan_date_time );

-- RESERVE
CREATE TABLE reserve (
    reserve_id                  NUMBER(6) NOT NULL,
    branch_code                 NUMBER(2) NOT NULL,
    bc_id                       NUMBER(6) NOT NULL,
    reserve_date_time_placed    Date NOT NULL,
    bor_no                      NUMBER(6) NOT NULL
);

ALTER TABLE reserve ADD CONSTRAINT reserve_nk UNIQUE ( branch_code, bc_id, 
                                                        reserve_date_time_placed );
                                                        
COMMENT ON COLUMN reserve.reserve_id IS
    'Reserve ID';

COMMENT ON COLUMN reserve.branch_code IS
    'Branch number';
    
COMMENT ON COLUMN reserve.bc_id IS
    'Branch assigned local id number';

COMMENT ON COLUMN reserve.reserve_date_time_placed IS
    'Reserve Date Time Placed';

COMMENT ON COLUMN reserve.bor_no IS
    'Borrow No';

ALTER TABLE reserve ADD CONSTRAINT reserve_pk PRIMARY KEY (reserve_id);                                                        

-- Add all missing FK Constraints below here
ALTER TABLE book_copy 
    ADD CONSTRAINT book_copy_branch FOREIGN KEY ( branch_code )
        REFERENCES branch ( branch_code );
ALTER TABLE book_copy
        ADD CONSTRAINT book_copy_book_detail FOREIGN KEY ( book_call_no )
        REFERENCES book_detail ( book_call_no );
    
ALTER TABLE loan 
    ADD CONSTRAINT loan_book_copy FOREIGN KEY( branch_code, bc_id )
        REFERENCES book_copy ( branch_code, bc_id );
ALTER TABLE loan        
    ADD CONSTRAINT loan_borrower FOREIGN KEY ( bor_no )
        REFERENCES borrower ( bor_no );

ALTER TABLE reserve 
    ADD CONSTRAINT reserve_book_copy_branch_code FOREIGN KEY( branch_code )
        REFERENCES branch ( branch_code );



