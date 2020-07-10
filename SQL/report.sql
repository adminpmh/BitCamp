--report

CREATE table report(
    idx number(4) PRIMARY KEY,
    sname VARCHAR2(20) not null,
    sno VARCHAR(10) not null,
    reportfile VARCHAR2(100) not null
);

CREATE SEQUENCE report_seq;

INSERT into report values(report_seq.nextval,'길동','1234','/file/123123_report.ppt');

select * from report;