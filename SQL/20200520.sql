--2020.05.20 : 마당서점 추가 문제

--숫자함수
select mod(sal,3) from emp; --나머지
select abs(sal) from emp; --절대값
select trunc(1282.23,1) from dual; --**인자로 받은 날짜를 특정 기준으로 버린다.
select trunc(sal,-3) from emp;  -- 음수 일때 정수 자리 절삭
select round(1282.23,1) from dual; --**인자로 받은 날짜를 특정 기준으로 반올림한다
select sysdate from dual;

--To_ChAR 함수 : 날짜형 혹은 숫자형을 문자형으로 변환한다.
--date ->varchar2 
select sysdate, to_char(sysdate,'YYYY.MM.DD') from dual; 
select ename,hiredate, to_char(hiredate,'YYYY.MM.DD') as hiredata from emp;  
select sysdate, to_char(sysdate,'HH24:MI:SS') from dual;    --현재시간

--2020.05.20. 11:26
select to_char(sysdate,'YYYY.MM.DD. HH24:MI') as TODAYTIME from dual;      
--To_ChAR
--date ->varchar2
select to_char(12500,'000,000') from dual;
select to_char(12500,'L999,999') from dual; --통화 표현

select sal, to_char(sal*1000,'L999,999,999'),to_char(sal*1000*12+nvl(comm,0),'999,999,999')as Income from emp order by income desc;
--연봉 계산

--TO_DATE 함수 : 문자형을 날짜형으로 변환한다
--TO_DATE(원본,패턴)
--str -> date
select to_date('19810220','YYYYMMDD')from dual;
select to_date('1981/02/20','YYYY/MM/DD')from dual;
select ename,hiredate from emp where hiredate = TO_DATE('1981/02/20','YYYY/MM/DD');
select sysdate, TO_DATE('20201225','YYYYMMDD'),trunc (TO_DATE('20201225','YYYYMMDD')-sysdate) from dual;
select sysdate,trunc(sysdate-to_date('20120517','YYYYMMDD')) from dual;

--TO_NUMBER 함수 : 문자형을 숫자형으로 변환한다.
--TO_NUMBER(원본,'패턴')
--str ->number : 산술연산을 목적으로 변환
select to_number('20,000','999,999') -to_number('10,000','999,999')from dual; --첫번째 자리수 표현에 따라 두번째 자리수 증가

--DECODE 함수 : if switch 구문과 유사
select ename,deptno, deptno(deptno,10,'ACCOUNTING',20,'RESEARCH',30,'SALES',40,'OPERATING')as deptName from emp;

--직급에 따라 급여를 인상하도록 하자. 
--직급이 'ANAlYST'인 사원은 5%,
--'SALESMAN'인 사원은 10%, 
--'MANAGER'인 사원은 15%, 
--'CLERK'인사원은 20%인 인상한다. 
select ename,sal,decode(job,'ANAlYST',sal+sal*0.05,'SALESMAN',sal+sal*0.1,'MANAGER',sal+sal*0.15,'CLERK',sal+sal*0.2) as upsal from emp;
select ename, deptno,
case
    when deptno = 10 then 'ACCOUNTING'
    when deptno = 20 then 'RESEARCH'
    when deptno = 30 then 'SALES'
    when deptno = 40 then 'OPERATIONS'
end as dname

from emp;

-----------------------------------------
--그룸함수 (집합함수)
-----------------------------------------
--sum, avg, count, max, min

--sum(컬럼이름) : 해당 컬럼의 데이터들의 합 반환
--매월 지급되는 급여의 총 합
select sum(sal) as totalsa
from emp;

select to_char(sum(sal)*1000,'L999,999,999') as totalsa
from emp;

select sum(comm)
from emp;

--avg(컬럼명) : 해당 컬럼의 데이터들의 평균값을 반환
select trunc(avg(sal))
from emp;

select sum(comm) from emp;

select avg(comm)
from emp;

select * from emp order by comm;

--MAX, MIN : 해당 컬럼의 데이터중에서 최대값, 최소값을 반환
select max(sal),min(sal),max(comm),min(comm)
from emp;

--count(컬럼명 or *) : 행 (row)의 개수를 반환
select count(*)
from emp;

select count(comm) from emp; --null을 포함하는 행은 개수로 포함하지 않는다.
select count(job) from emp;
select count(DISTINCT job) from emp order by job; --DISTINCT : 중복제거

--group by 절 : 특정 컬럼으로 그룹핑을 해준다.
select deptno
from emp
group by deptno;

--소속 부서별 평균 급여 구하는 예제
select deptno,round(avg(sal),0)
from emp
group by deptno;

--소속 부서별 최대 급여와 최소 급여를 구하자
select deptno,max(sal),min(sal)
from emp
group by deptno;

--부서별로 사원 수와 커미션을 받는 사원들의 수를 계산하는 예제
select deptno,count(*),count(comm)
from emp
where comm<> 0
group by deptno;

--부서별 
--평균 급여가 2000 이상인(having)
--부서번호와 부서별 평균 급여를 출력
select deptno,avg(sal),count(*),count(comm),sum(comm)
from emp
group by deptno having avg(sal)<=2000;

--직급별, 지표 출력
select job,count(*) as"직급별 인원",
            sum(sal)as"직급별 월 총 급여",
            trunc(avg(sal)) as"직급별 월 평균 급여",
            nvl(sum(comm),0) as "직급별 수령 커미션의 총 합", --nvl : null값 0으로
            max(sal) as "직급별 최고 급여 금액"
from emp
group by job
--having count(*)>=2;     --직급의 인원이 2명 이상인 직급
having avg(sal)>=2000 and count(*)>1;

select deptno,job
from emp
group by deptno, job
order by job;

select * from emp;
--문제
16. SUBSTR 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력하시오.
select SUBSTR(hiredate,1,2)as 년도,SUBSTR(hiredate,4,2)as달 from emp; --substr(문자열,시작위치,길이)

17. SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력하시오.
select * from emp where substr(hiredate,4,2)='04';  --substr(문자열,시작위치,길이)

18. MOD 함수를 사용하여 사원번호가 짝수인 사람만 출력하시오.
select * from emp where mod(empno,2)=0; --(empno/2) = 짝수일때 0 

19. 입사일을 년도는 2자리(YY), 월은 숫자(MM)로 표시하고 요일은 약어 (DY)로 지정하여 출력하시오.
select hiredate, to_char(hiredate,'YY/MM DY') from emp;     --to_char(날짜또는숫자,'형식')

20. 올해 몇 칠이 지났는지 출력하시오. 현재날짜에서 올해 1월 1일을 뺀 결과를 출력하고 TO_DATE 함수를 사용하여 데이터 형을 일치 시키시오.
select to_date('2020/05/20','yyyy/mm/dd')-to_date('2020/01/01','yyyy/mm/dd') 몇일지났는가 from dual;      --to_date(문자열,날짜패턴)

21. 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 NULL 값 대신 0으로 출력하시오.
select nvl(mgr,0) from emp; --nul(문자열,값) : null값 수정

22. DECODE 함수로 직급에 따라 급여를 인상하도록 하시오. 직급이 ‘ANALIST”인 사원은 200, ‘SALESMAN’인 사원은 180, ‘MANAGER’인 사원은 150, ‘CLERK”인 사원은 100을 인상하시오.
select ename,sal,decode(job,'ANAlYST',sal+sal+200,'SALESMAN',sal+sal+180,'MANAGER',sal+sal+150,'CLERK',sal+sal+100) as upsal from emp; 

23. 모든 사원의 급여 최고액, 최저액, 총액 및 평균 급여를 출력하시오. 평균에 대해서는 정수로 반올림하시오.
select max(sal)as 최고액,min(sal)as 최저액, sum(sal) as 총액 ,round(avg(sal)) as 평균 from emp;

24. 각 담당 업무 유형별로 급여 최고액, 최저액, 총액 및 평균 액을 출력하시오. 평균에 대해서는 정수로 반올림 하시오.
select job, max(sal)as 최고액,min(sal)as 최저액, sum(sal) as 총액 ,round(avg(sal)) as 평균 from emp group by job;

25. COUNT(*) 함수를 이용하여 담당업무가 동일한 사원 수를 출력하시오.
select job,count(*) from emp group by job;

26. 관리자 수를 나열하시오.
select count(mgr) from emp;

27. 급여 최고액, 급여 최저액의 차액을 출력하시오.
select max(sal) 최고액,min(sal)최저액, max(sal)-min(sal)차액 from emp;

28. 직급별 사원의 최저 급여를 출력하시오. 관리자를 알 수 없는 사원과 최저 급여가 2000 미만인 그룹은 제외시키고 결과를 급여에 대한 내림차순으로 정렬하여 출력하시오.
select job,min(sal) from emp where mgr is not null group by job having min(sal)>2000 order by min(sal)desc;

29. 각 부서에 대해 부서번호, 사원 수, 부서 내의 모든 사원의 평균 급여를 출력하시오. 평균 급여는 소수점 둘째 자리로 반올림 하시오.

30. 각 부서에 대해 부서번호 이름, 지역 명, 사원 수, 부서내의 모든 사원의 평균 급여를 출력하시오. 평균 급여는 정수로 반올림 하시오. DECODE 사용.

31. 업무를 표시한 다음 해당 업무에 대해 부서 번호별 급여 및 부서 10, 20, 30의 급여 총액을 각각 출력하시오. 별칭은 각 job, dno, 부서 10, 부서 20, 부서 30, 총액으로 지정하시오. ( hint. Decode, group by )
