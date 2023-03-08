--****PLEASE ENTER YOUR DETAILS BELOW****
--T3-ml-alter.sql

--Student ID: Farayha Zaheer Alam
--Student Name: 31164943
--Tutorial No: 03

/* Comments for your marker:
3 (c) - another attribute named another_man_id was added to cater when the size of library is big and
additional manager was needed to manage the collections so another_man_id would be for fiction in that case
while man_id will be for reference in that case.
Otherwise, another_man_id will be null and man_id will refer to the manager whose managing the whole collection



*/

-- 3 (a)
-- adding new attribute
ALTER TABLE book_copy ADD(
    book_condition CHAR(1)
);

ALTER TABLE book_copy
MODIFY book_condition NOT NULL NOVALIDATE;

-- adding a check
ALTER TABLE book_copy
    ADD CONSTRAINT bk_condition_chk CHECK ( book_condition IN ( 'L', 'D', 'G' ) );

-- adding comment
COMMENT ON COLUMN book_copy.book_condition IS
    'Book classification - (D)amaged or (L)ost or (G)ood';

-- updating all of the instances of entity to have 'G' as by-defualt value for the particular attribute
UPDATE book_copy
SET book_condition='G';

-- update
UPDATE book_copy
SET book_condition='L'
WHERE (branch_code=(
        SELECT
            branch_code
        FROM
            branch
        WHERE 
            branch_contact_no = '0395601655') and book_call_no='005.74 C824C');

COMMIT;


-- 3 (b)
-- adding attribute
ALTER TABLE loan ADD(
    return_branch_code NUMBER(2)
);

-- for ensuring not null value not allowed
ALTER TABLE loan
MODIFY return_branch_code NOT NULL NOVALIDATE;

-- adding comment
COMMENT ON COLUMN loan.return_branch_code IS
    'Return Branch Code';

UPDATE loan 
SET return_branch_code=branch_code 
WHERE loan_actual_return_date is not Null;

COMMIT;

-- 3 (c)
-- add attribute in branch
ALTER TABLE branch ADD(
    another_man_id NUMBER(2)
    );
    
-- adding comment
COMMENT ON COLUMN branch.another_man_id IS
    'Another MANAGER ID for Fiction (if necessary)';

COMMENT ON COLUMN branch.man_id IS
    'Another MANAGER ID for Reference or All (Depends on the size)';

-- Adding FK
ALTER TABLE branch
    ADD CONSTRAINT manager_branch_another_man_id FOREIGN KEY ( another_man_id )
        REFERENCES manager ( man_id );
    
-- update branch for other collection (reference)
UPDATE branch
SET man_id=10
WHERE branch_code=(SELECT branch_code FROM branch WHERE branch_contact_no='0395413120');

-- update branch for other collection (fiction)
UPDATE branch
SET another_man_id=12
WHERE branch_code=(SELECT branch_code FROM branch WHERE branch_contact_no='0395413120');

COMMIT;

