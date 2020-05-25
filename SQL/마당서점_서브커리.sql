--1 마당서점의고객이요구하는다음질문에대해SQL 문을작성하시오.
--(5) 박지성이구매한도서의출판사수

select count(distinct publisher) 
from customer c, orders o, book b
where c.custid = o.custid and o.bookid = b.bookid
and c.name='박지성'
;
--박지성이 구매한 도서 ID
select DISTINCT o.bookid
from orders o, customer c
where o.custid = c.custid and c.name='박지성' 
;

select count (distinct publisher)
from book
where bookid in(select DISTINCT o.bookid
from orders o, customer c
where o.custid = c.custid and c.name='박지성' )
;

--(6) 박지성이구매한도서의이름, 가격, 정가와판매가격의차이
select b.bookname, b.price, b.price-o.saleprice as pricegap
from orders o, customer c, book b
where c.custid = o.custid and o.bookid = b.bookid
and c.name ='박지성'
;

select b.bookname, b.price, b.price-o.saleprice
from orders o, book b
where o.bookid = b.bookid
and custid = (select custid from customer where name = '박지성')
;

select custid from customer where name = '박지성';

--(7) 박지성이구매하지않은도서의이름
select *
from orders o, customer c
where o.custid = c.custid and c.name = '박지성'
;

select bookname, bookid
from book
where bookid not in(select o.bookid
from orders o, customer c
where o.custid = c.custid and c.name = '박지성')
;

--(8) 주문하지않은고객의이름(부속질의사용)
select c.name
from orders o, customer c
where o.custid(+) = c.custid
and o.orderid in null
;

select name
from customer
where custid not in(select distinct custid from orders)
;

select distinct custid from orders;

--(9) 주문금액의총액과주문의평균금액
select sum(saleprice), avg(saleprice)
from orders
;

--(10) 고객의이름과고객별구매액
select c.name , sum(saleprice)
from orders o, customer c
where o.custid = c.custid
group by c.name
;

--(11) 고객의이름과고객이구매한도서목록
select c.name, b.bookname
from book b, orders o, customer c
where b.bookid = o.bookid and o.custid = c.custid
;

--(12) 도서의가격(Book 테이블)과판매가격(Orders 테이블)의차이가가장많은주문
select max(b.price-o.saleprice)
from orders o, book b
where o.bookid = b.bookid
;

select b.bookname, b.price-o.saleprice
from orders o, book b
where o.bookid = b.bookid
and price-saleprice = (select max(b.price-o.saleprice)
from orders o, book b
where o.bookid = b.bookid)
;

--(13) 도서의판매액평균 보다 
--      자신의 구매액평균이 더높은 고객의이름
select avg(saleprice) from orders;


select c.name, avg(saleprice)
from orders o, customer c
where o.custid = c.custid
group by c.name
having avg(saleprice) > (select avg(saleprice) from orders)--평균 구매액
;

--(1) 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름
select b.publisher
from orders o, customer c, book b
where o.custid = c.custid and o.bookid = b.bookid
and c.name = '박지성'
;


select *
from orders o, customer c, book b
where o.custid = c.custid and o.bookid = b.bookid

and b.publisher in (select DISTINCT b.publisher
from orders o, customer c, book b
where o.custid = c.custid and o.bookid = b.bookid
and c.name = '박지성')
and c.name!='박지성'
;

--(2) 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름
select c.name, count(DISTINCT publisher)
from orders o, customer c, book b
where o.custid = c.custid and o.bookid = b.bookid
group by c.name
having count(DISTINCT publisher)>=2
;
