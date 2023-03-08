--*PLEASE ENTER YOUR DETAILS BELOW*
--T2-ml-insert.sql

--Student ID: Farayha Zaheer Alam
--Student Name: 31164943
--Tutorial No: 03


/* Comments for your marker:
Make use of the following command for checking the time alongside the date since the field(loan) 
doesn't allow time in date type format so it won't be showed otherwise
SELECT
to_char(loan_date_time, 'DD-MM-YYYY HH:MI PM')
FROM
loan;


*/

-- 2 (a) Load the BOOK_COPY, LOAN and RESERVE tables with your own
-- test data following the data requirements expressed in the brief

INSERT INTO book_copy VALUES (10, 100000, 12324.20, 'Y', '005.74 D691D');
INSERT INTO book_copy VALUES (10, 100001, 12344.20, 'N', '005.756 G476F');
INSERT INTO book_copy VALUES (10, 100002, 13455.20, 'N', '112.6 S874D');
INSERT INTO book_copy VALUES (11, 100003, 12234.22, 'N', '005.432 L761P');
INSERT INTO book_copy VALUES (12, 100000, 11010.20, 'Y','005.756 G476F');
INSERT INTO book_copy VALUES (12, 100001, 15223.78, 'N','823.914 A211H');
INSERT INTO book_copy VALUES (13, 100000, 20111.99, 'Y', '005.74 D691D');
INSERT INTO book_copy VALUES (13, 100001, 18123.25, 'Y','005.756 G476F');
INSERT INTO book_copy VALUES (13, 100002, 13455.20, 'Y','112.6 S874D');
INSERT INTO book_copy VALUES (13, 100003,  15223.78, 'Y','823.914 A211H');



-- 10 LOANS

INSERT INTO loan VALUES(10, 100000, TO_DATE('01-06-2021 10:11 AM','DD-MM-YYYY HH:MI AM'), TO_DATE('15-06-2021','DD-MM-YYYY'), TO_DATE('14-06-2021', 'DD-MM-YYYY'), 1);
INSERT INTO loan VALUES(10, 100001, TO_DATE('17-06-2021 03:00 PM','DD-MM-YYYY HH:MI PM'), TO_DATE('21-06-2021','DD-MM-YYYY'), TO_DATE('22-06-2021','DD-MM-YYYY'), 1); -- LATE
INSERT INTO loan VALUES(10, 100002, TO_DATE('01-07-2021 01:00 PM','DD-MM-YYYY HH:MI PM'), TO_DATE('15-07-2021','DD-MM-YYYY'), TO_DATE('14-07-2021','DD-MM-YYYY'), 1);
INSERT INTO loan VALUES(11, 100003, TO_DATE('01-07-2021 01:00 PM','DD-MM-YYYY HH:MI PM'), TO_DATE('15-07-2021','DD-MM-YYYY'), TO_DATE('14-07-2021','DD-MM-YYYY'), 2);
INSERT INTO loan VALUES(12, 100000, TO_DATE('01-06-2021 02:00 PM','DD-MM-YYYY HH:MI PM'), TO_DATE('15-06-2021','DD-MM-YYYY'), TO_DATE('14-06-2021', 'DD-MM-YYYY'), 4);
INSERT INTO loan VALUES(12, 100001, TO_DATE('17-06-2021 10:30 AM','DD-MM-YYYY HH:MI AM'), TO_DATE('21-06-2021','DD-MM-YYYY'), TO_DATE('22-06-2021','DD-MM-YYYY'), 4);  -- LATE
INSERT INTO loan VALUES(13, 100000, TO_DATE('01-08-2021 11:00 AM', 'DD-MM-YYYY HH:MI AM'), TO_DATE('15-08-2021', 'DD-MM-YYYY'), TO_DATE('14-08-2021', 'DD-MM-YYYY'), 5);
INSERT INTO loan VALUES(13, 100001, TO_DATE('01-09-2021 04:00 PM', 'DD-MM-YYYY HH:MI PM'), TO_DATE('15-09-2021', 'DD-MM-YYYY'), TO_DATE('14-09-2021', 'DD-MM-YYYY'), 5);
INSERT INTO loan VALUES(13, 100002, TO_DATE('02-09-2021 04:00 PM', 'DD-MM-YYYY HH:MI PM'), TO_DATE('14-09-2021', 'DD-MM-YYYY'), NULL, 5); -- Not returned back yet
INSERT INTO loan VALUES(13, 100003, TO_DATE('04-09-2021 04:00 PM', 'DD-MM-YYYY HH:MI PM'), TO_DATE('16-09-2021', 'DD-MM-YYYY'), NULL, 5); -- Not returned back yet



-- 2 RESERVE entries 
INSERT INTO reserve VALUES(98,10,100000,TO_DATE('01-06-2021 10:15 PM', 'DD-MM-YYYY HH:MI PM'),1);
INSERT INTO reserve VALUES(99,11,100002,TO_DATE('01-07-2021 11:00 AM', 'DD-MM-YYYY HH:MI AM'),2);



COMMIT;