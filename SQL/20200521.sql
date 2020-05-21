--2020.05.21

-------------------------------------------
--JOIN : 스키마의 결합(옆으로 붙여준다)
-------------------------------------------

select * from dept; 
select * from emp;

--cross join
select * 
from emp, dept
;

select *
from emp,dept
where emp.deptno = dept.deptno
;

-- book, customer, orders
select * from book;
select * from customer;
-- cross JOIN

select ename,dname
from emp e inner join dept d
on e.deptno=d.deptno
;

select ename, dname
from emp inner join dept
using(deptno)
;

select *
from orders o, book b, customer c
;

select *
from orders o, book b, customer c
where o.bookid=b.bookid and o.custid=c.custid
;

select *
from orders o, book b, customer c
where o.bookid=b.bookid and o.custid=c.custid
and name ='박지성'
;

select * from emp;
select * from salgrade;

select ename,sal,grade
from emp e, salgrade s
--where e.sal>= s.losal and e.sal<=s.hisal
where sal between losal and hisal
;

--관리자의 이름을 알아보자
select * from emp;

select e.ename || '의 상사는' || e.ename ||'입니다'
from emp e, emp m
where e.mgr = m.empno
;
select * from emp;
select *--e.ename || '의 상사는' || e.ename ||'입니다'
from emp e, emp m
where e.mgr = m.empno(+)
;

select *
from emp e left outer join emp m
on e.mgr = m.empno
;

select ename,dname
from emp natural join dept
;

--JOIN 문제 풀이
--32. EQUI 조인을 사용하여 SCOTT 사원의 부서번호와 부서 이름을 출력하시오.
select emp.deptno,dname
from emp,dept
where emp.deptno = dept.deptno
and ename = 'SCOTT'
;

--33. INNER JOIN과 ON 연산자를 사용하여 사원 이름과 함께 그 사원이 소속된 부서이름과 지역 명을 출력하시오.
select ename,dname,loc
from emp inner join dept
on emp.deptno = dept.deptno
;

--36. 조인과 WildCARD를 사용하여 이름에 ‘A’가 포함된 모든 사원의 이름과 부서명을 출력하시오.
select ename, dname
from emp, dept
where emp.deptno = dept.deptno
and emp.ename like '%A%'
;

--37. JOIN을 이용하여 NEW YORK에 근무하는 모든 사원의 이름, 업무, 부서번호 및 부서명을 출력하시오.
select ename, job, deptno, dname
from emp natural join dept
where dept.loc = 'NEW YORK'
;
--38. SELF JOIN을 사용하여 사원의 이름 및 사원번호, 관리자 이름을 출력하시오.
select e.ename, e.empno, m.ename
from emp e, emp m
where e.empno = m.mgr
;
--39. OUTER JOIN, SELF JOIN을 사용하여 관리자가 없는 사원을 포함하여 사원번호를 기준으로 내림차순 정렬하여 출력하시오.
select e.ename, e.empno, m.ename
from emp e, emp m
where m.mgr = e.empno(+)
;
-- select e.ename, e.empno, m.ename from emp e outer join emp m on e.mgr = m.empno;

--40. SELF JOIN을 사용하여 지정한 사원의 이름, 부서번호, 지정한 사원과 동일한 부서에서 이름, 부서사원을 출력하시오. ( SCOTT )
select e.ename, e.deptno, s.ename
from emp e, emp s
where e.ename = 'SCOTT'
and e.deptno = s.deptno
and s.ename !='SCOTT'
;

--41. SELF JOIN을 사용하여 WARD 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하시오.
select e.ename, e.hiredate, w.hiredate ,w.ename 
from emp e, emp w
where w.ename='WARD'
and e.hiredate>w.hiredate
;
--42. SELF JOIN 을 사용하여 관리자보다 먼저 입사한 모든 사원의 이름 및 입사일을 관리자의 이름 및 입사일과 함께 출력하시오.
select e.ename, e.hiredate, m.ename, m.hiredate
from emp e, emp m
where e.mgr=m.empno
and e.hiredate < m.hiredate
;
