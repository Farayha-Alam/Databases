/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*cgh_queries.sql*/

/*Student ID: Farayha Zaheer Alam*/
/*Student Name: 31164943*/
/*Tutorial No: 03*/

/* Comments for your marker:
In question 7, I am under the impression that we do not need to include the technicians charging for any procedure
since the first line refers to the doctor itself so i added this line
WHERE a.PERFORM_DR_ID is not NULL for removal of technicians




*/


/*
    Q1
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon*/
/* (;) at the end of this answer*/

SELECT
    doctor_title,
    doctor_fname,
    doctor_lname
FROM
         cgh.doctor d
    JOIN cgh.doctor_speciality    s ON d.doctor_id = s.doctor_id
    JOIN cgh.speciality           p ON s.spec_code = p.spec_code
WHERE
    upper(spec_description) = 'ORTHOPEDIC SURGERY'
ORDER BY
    doctor_lname,
    doctor_fname;

/*
    Q2
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/
SELECT
    i.item_code,
    i.item_description,
    c.cc_title AS "CC_Title"
FROM
         cgh.costcentre c
    JOIN cgh.item i ON c.cc_code = i.cc_code
WHERE
        item_stock > 50
    AND lower(item_description) LIKE '%disposable%'
ORDER BY
    item_code;

/*
    Q3
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this */

SELECT
    p.patient_id,
    p.patient_fname
    || ' '
    || p.patient_lname     AS "Patient Name",
    a.adm_date_time        AS "Admission Date Time",
    d.doctor_fname
    || ' '
    || d.doctor_lname      AS "Doctor Name"
FROM
         cgh.admission a
    JOIN cgh.doctor     d ON d.doctor_id = a.doctor_id
    JOIN cgh.patient    p ON a.patient_id = p.patient_id
WHERE
    adm_date_time BETWEEN TO_DATE('11-09-2021 10:00 AM', 'DD-MM-YYYY HH:MI AM') AND
    TO_DATE('14-09-2021 06:00 PM', 'DD-MM-YYYY HH:MI PM')
ORDER BY
    adm_date_time;
    
/*
    Q4
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/
SELECT
    proc_code,
    proc_name,
    proc_description,
    to_char(proc_std_cost, '$9999.99')
FROM
    cgh.procedure
WHERE
    proc_std_cost < (
        SELECT
            AVG(proc_std_cost)
        FROM
            cgh.procedure
    )
ORDER BY
    proc_std_cost DESC;

/*
    Q5
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/

SELECT
    p.patient_id,
    p.patient_lname || ''     AS "Patient Last Name",
    p.patient_fname || ''     AS "Patient First Name",
    p.patient_dob,
    COUNT(a.patient_id)       AS count_admission_number
FROM
         cgh.admission a
    JOIN cgh.patient p ON a.patient_id = p.patient_id
GROUP BY
    p.patient_id,
    p.patient_lname,
    p.patient_fname,
    p.patient_dob
HAVING
    COUNT(a.patient_id) > 2
ORDER BY
    count_admission_number DESC,
    patient_dob;


/*
    Q6
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/


SELECT
    adm_no,
    CASE
        WHEN to_char(adm_discharge, 'HH24') - to_char(adm_date_time, 'HH24') < 0 THEN
            to_char((EXTRACT(DAY FROM to_date(adm_discharge, 'DD-MM-YYYY HH:MI PM')) -(
            EXTRACT(DAY FROM to_date(adm_date_time, 'DD-MM-YYYY HH:MI PM')))) - 1,
                    '999')
            || ' days'
            || to_char(to_char(adm_discharge, 'HH24') +(24 - to_char(adm_date_time,
            'HH24')),
                       '99.9')
            || ' hours'
        ELSE
            to_char((EXTRACT(DAY FROM to_date(adm_discharge, 'DD-MM-YYYY HH:MI PM')) -(
            EXTRACT(DAY FROM to_date(adm_date_time, 'DD-MM-YYYY HH:MI PM')))),
                    '999')
            || ' days'
            || to_char(to_char(adm_discharge, 'HH24') - to_char(adm_date_time, 'HH24'),
                       '90.9')
            || ' hours'
    END AS length_of_stay
FROM
         cgh.admission a
    JOIN cgh.patient p ON a.patient_id = p.patient_id
WHERE
    adm_discharge IS NOT NULL
    AND adm_no IN (
        SELECT
            adm_no
        FROM
            cgh.admission
        WHERE
            adm_discharge - adm_date_time > (
                SELECT
                    AVG(adm_discharge - adm_date_time)
                FROM
                    cgh.admission
            )
    )
ORDER BY
    adm_no;

/*
    Q7
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/

SELECT
    p.proc_code,
    p.proc_name,
    p.proc_description,
    p.proc_time,
    to_char(p.proc_std_cost, 999.99)          AS proc_std_cost,
    CASE
        WHEN AVG(adprc_pat_cost) > proc_std_cost     THEN
            to_char(AVG(adprc_pat_cost) - proc_std_cost, 999.99)
        WHEN AVG(adprc_pat_cost) = proc_std_cost     THEN
            '0.00'
        ELSE
            to_char(AVG(adprc_pat_cost) - proc_std_cost, 999.99)
    END                                       AS "Procedure Price Differential"
FROM
         cgh.procedure p
    JOIN cgh.adm_prc a ON p.proc_code = a.proc_code
WHERE
    a.perform_dr_id IS NOT NULL
GROUP BY
    p.proc_code,
    p.proc_name,
    p.proc_description,
    p.proc_time,
    p.proc_std_cost
ORDER BY
    p.proc_code;



/*
    Q8
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/

SELECT
    p.proc_code,
    p.proc_description,
    nvl(t.item_code, '---')                              AS item_code,
    nvl(i.item_description, '---')                       AS item_description,
    nvl(to_char(MAX(t.it_qty_used)), '---')              AS max_quantity
FROM
    cgh.procedure         p
    LEFT JOIN cgh.adm_prc           a ON p.proc_code = a.proc_code
    LEFT JOIN cgh.item_treatment    t ON a.adprc_no = t.adprc_no
    LEFT JOIN cgh.item              i ON i.item_code = t.item_code
GROUP BY
    p.proc_code,
    p.proc_description,
    t.item_code,
    i.item_description
ORDER BY
    p.proc_description,
    t.item_code;
    
/*
    Q9a (FIT2094 only) or Q9b (FIT3171 only)
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/


SELECT
    s.adprc_no,
    s.proc_code,
    s.adm_no,
    d.patient_id,
    to_char(s.adprc_date_time, 'DD-MM-YYYY HH24:MI')        AS adprc_date_time,
    MAX(adprc_pat_cost + adprc_items_cost)                    AS total_cost
FROM
         cgh.adm_prc s
    JOIN cgh.admission d ON s.adm_no = d.adm_no
WHERE
    9 - 1 = (
        SELECT
            COUNT(DISTINCT s2.adprc_pat_cost + s2.adprc_items_cost)
        FROM
            cgh.adm_prc s2
        WHERE
            s2.adprc_pat_cost + s2.adprc_items_cost > s.adprc_pat_cost + s.adprc_items_cost
    )
GROUP BY
    s.adprc_no,
    s.proc_code,
    s.adm_no,
    d.patient_id,
    s.adprc_date_time
ORDER BY
    s.adprc_no;    