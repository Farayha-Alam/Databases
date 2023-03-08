--****PLEASE ENTER YOUR DETAILS BELOW****
--T2-ml-dm.sql

--Student ID: Farayha Zaheer Alam
--Student Name: 31164943
--Tutorial No: 03

/* Comments for your marker:




*/

-- 2 (b) (i)
DROP SEQUENCE branch_code_seq;
DROP SEQUENCE bc_id_seq;

CREATE SEQUENCE branch_code_seq START WITH 10 INCREMENT BY 1;
CREATE SEQUENCE bc_id_seq START WITH 100004 INCREMENT BY 1;


-- book details insert once
INSERT INTO book_detail VALUES (
    '005.74 C824C',
    'Database Systems: Design, Implementation, and Management',
    'R',
    793,
    TO_DATE('2019', 'YYYY'),
    13
);

-- book copy insert thrice 
INSERT INTO book_copy VALUES ( 
    branch_code_seq.NEXTVAL,
    bc_id_seq.NEXTVAL,
    120.00,
    'N',
    (
        SELECT
            book_call_no
        FROM
            book_detail
        WHERE 
            book_title = 'Database Systems: Design, Implementation, and Management')
    
);

INSERT INTO book_copy VALUES ( 
    branch_code_seq.NEXTVAL,
    bc_id_seq.NEXTVAL,
    120.00,
    'N',
    (
        SELECT
            book_call_no
        FROM
            book_detail
        WHERE 
            book_title = 'Database Systems: Design, Implementation, and Management')
    
);

-- doing since branch_code 12 was not the one being granted by a copy of the book
DROP SEQUENCE branch_code_seq;
CREATE SEQUENCE branch_code_seq START WITH 13 INCREMENT BY 1;

INSERT INTO book_copy VALUES ( 
    branch_code_seq.NEXTVAL,
    bc_id_seq.NEXTVAL,
    120.00,
    'N',
    (
        SELECT
            book_call_no
        FROM
            book_detail
        WHERE 
            book_title = 'Database Systems: Design, Implementation, and Management')
    
);

COMMIT;

-- 2 (b) (ii)
-- reserve_id (Reserve table)
-- bor_no (BORROWER table)

DROP SEQUENCE reserve_id_seq;
DROP SEQUENCE bor_no_seq;

CREATE SEQUENCE reserve_id_seq START WITH 100 INCREMENT BY 1;
CREATE SEQUENCE bor_no_seq START WITH 100 INCREMENT BY 1;


-- 2 (b) (iii)
INSERT INTO borrower VALUES (
    bor_no_seq.NEXTVAL,
    'Ada',
    'LOVELACE',
    '4 Alphabet Way',
    'Alphavillas',
    '2100',
    (
        SELECT
            branch_code
        FROM
            branch
        WHERE 
            branch_contact_no = '0395413120')
);

--- Name: Ada LOVELACE
-- Home Branch: Clayton (Ph: 0395413120)
INSERT INTO reserve VALUES(
        reserve_id_seq.NEXTVAL,
            (
        SELECT
            branch_code
        FROM
            branch
        WHERE 
            branch_contact_no = '0395413120'),
            (
        SELECT
            bc_id
        FROM
            book_copy
        WHERE 
            (branch_code=(
    SELECT
        branch_code
    FROM
        branch
    WHERE
        branch_contact_no = '0395413120' and branch_name Like 'Clayton %') and book_call_no = '005.74 C824C')),
        TO_DATE('14-09-2021 3:30 PM', 'DD-MM-YYYY HH:MI PM'),
        bor_no_seq.CURRVAL   
);


COMMIT;

-- 2 (b) (iv)
-- loan (insert)
INSERT INTO LOAN VALUES(
    (
    SELECT
        branch_code
    FROM
        branch
    WHERE
        branch_contact_no = '0395413120'
    ),
    (
        SELECT
            bc_id
        FROM
            book_copy
        WHERE 
    branch_code=(
    SELECT
        branch_code
    FROM
        branch
    WHERE
        branch_contact_no = '0395413120' and branch_name Like 'Clayton %') and book_call_no = '005.74 C824C'),
        TO_DATE(('14-09-2021 12:30 PM'), 'DD-MM-YYYY HH:MI PM')+7,
        TO_DATE(('14-09-2021'), 'DD-MM-YYYY')+21,
        NULL,
    (SELECT
            bor_no
        FROM
            borrower
        WHERE
            bor_fname='Ada' and bor_lname='LOVELACE')
);

-- book_copy (update)
UPDATE book_copy
SET bc_counter_reserve='Y'
WHERE branch_code=(
    SELECT
        branch_code
    FROM
        branch
    WHERE
        branch_contact_no = '0395413120' and branch_name Like 'Clayton %') and book_call_no = '005.74 C824C';

-- reserve (delete)
DELETE FROM reserve
WHERE
    reserve_id = (
        SELECT
            reserve_id
        FROM
            reserve
        WHERE
            ( bc_id = (
                    SELECT
                        bc_id
                    FROM
                        book_copy
                    WHERE
                      branch_code = (
                SELECT
                    branch_code
                FROM
                    branch
                WHERE
                    branch_contact_no = '0395413120'
                        AND book_call_no = '005.74 C824C'
                )
              AND branch_code = (
                SELECT
                    branch_code
                FROM
                    branch
                WHERE
                    branch_contact_no = '0395413120'
            ) )));

COMMIT;



