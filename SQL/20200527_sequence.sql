--2020.05.27

--------------------------------------------------------------
--sequence : 번호 자동 생성기
--------------------------------------------------------------

--create sequence 시퀀스이름
--start with 시작값 0 시작   *
--increment by 증가값 1     *
--maxvalue 최대값           *
--minvalue 최소값
--cycle | nocycle 반복 여부
--cache | nocache

--부서번호 deptno 의 sequence 생성
create sequence dept_deptno_seq01;

select dept_deptno_seq01.nextval
from dual;

select dept_deptno_seq01.currval
from dual;