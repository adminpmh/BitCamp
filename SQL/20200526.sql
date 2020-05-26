--2020.05.26

-------------------------------------------------------
--DML
-------------------------------------------------------

drop table dept01;

create table dept01
as
select * from dept where 1<0;

desc dept01;
select * from dept01;

--새로운 부서 정보를 입력 : 행단위 입력
--insert into 테이블이름 (입력하고자 하는 컬럼들) values (데이터들)
--입력 컬럼의 순서와 입력데이터의 순서는 같아야 한다.
insert into dept01
(deptno, dname, loc)
values(10,'MARKETING','SEOUL')
;
insert into dept01 values (20,'DESIGN','PUSAN');
insert into dept01 values (30,'SALES','LODON');
insert into dept01 (deptno,dname) values(40,'DEV');
desc dept01;

create table dept02(
    deptno number(2)not null,
    dname VARCHAR2(20)not null,
    loc VARCHAR2(20) DEFAULT 'SEOUL'
);
insert into dept02(deptno, dname, loc) values(10,'MARKETING','SEOUL');
insert into dept02 (deptno,dname) values(40,'DEV');

--오류 
insert into dept02 (deptno,dname) values(40,'DEV','BUSAN');
insert into dept02 values(40,'DEV');

--null 값의 입력
insert into dept02 (deptno,dname,loc) values(30,'DEV',null);
insert into dept02 (deptno,dname,loc) values(30,'DEV','');

select * from dept02;

desc dept02;
--not null 확인
insert into dept02 (dname,loc) values ('TEST','loctest');
