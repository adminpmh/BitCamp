--2020.05.25


---------------------------------------------------------------------
--DDL
---------------------------------------------------------------------

--테이블 생성
--create table 테이블의 이름() <- 괄호 안에 컬럼을 정의
--( 컬럼명1 타입 (사이즈),컬럼명2 타입(사이즈), ...)

--ddl_test 라는 이름의 테이블을 생성
--컬럼1 : no 숫자타입 사이즈는 3
--컬럼2 : name, 가변 문자열 저장, 사이즈 10
--컬럼3 : birth, 날짜 타입, 기본값은 현재시간

create table ddl_test(
    no number(3),
    name VARCHAR(10),
    birth date DEFAULT sysdate
);

select *
from ddl_test
;


insert into ddl_test(no,name)VALUES(1,'scott');

--1.1데이터 형
--CHAR(size) : 고정 길이 문자 데이터. VARCHAR2와 동일한 형태의 자료를 저장할 수 있고, 입력된 자료의 길이와는 상관없이 정해진 길이만큼 저장 영역 차지. 최소 크기는 1
--VARCHAR2(size) : Up to 2000 Bytes 가변 길이 문자 데이터. 실제 입력된 문자열의 길이만큼 저장 영역을 차지. 최대 크기는 명시해야 하며, 최소 크기는 1 (게시물 : 제목)
--NUMVER(w, d) : W는 전체 길이, d는 소수점 이하 자릿수이다. 소수점은 자릿수에 포함되지 않는다.
--DATE : BC 4712년 1월 1일~AD 4712년 12월 31일까지의 날짜
--LONG : 가변 길이의 문자형 데이터 타입, 최대 크기는 2GB (게시물 : 내용)
--TIMESTAMP(n) : DATE 형의 확장된 형태

--emp 테이블 참조 
--사원번호, 사원이름, 급여 3개의 칼럼으로 구성된
--EMP01 테이블을 생성해 보자
desc emp;

create table emp01(
    empno number(4),
    ename VARCHAR2(10),
    sal number(7,2)
);

select * from tab;
desc emp01;

--테이블의 복사 : 서브 쿼리 이용 
--스키마 복사, 행 복사, 제약조건의 복사는 되지 않는다.

create table emp02
as
select * from emp;

select * from tab;
desc emp02;
select * from emp02;

-- emp 테이블의 empno와 ename 컬러만 복사해서 
--새로운 테이블 emp03 생성하자

create table emp03
as
select empno,ename from emp;

desc emp03;
select * from emp03;

--emp 테이블의 10번 부서의 데이터만 복사해서 새로운 테이블
--emp04 테이블을 생성하자

CREATE table emp04
as
select * from emp where deptno = 10
;
select * from emp04;

--emp 테이블의 스키마 구조만 복사해서 새로운 테이블
--emp05 생성하자
create table emp05
as
select * from emp where 1<0
;
select * from emp05;

--테이블에 컬럼 추가
--alter table 테이블 이름 add(컬럼정의)

--emp01 테이블에 직급(job) 컬럼을 추가하자
desc emp01;

alter table emp01
add(job VARCHAR2(10))
;

--컬럼의 변경
--alter table 테이블이름 modify (컬럼정의)
--직급(JOB) 칼럼을 최대 30글자까지 저장할 수 있게 변경해 보도록 하자.

alter table emp01
modify(job VARCHAR(30)not null)
;
desc emp01;

--컬럼의 삭제
--alter table 테이블이름 drop column 컬럼이름
alter table emp01 drop column sal;
desc emp01;

--테이블 객체 삭제
--drop table 테이블이름;
drop table emp01;

select * from tab;
desc emp01;

TRUNCATE table emp02;
select * from emp02;

--테이블 이름의 변경
--rename 현재 테이블 이름 to 새로운 테이블 이름

rename emp02 to test_emp;
select * from tab;

--무결성 제약조건의 개념과 종류
--NOT NULL : NULL을 허용하지 않는다.
--UNIQUE : 중복된 값을 허용하지 않는다. 항상 유일한 값을 갖도록 한다.
--PRIMARY KEY  : NULL을 허용하지 않고 중복된 값을 허용하지 않는다. NOT NULL 조건과 UNIQUE 조건을 결합한 형태이다.
--FOREIGN KEY  : 참조되는 테이블의 칼럼의 값이 존재하면 허용한다.
--CHECK : 저장 가능한 데이터 값의 범위나 조건을 지정하여 설정한 값만을 허용한다

desc dept;
insert into dept VALUES(10,'test','seoul');

--컬럼의 제약 정의는 컬럼 정의를 하면서 컬럼 옆에 정의
--컬럼의 타입을 모두 정의하고, 아래에 제약을 정의하는 방법

--create table emp01(
    --empno number(4) not null
--)

--create table emp01(
    --empno number(4),
    --primary key(empno)
--)

--not null 제약 : 컬럼의 값에 null 값이 허용하지 않는다.
--컬럼 레벨에서만 정의가 가능

--사원 테이블(EMP02)을 
--사원번호, 사원명, 직급, 부서번호 4개의 칼럼으로 구성하되 
--이번에는 사원번호와 사원명에 NOT NULL 조건을 지정하도록 합시다.
drop table emp02;

create table emp02(
    empno number(4) not null,
    ename VARCHAR2(10) not null,
    job VARCHAR2(10),
    deptno number(2)
);
desc emp02;

insert into emp02 values (null, null,'MANAGER',10);
insert into emp02 values (111, null,'MANAGER',10);
insert into emp02 values (111, 'SON','MANAGER',10);
select * from emp02;

drop table emp03;

create table emp03(
    empno number(4) unique,
    ename VARCHAR2(10) not null,
    job VARCHAR2(10),
    deptno number(2)
);

create table emp03(
    empno number(4) unique not null,
    ename VARCHAR2(10) not null,
    job VARCHAR2(10),
    deptno number(2)
);

desc emp03;
insert into emp03 VALUES(1111,'test','MANAGER',10);
insert into emp03 VALUES(1111,'test123','MANAGER',20);
insert into emp03 VALUES(null,'test123','MANAGER',20);
select * from emp03;

--사원번호, 사원명, 직급, 부서번호 4개의 칼럼으로 구성된
--EMP04 테이블을 생성하되 
--사원번호에는 유일키로 사원명은 NOT NULL 제약조건을 설정해 봅시다.
drop table emp04;
create table emp04(
    empno number(4) CONSTRAINT emp04_empno_uk unique CONSTRAINT emp04_empno_nn not null,
    ename VARCHAR2(10) CONSTRAINT emp04_ename_nn not null,
    job VARCHAR2(10),
    deptno number(2)
);

desc emp04;
insert into emp04 VALUES(1111,'test','MANAGER',10);
insert into emp04 VALUES(1111,'test123','MANAGER',20);
insert into emp04 VALUES(null,'test123','MANAGER',20);
select * from emp04;

--사원번호, 사원명, 직급, 부서번호 4개의 칼럼으로 구성된 
--테이블을 생성하되 기본 키 제약 조건을 설정해 봅시다.
drop table emp05;
create table emp05(
    empno number(4) CONSTRAINT emp05_empno_pk PRIMARY key,
    ename VARCHAR2(10)CONSTRAINT emp05_ename_nn not null,
    job VARCHAR2(9),
    deptno number(2)
);
desc emp05;
insert into emp05 VALUES(1111,'test','MANAGER',10);
insert into emp05 VALUES(1111,'test123','MANAGER',20);
insert into emp05 VALUES(null,'test123','MANAGER',20);
select * from emp05;

--사원번호, 사원명, 직급, 부서번호 4개의 칼럼으로 구성된 
--테이블을 생성하되 기본 키 제약 조건을 설정해 봅시다.
--deptno 외래키로 제약조건을 설정

drop table emp06;
create table emp06(
    empno number(4) CONSTRAINT emp06_empno_pk PRIMARY key,
    ename VARCHAR2(10)CONSTRAINT emp06_ename_nn not null,
    job VARCHAR2(9),
    deptno number(2) CONSTRAINT emp06_deptno_fk REFERENCES dept(deptno)
);
desc emp06;
insert into emp06 VALUES(1111,'test','MANAGER',10);
insert into emp06 VALUES(1111,'test123','MANAGER',20);
insert into emp06 VALUES(null,'test123','MANAGER',20);
insert into emp06 VALUES(2222,'test123','MANAGER',null);
select * from emp06;

--사원번호, 사원명, 직급, 부서번호, 직급, 성별,생일 7개의 칼럼으로 
--구성된 테이블을 생성하되 
--기본 키 제약 조건, 외래키 제약 조건은 물로 
--CHECK 제약 조건도 설정해 봅시다.
--default 제약 birthday sysdate로 입력되도록 처리
CREATE TABLE EMP07(
    EMPNO NUMBER(4) CONSTRAINT EMP07_EMPNO_PK PRIMARY KEY,
    ENAME VARCHAR2(10) CONSTRAINT EMP07_ENAME_NN NOT NULL,
    JOB VARCHAR2(10) DEFAULT 'MANAGER',
    DEPTNO NUMBER(2) CONSTRAINT EMP07_DEPTNO_FK REFERENCES DEPT(DEPTNO),
    GENDER CHAR(1) CONSTRAINT EMP07_GENDER_CK CHECK (GENDER='M' OR GENDER='F'),
    SAL NUMBER(7,2) CONSTRAINT EMP07_SAL_CK CHECK (SAL BETWEEN 500 AND 5000),
    BIRTHDAY DATE DEFAULT SYSDATE
);

INSERT INTO EMP07 VALUES (1111, 'TEST', NULL, 10, 'F', 600, NULL);
INSERT INTO EMP07 VALUES (1112, 'TEST', NULL, 10, 'M', 600, NULL);

INSERT INTO EMP07 (EMPNO, ENAME, DEPTNO, GENDER, SAL) 
           VALUES (1113, 'TEST', 10, 'F', 1600);

SELECT * FROM EMP07;