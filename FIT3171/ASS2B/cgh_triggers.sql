/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*cgh_triggers.sql*/

/*Student ID: Farayha Zaheer Alam*/
/*Student Name: 31164943*/
/*Tutorial No: 03*/
/* Comments for your marker:




*/


/*
    Trigger1
*/
/*Please copy your trigger code with a slash(/) followed by an empty line after this line*/
DROP TABLE procs CASCADE CONSTRAINTS;

CREATE TABLE procs
    AS
        SELECT
            *
        FROM
            procedure;

CREATE OR REPLACE TRIGGER check_cost BEFORE
    INSERT OR UPDATE ON adm_prc
    FOR EACH ROW
DECLARE
    standard_cost procs.proc_std_cost%TYPE;
BEGIN
    SELECT
        p.proc_std_cost
    INTO standard_cost
    FROM
        procs p
    WHERE
        p.proc_code = :new.proc_code;

    IF ( :new.adprc_pat_cost > ( 1.20 * standard_cost ) ) THEN
        raise_application_error(-20000,
                               'The cost charged is not within +/-20% of standard procedure cost');
    END IF;

    IF ( :new.adprc_pat_cost < ( 0.80 * standard_cost ) ) THEN
        raise_application_error(-20000,
                               'The cost charged is not within +/-20% of standard procedure cost');
    END IF;

END;
/

/*Test Harness for Trigger1*/
/*Please copy SQL statements for Test Harness after this line*/

/* display before value insertion*/
SELECT
    *
FROM
    adm_prc;

/* will raise trigger -> wrong entry of adprc_pat_cost */
INSERT INTO adm_prc (
    adprc_no,
    adprc_date_time,
    adprc_pat_cost,
    adprc_items_cost,
    adm_no,
    proc_code
) VALUES (
    1030,
    TO_DATE('01/JUL/2021  04:00:00 PM', 'DD/MON/YYYY  HH12:MI:SS AM'),
    91.4,
    0,
    100020,
    32266
);

/* will raise trigger -> wrong entry of adprc_pat_cost */
UPDATE adm_prc
SET
    adprc_pat_cost = 99
WHERE
    proc_code = 43556;

/* will not raise trigger */
UPDATE adm_prc
SET
    adprc_pat_cost = 260
WHERE
    proc_code = 43556;

/* display after value insertion*/
SELECT
    *
FROM
    adm_prc;

rollback;    
/*
    Trigger2
*/
/*Please copy your trigger code with a slash(/) followed by an empty line after this line*/

CREATE OR REPLACE TRIGGER check_time BEFORE
    UPDATE ON admission
    FOR EACH ROW
DECLARE
    procedure_time  adm_prc.adprc_date_time%TYPE:=NULL;
    procedure_cost  adm_prc.adprc_pat_cost%TYPE:=0;
    item_cost       adm_prc.adprc_items_cost%TYPE:=0;
    total_cost      admission.adm_total_cost%TYPE:=0;
    no_of_rows      INT:=0;
BEGIN
    SELECT Count(*) into no_of_rows from adm_prc a where a.adm_no=:new.adm_no;
    if no_of_rows>0 then
          Select Sum(adprc_items_cost)  into item_cost from adm_prc a where a.adm_no =: new.adm_no;
           Select Max(adprc_date_time)  into procedure_time from adm_prc a where a.adm_no =: new.adm_no;  /** for getting the latest one**/
          Select Sum(adprc_pat_cost)  into procedure_cost from adm_prc a where a.adm_no =: new.adm_no;
    end if;
    IF (:new.adm_discharge < :old.adm_date_time ) THEN
         raise_application_error(-20000,
                               'the discharge time is before the time patient got admitted into hospital');       
    elsif( procedure_time is not null and :new.adm_discharge < procedure_time ) THEN
        raise_application_error(-20000,
                               'the discharge time is before the time patient got the procedure got done');  
    elsif (procedure_time is null) THEN
        total_cost := 50;
    elsif (:new.adm_discharge > :old.adm_date_time)THEN
         total_cost := procedure_cost + item_cost + 50;
    END IF;

    :new.adm_total_cost := total_cost;
END;
/








/*Test Harness for Trigger2*/
/*Please copy SQL statements for Test Harness after this line*/

/**Test 1**/
-- checking values before updating
select * from admission;
select * from adm_prc;



/** it will update adm_total_cost to 50 as procedure time is null**/
UPDATE admission
SET
    adm_discharge = TO_DATE('10/Dec/2021  08:00:00 AM', 'DD/MON/YYYY  HH12:MI:SS AM')
WHERE
    adm_no = 100280;
    
    
/** -- checking values after updating **/ 
select * from admission;    


rollback;


/** Test 2**/

/** -- checking values before updating **/ 
select * from admission;    
select * from adm_prc;

/** correct entry of data**/
INSERT INTO adm_prc (
    adprc_no,
    adprc_date_time,
    adprc_pat_cost,
    adprc_items_cost,
    adm_no,
    proc_code
) VALUES (
    1060,
    TO_DATE('04/NOV/2021  07:00:00 AM', 'DD/MON/YYYY  HH12:MI:SS AM'),
    30,
    0,
    100280,
    32266
);

UPDATE admission
SET
    adm_discharge = TO_DATE('15/Dec/2021  08:00:00 AM', 'DD/MON/YYYY  HH12:MI:SS AM')
WHERE
    adm_no = 100280;

/** -- checking values after updating **/ 
select * from admission;    
select * from adm_prc;

rollback;
/** Test 3**/
/** -- checking values before updating **/ 
select * from admission;    
select * from adm_prc;

/*incorrect entry of discharge time as discharge time before admission time - raise trigger**/
UPDATE admission
SET
    adm_discharge = TO_DATE('10/Oct/2021  08:00:00 AM', 'DD/MON/YYYY  HH12:MI:SS AM')
WHERE
    adm_no = 100280;

/** -- checking values after updating **/ 
select * from admission;    
select * from adm_prc;

rollback;
/** Test 4**/

/** -- checking values before updating **/ 
select * from admission;    
select * from adm_prc;

/*incorrect entry of discharge time as procedure time after discharge time - raise trigger**/

INSERT INTO adm_prc (
    adprc_no,
    adprc_date_time,
    adprc_pat_cost,
    adprc_items_cost,
    adm_no,
    proc_code
) VALUES (
    1060,
    TO_DATE('19/Dec/2021  07:00:00 AM', 'DD/MON/YYYY  HH12:MI:SS AM'),
    30,
    0,
    100280,
    32266
);

UPDATE admission
SET
    adm_discharge = TO_DATE('15/Dec/2021  08:00:00 AM', 'DD/MON/YYYY  HH12:MI:SS AM')
WHERE
    adm_no = 100280;
    
    
/** -- checking values after updating **/ 
select * from admission;    
select * from adm_prc;

rollback;