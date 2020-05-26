--전화번호 관리 프로그램
--이름, 전화번호, 생일, 이메일
--전공, 학년
--부서이름, 직급
--모임이름, 닉네임
--대리키 : 일련번호 -> p_idx ->pk 기본키로 만들기 위한 목적

--전화번호 부(Contact)

create table Contact(
    pidx number(10)not null,                                        --기본키, 대리키
    name VARCHAR2(10) not null,                                     --이름
    phonenumber number(15)not null,                                 --전화번호
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
    constraint Contact_phonenumber_pk primary key(phonenumber),
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