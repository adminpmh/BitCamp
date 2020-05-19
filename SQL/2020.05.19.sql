--2020.05.19

--특정 데이터를 추출하기 : where 절을 이용
--select 컬럼명 from 테이블 이름 where 조건 (true/false)

select ename, sal from emp where sal >=3000; --전체 사원중의 월 급여가 3000 이상인 사원의 리스트

select ename,job from emp where deptno=10; --전체 사원 중 10번 부서의 소속 사원의 이름과 직급을 출력

select * from emp where deptno = 10; --컬럼의 값과 일치 여부 확인 : =

select * from emp where job ='MANAGER'; --문자열 표현 : '작은 따움표로 묶는다.

select * from emp where ENAME = 'SCOTT';

select * from emp where hiredate ='80-12-17'; --날짜를 비교할 때 ->'작은 따움표'

--논리 연산자 : and 
--10번 부서 소속인 사원들 중에서 직급이 MANAGER인 사람을 검색하여 사원명, 부서번호, 직급을 출력
select ename,deptno,job from emp where deptno=10 and job='MANAGER';

--논리 연산자 : or
--10번 부서 소속인 사원들 중에서 직급이 MANAGER인 사람을 검색하여 사원명, 부서번호, 직급을 출력
select ename,deptno,job from emp where deptno=10 or job='MANAGER';

--논리 연산자 : not
--10번 부서 소속인 사원들 중에서 직급이 MANAGER인 사람을 검색하여 사원명, 부서번호, 직급을 출력
select ename,deptno,job from emp where not deptno=10 and not job='MANAGER';

--범위 연산 : 논리연산의 사용 and
--2000에서 3000 사이의 급여를 받는 사원의 정보를 출력
select * from emp where sal>=2000 and sal<=3000;

--범위 연산자 : 컬럼명 between A and B -> A이상 B이하
--2000에서 3000 사이의 급여를 받는 사원의 정보를 출력
select * from emp where sal BETWEEN 2000 and 3000;

--2000을 초과 하고 3000미만의 급여를 받는 사원
select ename,sal from emp where sal>2000 and sal<3000;
--select ename,sal from emp where sal between 20001 and 29999;

--1987년 입사자 리스트를 출력
--select * from emp where hiredate >='1987-01-01';
--select * from emp where hiredate>='1981-01-01' and hiredate<='1981-12-31';
select * from emp where hiredate BETWEEN '1981-01-01' and '1981-12-31';

--or 연산을 간소화 시키는 IN 연산자
--컬럼 이름 IN(데이터1, 데이터2, 데이터3, ...)
--컬럼 =데이터1 or 컬럼 = 데이터2 or 컬럼 = 데이터3 or...

--커미션이 300 이거나 500이거나 1400인 사원을 검색하기 위해서 In 연산자를 사용
--select * from emp where comm=300 or comm=500 or comm=1400;
select * from emp where comm in(300, 500, 1400);

--패턴 검색 : like 연산자 
--컬럼이름 like 패턴
--패턴 : %, _
--% -> 0개 이상 문자열이 가능하다  'S%' : S로 시작하는 문자열, '%S' : S로 끝나는 문자열, '%S%' : s 포함하는 문자열
--이름이 s로 시작하는 사원 리스트
SELECT *FROM emp where ename like 's';
SELECT *FROM emp where ename like 'S%';
SELECT *FROM emp where ename like '%N';
SELECT *FROM emp where ename like '%AR%';

--_ -> 1개의 자리수에 어떠한 문자가 와도 가능하다.
select * from emp where ename like '_A%';
select * from emp where ename like '__A%';
select * from emp where ename like '%E_';
select * from emp where ename not like '%L_';

--null 값 할인을 위한 연산자 : is null, is not null
--컬럼명 is null : 해당 컬럼의 값이 null 인 경우 true
--컬럼명 is not null : 해당 컬럼의 값이 null이 아닌경우 true
select comm,ename from emp where comm is null;
select comm,ename from emp where comm is not null;

--row의 정렬 
--오름차순 :작은쪽에서 ->큰쪽으로, asc(생략가능, 기본값)
--내림차순 :큰쪽에서 ->작은쪽으로 desc(명시적 사용)
select ename, sal, hiredate, comm from emp where empno>0 ORDER by ename asc;    --문자의 오름차순
select ename, sal, hiredate, comm from emp where empno>0 ORDER by ename;         --문자의 오름차순, ASC 생략
select ename, sal, hiredate, comm from emp where empno>0 ORDER by ename desc;     --문자의 내림차순,
select ename, sal, hiredate, comm from emp where empno>0 ORDER by sal ;            --숫자의 내림차순,
select ename, sal, hiredate, comm from emp where empno>0 ORDER by hiredate desc ;   --날짜의 내림차순,
select ename, sal, hiredate, comm from emp where empno>0 ORDER by comm desc ;       --null 내림차순,
select ename,sal from emp order by sal desc,ename asc;
select ename,deptno from emp order by deptno,ename;

EMP 테이블과 DEPT 테이블을 이용해서 풀이해 주세요.

1. 덧셈연산자를 이용하여 모든 사원에 대해서 $300의 급여 인상을 계산한 후 사원의 이름, 급여, 인상된 급여를 출력하시오.
select ename, sal, sal+300 as addsal from emp;

2. 사원의 이름, 급여, 연간 총 수입을 총 수입이 많은 것부터 작은 순으로 출력하시오, 연간 총수입은 월급에 12를 곱한 후 $100의 상여금을 더해서 계산하시오.
select ename, sal , sal*12+100 as year from emp order by year desc;

3. 급여가 2000을 넘는 사원의 이름과 급여를 표현, 급여가 많은 것부터 작은 순으로 출력하시오.
select ename, sal from emp where sal>2000 order by sal asc;

4. 사원번호가 7788인 사원의 이름과 부서번호를 출력하시오.
select ename,empno from emp where empno = 7788;

5. 급여가 2000에서 3000 사이에 포함되지 않는 사원의 이름과 급여를 출력하시오.
select ename,sal from emp where sal<2000 or sal>3000;

6. 1981년 2월 20일 부터 1981년 5월 1일 사이에 입사한 사원의 이름, 담당업무, 입사일을 출력하시오.
select ename,job,hiredate from emp where hiredate>='1981-02-20' and hiredate<='1981-05-01';

7. 부서번호가 20 및 30에 속한 사원의 이름과 부서번호를 출력, 이름을 기준(내림차순)으로 영문자순으로 출력하시오.
select ename, deptno from emp where deptno>=20 and deptno<=30 order by ename desc; 

8. 사원의 급여가 2000에서 3000사이에 포함되고 부서번호가 20 또는 30인 사원의 이름, 급여와 부서번호를 출력, 이름순(오름차순)으로 출력하시오.
select ename, sal, deptno from emp where (sal>=2000 and sal<=3000) and (deptno=20 or deptno=30) order by ename asc;

9. 1981년도에 입사한 사원의 이름과 입사일을 출력하시오. (like 연산자와 와일드카드 사용)
select ename,hiredate from emp where hiredate like '81%';
--select ename,hiredate from emp where hiredate like '_1%' or hiredate like '_7%'or hiredate like '_2%';

10. 관리자가 없는 사원의 이름과 담당 업무를 출력하시오.
--select ename, job from emp where job ! = 'MANAGER';
select ename, job from emp where mgr is null;

11. 커미션을 받을 수 있는 자격이 되는 사원의 이름, 급여, 커미션을 출력하되 급여 및 커미션을 기준으로 내림차순 정렬하여 표시하시오.
select ename, sal, comm from emp where comm is not null order by sal desc,comm desc;

12. 이름의 세번째 문자가 R인 사원의 이름을 표시하시오.
select ename from emp where ename like '__R%';

13. 이름에 A와 E를 모두 포함하고 있는 사원의 이름을 표시하시오.
select ename from emp where ename like '%A%' and ename like '%E%';

14. 담당업무가 CLERK, 또는 SALESMAN이면서 급여가 $1600, $950 또는 $1300이 아닌 사원의 이름, 담당업무, 급여를 출력하시오.
select ename,job,sal from emp where (job = 'CLERK' or job = 'SALESMAN') and (sal!=1600 and sal!=950 and sal!=1300);

15. 커미션이 $500 이상인 사원의 이름과 급여 및 커미션을 출력하시오.
select ename,sal,comm from emp where comm>500;


select * from tab;
desc book;
desc costomer;
desc orders;
select * from book;
select * from customer;
select * from orders;


1 마당서점의고객이요구하는다음질문에대해SQL 문을작성하시오.
(1) 도서번호가1인도서의이름
select bookname from book where bookid = 1;

(2) 가격이20,000원이상인도서의이름
select bookname,price from book where price>=20000;

--(3) 박지성의총구매액(박지성의고객번호는1번으로놓고작성)

--(4) 박지성이구매한도서의수(박지성의고객번호는1번으로놓고작성)



2 마당서점의운영자와경영자가요구하는다음질문에대해SQL 문을작성하시오.
--(1) 마당서점도서의총개수
--(2) 마당서점에도서를출고하는출판사의총개수

(3) 모든고객의이름, 주소
select name,address from customer;

(4) 2014년7월4일~7월7일사이에주문받은도서의주문번호
select orderid,orderdate from orders where orderdate>='2014-07-04' and orderdate<='2014-07-07';

(5) 2014년7월4일~7월7일사이에주문받은도서를제외한도서의주문번호
select orderid,orderdate from orders where not (orderdate >='2014-07-04' and orderdate <='2014-07-07');
select orderid,orderdate from orders where orderdate not BETWEEN '2014-07-04'  and '2014-07-07';

(6) 성이‘김’씨인고객의이름과주소
select name,address from customer where name like '김%';

(7) 성이‘김’씨이고이름이‘아’로끝나는고객의이름과주소
select name,address from customer where name like '김%' or name like '__아';


