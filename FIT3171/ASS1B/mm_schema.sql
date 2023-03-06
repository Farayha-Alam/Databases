-- Generated by Oracle SQL Developer Data Modeler 20.4.0.374.0801
--   at:        2021-09-16 16:52:47 PKT
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g
--  Name: Farayha Zaheer Alam
set echo on
SPOOL mm_schema_output.txt

DROP TABLE assessment CASCADE CONSTRAINTS;

DROP TABLE centre_details CASCADE CONSTRAINTS;

DROP TABLE class_attendance_report CASCADE CONSTRAINTS;

DROP TABLE class_staff CASCADE CONSTRAINTS;

DROP TABLE facility CASCADE CONSTRAINTS;

DROP TABLE full_attendance_report CASCADE CONSTRAINTS;

DROP TABLE ind_attendance_report CASCADE CONSTRAINTS;

DROP TABLE member_entity CASCADE CONSTRAINTS;

DROP TABLE staff__entity CASCADE CONSTRAINTS;

DROP TABLE type CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE assessment (
    test_date              DATE NOT NULL,
    staff_id               NUMBER(7) NOT NULL,
    member_weight          NUMBER(7, 2) NOT NULL,
    member_blood_pressure  NUMBER(7, 2) NOT NULL,
    member_bmi             NUMBER(7, 2) NOT NULL,
    member_vo2max          NUMBER(7, 2) NOT NULL,
    assessment_id          NUMBER(7) NOT NULL,
    member_no              NUMBER(7) NOT NULL
);

COMMENT ON COLUMN assessment.test_date IS
    'Test Date';

COMMENT ON COLUMN assessment.staff_id IS
    'Staff ID';

COMMENT ON COLUMN assessment.member_weight IS
    'Member Weight';

COMMENT ON COLUMN assessment.member_blood_pressure IS
    'Member Blood Pressure';

COMMENT ON COLUMN assessment.member_bmi IS
    'Member BMI';

COMMENT ON COLUMN assessment.member_vo2max IS
    'Member V02MAX';

COMMENT ON COLUMN assessment.assessment_id IS
    'surrogate key';

COMMENT ON COLUMN assessment.member_no IS
    'Member Number';

ALTER TABLE assessment ADD CONSTRAINT assessment_pk PRIMARY KEY ( assessment_id );

ALTER TABLE assessment ADD CONSTRAINT assessment_nk UNIQUE ( test_date,
                                                             member_no );

CREATE TABLE centre_details (
    centre_id         NUMBER(7) NOT NULL,
    centre_name       VARCHAR2(50) NOT NULL,
    centre_street     VARCHAR2(50),
    centre_town       VARCHAR2(50),
    centre_post_code  NUMBER(20),
    staff_id          NUMBER(7) NOT NULL
);

COMMENT ON COLUMN centre_details.centre_id IS
    'Centre ID';

COMMENT ON COLUMN centre_details.centre_name IS
    'Centre Name';

COMMENT ON COLUMN centre_details.centre_street IS
    'Centre Street';

COMMENT ON COLUMN centre_details.centre_town IS
    'Centre Town';

COMMENT ON COLUMN centre_details.centre_post_code IS
    'Centre Post Code';

COMMENT ON COLUMN centre_details.staff_id IS
    'Staff ID';

CREATE UNIQUE INDEX centre_details__idx ON
    centre_details (
        staff_id
    ASC );

ALTER TABLE centre_details ADD CONSTRAINT centre_details_pk PRIMARY KEY ( centre_id );

CREATE TABLE class_attendance_report (
    class_no          NUMBER(7) NOT NULL,
    centre_id         NUMBER(7) NOT NULL,
    class_duration    NUMBER(3),
    start_date        DATE NOT NULL,
    time_start        VARCHAR2(5) NOT NULL,
    num_of_sessions   NUMBER(7) NOT NULL,
    class_id          NUMBER(7) NOT NULL,
    facility_room_no  NUMBER(7) NOT NULL
);

COMMENT ON COLUMN class_attendance_report.class_no IS
    'Class Number';

COMMENT ON COLUMN class_attendance_report.centre_id IS
    'Centre ID';

COMMENT ON COLUMN class_attendance_report.class_duration IS
    'Class Duration';

COMMENT ON COLUMN class_attendance_report.start_date IS
    'Start Date';

COMMENT ON COLUMN class_attendance_report.time_start IS
    'Start Time';

COMMENT ON COLUMN class_attendance_report.num_of_sessions IS
    'Number of Sessuons';

COMMENT ON COLUMN class_attendance_report.class_id IS
    'Class ID';

ALTER TABLE class_attendance_report ADD CONSTRAINT class_report_pk PRIMARY KEY ( class_no,
                                                                                 centre_id );

CREATE TABLE class_staff (
    class_no      NUMBER(7) NOT NULL,
    staff_id      NUMBER(7) NOT NULL,
    class_leader  VARCHAR2(3) NOT NULL,
    centre_id     NUMBER(7) NOT NULL
);

ALTER TABLE class_staff
    ADD CONSTRAINT class_leader CHECK ( class_leader IN ( 'N', 'Y' ) );

COMMENT ON COLUMN class_staff.class_no IS
    'Class Number';

COMMENT ON COLUMN class_staff.staff_id IS
    'Staff ID';

COMMENT ON COLUMN class_staff.class_leader IS
    'Class Leader(Y-Yes,N- No)';

COMMENT ON COLUMN class_staff.centre_id IS
    'Centre ID';

ALTER TABLE class_staff ADD CONSTRAINT class_staff_pk PRIMARY KEY ( staff_id,
                                                                    class_no );

CREATE TABLE facility (
    facility_room_no      NUMBER(7) NOT NULL,
    centre_id             NUMBER(7) NOT NULL,
    facility_name         VARCHAR2(50),
    facility_capacity     NUMBER(7),
    facility_description  VARCHAR2(50)
);

COMMENT ON COLUMN facility.centre_id IS
    'Centre ID';

ALTER TABLE facility ADD CONSTRAINT facility_pk PRIMARY KEY ( facility_room_no,
                                                              centre_id );

CREATE TABLE full_attendance_report (
    class_no          NUMBER(7) NOT NULL,
    date_paid         DATE NOT NULL,
    total_attendance  NUMBER(7) NOT NULL,
    member_no         NUMBER(7) NOT NULL,
    centre_id         NUMBER(7) NOT NULL
);

COMMENT ON COLUMN full_attendance_report.class_no IS
    'Class Number';

COMMENT ON COLUMN full_attendance_report.date_paid IS
    'Date Paid';

COMMENT ON COLUMN full_attendance_report.total_attendance IS
    'Total Attendance';

COMMENT ON COLUMN full_attendance_report.member_no IS
    'Member Number';

COMMENT ON COLUMN full_attendance_report.centre_id IS
    'Centre ID';

ALTER TABLE full_attendance_report
    ADD CONSTRAINT full_attendance_report_pk PRIMARY KEY ( member_no,
                                                           class_no,
                                                           centre_id );

CREATE TABLE ind_attendance_report (
    class_no        NUMBER(7) NOT NULL,
    session_date    DATE NOT NULL,
    ind_attendance  NUMBER(7) NOT NULL,
    member_no       NUMBER(7) NOT NULL,
    centre_id       NUMBER(7) NOT NULL
);

COMMENT ON COLUMN ind_attendance_report.class_no IS
    'Class Number';

COMMENT ON COLUMN ind_attendance_report.session_date IS
    'Session Date';

COMMENT ON COLUMN ind_attendance_report.ind_attendance IS
    'Individual Date Attendance ';

COMMENT ON COLUMN ind_attendance_report.member_no IS
    'Member Number';

COMMENT ON COLUMN ind_attendance_report.centre_id IS
    'Centre ID';

ALTER TABLE ind_attendance_report
    ADD CONSTRAINT ind_attendance_report_pk PRIMARY KEY ( session_date,
                                                          class_no,
                                                          member_no,
                                                          centre_id );

CREATE TABLE member_entity (
    member_no         NUMBER(7) NOT NULL,
    centre_id         NUMBER(7) NOT NULL,
    member_f_name     VARCHAR2(50) NOT NULL,
    member_l_name     VARCHAR2(50) NOT NULL,
    member_street     VARCHAR2(50),
    member_town       VARCHAR2(50),
    member_post_code  NUMBER(7),
    date_of_join      DATE NOT NULL,
    member_phone_no   NUMBER(10) NOT NULL,
    member_no2        NUMBER(7)
);

COMMENT ON COLUMN member_entity.member_no IS
    'Member Number';

COMMENT ON COLUMN member_entity.centre_id IS
    'Centre ID';

COMMENT ON COLUMN member_entity.member_no2 IS
    'Member Number';

ALTER TABLE member_entity ADD CONSTRAINT member_entity_pk PRIMARY KEY ( member_no );

CREATE TABLE staff__entity (
    staff_id                 NUMBER(7) NOT NULL,
    staff_f_name             VARCHAR2(10) NOT NULL,
    staff_l_name             VARCHAR2(10) NOT NULL,
    first_aid_certification  VARCHAR2(3) NOT NULL,
    staff_phone_no           NUMBER(10) NOT NULL,
    staff_role               CHAR(1) NOT NULL,
    centre_id                NUMBER(7) NOT NULL
);

ALTER TABLE staff__entity
    ADD CONSTRAINT first_aid_certification CHECK ( first_aid_certification IN ( 'N',
    'Y' ) );

ALTER TABLE staff__entity
    ADD CONSTRAINT chk_staff_role CHECK ( staff_role IN ( 'A', 'C', 'D', 'M', 'P',
                                                          'S', 'T' ) );

COMMENT ON COLUMN staff__entity.staff_id IS
    'Staff ID';

COMMENT ON COLUMN staff__entity.staff_f_name IS
    'Staff First Name';

COMMENT ON COLUMN staff__entity.staff_l_name IS
    'Staff Last Name';

COMMENT ON COLUMN staff__entity.first_aid_certification IS
    'First Aid Certification (Y-Yes, N-No)';

COMMENT ON COLUMN staff__entity.staff_role IS
    'Staff Role (A-Administration, C- Cleaner,D-Instructor Dry, P- Instructor Pool (P),M-Manager (only one per centre), S-Sales, T-Security)';

COMMENT ON COLUMN staff__entity.centre_id IS
    'Centre ID';

ALTER TABLE staff__entity ADD CONSTRAINT staff__entity_pk PRIMARY KEY ( staff_id );

CREATE TABLE type (
    class_id     NUMBER(7) NOT NULL,
    class_type   VARCHAR2(50) NOT NULL,
    class_descp  VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN type.class_id IS
    'Class ID';

COMMENT ON COLUMN type.class_type IS
    'Class Type';

COMMENT ON COLUMN type.class_descp IS
    'Class Description
';

ALTER TABLE type ADD CONSTRAINT type_pk PRIMARY KEY ( class_id );

ALTER TABLE full_attendance_report
    ADD CONSTRAINT c_a_f_a_report FOREIGN KEY ( class_no,
                                                centre_id )
        REFERENCES class_attendance_report ( class_no,
                                             centre_id );

ALTER TABLE facility
    ADD CONSTRAINT centre_facility FOREIGN KEY ( centre_id )
        REFERENCES centre_details ( centre_id );

ALTER TABLE staff__entity
    ADD CONSTRAINT centre_staff FOREIGN KEY ( centre_id )
        REFERENCES centre_details ( centre_id );

ALTER TABLE class_attendance_report
    ADD CONSTRAINT class_a_r_type FOREIGN KEY ( class_id )
        REFERENCES type ( class_id );

ALTER TABLE class_staff
    ADD CONSTRAINT class_staff_class_a_r FOREIGN KEY ( class_no,
                                                       centre_id )
        REFERENCES class_attendance_report ( class_no,
                                             centre_id );

ALTER TABLE class_attendance_report
    ADD CONSTRAINT facility_class_a_r FOREIGN KEY ( facility_room_no,
                                                    centre_id )
        REFERENCES facility ( facility_room_no,
                              centre_id );

ALTER TABLE assessment
    ADD CONSTRAINT member_assessment FOREIGN KEY ( member_no )
        REFERENCES member_entity ( member_no );

ALTER TABLE full_attendance_report
    ADD CONSTRAINT member_f_a_report FOREIGN KEY ( member_no )
        REFERENCES member_entity ( member_no );

ALTER TABLE member_entity
    ADD CONSTRAINT member_m_entity FOREIGN KEY ( member_no2 )
        REFERENCES member_entity ( member_no );

ALTER TABLE ind_attendance_report
    ADD CONSTRAINT relation_22 FOREIGN KEY ( member_no,
                                             class_no,
                                             centre_id )
        REFERENCES full_attendance_report ( member_no,
                                            class_no,
                                            centre_id );

ALTER TABLE member_entity
    ADD CONSTRAINT relation_3 FOREIGN KEY ( centre_id )
        REFERENCES centre_details ( centre_id );

ALTER TABLE assessment
    ADD CONSTRAINT staff_assessment FOREIGN KEY ( staff_id )
        REFERENCES staff__entity ( staff_id );

ALTER TABLE centre_details
    ADD CONSTRAINT staff_centre FOREIGN KEY ( staff_id )
        REFERENCES staff__entity ( staff_id );

ALTER TABLE class_staff
    ADD CONSTRAINT staff_class FOREIGN KEY ( staff_id )
        REFERENCES staff__entity ( staff_id );

SPOOL OFF
set echo off

-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            10
-- CREATE INDEX                             1
-- ALTER TABLE                             28
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0