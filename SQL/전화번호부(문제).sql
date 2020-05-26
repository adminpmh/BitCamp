--전화번호 관리 프로그램
--이름, 전화번호, 생일, 이메일
--전공, 학년
--부서이름, 직급
--모임이름, 닉네임
--대리키 : 일련번호 -> p_idx ->pk 기본키로 만들기 위한 목적

--전화번호 부(Contact)

create table Contact(
    pidx number(4)not null,                                        --기본키, 대리키
    name VARCHAR2(10) not null,                                     --이름
    phonenumber VARCHAR2(30)not null,                                 --전화번호
    addr VARCHAR2(50)DEFAULT '입력값 없음' not null,                  --주소
    email VARCHAR2(30)DEFAULT '입력값 없음' not null,                 --이메일
    ftype VARCHAR2(15)not null,                                     --친구의타입
    major VARCHAR2(30),                                             --전공
    grade number(1),                                                --학년
    company VARCHAR2(30),                                           --회사이름
    dept VARCHAR2(20),                                              --부서이름
    job VARCHAR2(20),                                               --직급
    cafename VARCHAR2(30),                                          --모임이름
    nickname VARCHAR2(30),                                           --닉네임
    CONSTRAINT Contact_pidx_pk PRIMARY key (pidx),
    CONSTRAINT Contact_ftype_ck CHECK(ftype in('univ','com','cafe')),
    CONSTRAINT Contact_grade_ck check(grade BETWEEN 1 and 4)
);

create table phoneInfo_basic(
    idx number(6),
    fr_name VARCHAR2(20)not null,
    fr_phonenumber VARCHAR2(20)not null,
    fr_email VARCHAR2(20),
    fr_address VARCHAR2(20),
    fr_regdate date DEFAULT sysdate,
    
    CONSTRAINT phoneInfo_basic_idx_pk primary key(idx)
);

create table phoneInfo_univ(
    idx number(6),
    fr_u_major VARCHAR2(20)DEFAULT 'N' not null,
    fr_u_year number(1) DEFAULT '1' not null,
    fr_ref number(7)not null,
    
    CONSTRAINT phoneInfo_univ_idx_pk primary key(idx),
    CONSTRAINT phoneInfo_univ_fr_ref_fk foreign key(fr_ref) references phoneInfo_basic(idx),
    CONSTRAINT phoneInfo_univ_fr_u_year_ck check(fr_u_year in('1','2','3','4'))
    --CONSTRAINT phoneInfo_univ_fr_u_year_ck check(fr_u_year BETWEEN 1 and 4)
);

create table phoneInfo_com(
    idx number(6)not null,
    fr_c_company VARCHAR2(20)DEFAULT 'N' not null,
    fr_ref number(6)not null,
    
    CONSTRAINT phoneInfo_com_idx_pk primary key(idx),
    CONSTRAINT phoneInfo_com_fr_ref_fk FOREIGN key(fr_ref) references phoneInfo_basic(idx)
);

-----------------------------------------------------
drop table Contact;
--입력 SQL 작성
desc Contact;
select * from contact;
--기본정보 입력
insert into contact(pidx,name,phonenumber,addr,email,ftype)values (1,'김씨','010-1234-5678','서울 종로구','kim@naver.com','univ');
--not null 경우
insert into contact(pidx,name,phonenumber,addr,email,ftype)values (1,'이씨',010-7777-1234,'부산광역시','lee@naver.com');
--무결성 제약조건
insert into contact(pidx,name,phonenumber,addr,email,ftype)values (1,'김씨',01012344567,'서울시','kim@naver.com','univ');
--DEFAULT 값 경우
insert into contact(pidx,name,phonenumber,ftype)values (2,'이씨','010-7777-7322','univ');
--학교 친구 정보 입력
--회사 친구 정보 입력
--모임 친구 정보 입력

----------------------------------------------------------------------------------------------------------
-- PHONEINFO_BASIC ,PHONEINFO_UNIV, PHONEINFO_COM
----------------------------------------------------------------------------------------------------------
drop table PHONEINFO_BASIC;
desc PHONEINFO_BASIC;
select * from PHONEINFO_BASIC;
--1. 전체 친구 목록 출력 : 테이블 3개 JOIN
select * from PHONEINFO_BASIC pb,PHONEINFO_UNIV pu, PHONEINFO_COM pc
where pb.idx = pu.fr_ref(+) and pb.idx = pc.fr_ref(+)
;
--2. 학교 친구 목록 출력 
select * from PHONEINFO_BASIC pb,PHONEINFO_UNIV pu
where pb.idx = pu.fr_ref
;
--3. 대학 친구 목록 출력
select * from PHONEINFO_BASIC pb, PHONEINFO_COM pc
where pb.idx = pc.fr_ref
;

insert into phoneinfo_basic(idx,FR_NAME,FR_PHONENUMBER,FR_EMAIL,FR_ADDRESS,FR_REGDATE)values (1,'김정은','010-1234-5678','kim@naver.com','평양','');
insert into phoneInfo_univ(idx,FR_U_MAJOR,FR_U_YEAR,FR_REF)values (1,'컴퓨터',3,1);

insert into phoneinfo_basic(idx,FR_NAME,FR_PHONENUMBER,FR_EMAIL,FR_ADDRESS)values (2,'김일성','010-1111-6363','kim1@naver.com','서울');
insert into phoneInfo_univ(idx,FR_U_MAJOR,FR_U_YEAR,FR_REF)values (2,'외교',1,2);

insert into phoneinfo_basic(idx,FR_NAME,FR_PHONENUMBER,FR_EMAIL,FR_ADDRESS)values (3,'김정일','010-4949-1666','kim2@naver.com','부산');
insert into PHONEINFO_COM(idx,FR_C_COMPANY,FR_REF)values (1,'조선인민공화국',3);

insert into phoneinfo_basic(idx,FR_NAME,FR_PHONENUMBER,FR_EMAIL,FR_ADDRESS)values (4,'이승만','010-8282-7722','LEE@yahoo.co.kr','목포');
insert into phoneInfo_univ(idx,FR_U_MAJOR,FR_U_YEAR,FR_REF)values (3,'통일',1,4);
insert into PHONEINFO_COM(idx,FR_C_COMPANY,FR_REF)values (2,'대한민국',4);































