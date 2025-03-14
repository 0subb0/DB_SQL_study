--2025 03 14 수업내용

@D:\SQL_DATA\EMP_EXAMPLE.sql
@D:\SQL_DATA\star.sql
@D:\SQL_DATA\UNION_SET.sql
@D:\SQL_DATA\EXAMPLE_JOIN.sql
@D:\SQL_DATA\SUBQUERY.sql

--##########################################
--데이터 조회 DQL(data Query Language)
--##########################################
--테이블 저장된 데이터를 조회하는 것

SELECT * FROM emp;
SELECT ename, gender, sal FROM emp;

--조건 부여 sql문 
--where ;
--group by
--having
--order by

SELECT * FROM employees;

SELECT employee_id emp_id, first_name as FROM employees;
SELECT ename 이름, job 직책, gender 성별 FROM emp;

SELECT empno 사번, ename 이름, sal 급여, sal * 12 연봉, hiredate 입사일 FROM emp;

--특정 조건에 맞는 데이터만 조회하기
SELECT empno 사번, ename 이름 , job 직급 FROM emp;
where empno = 1004;

--연봉이 4,000만원 이하
SELECT empno 사번, ename 이름, sal 급여, sal * 12 연봉, hiredate 입사일 FROM emp;
where sal * 12 <= 4000;

--사원 테이블 월급 450 이하인 직원 조회
SELECT empno, ename, job, sal from emp
where sal <= 450;

--사원 테이블에서 영업부 소속이 아닌 직원 조회
SELECT * FROM emp; --전체조회
SELECT empno 사번, ename 이름, deptno 부서번호 FROM emp
where deptno <> 30; --부서번호가 30번이 아닌 사번 조회

--날자 데이터를 조건 조회   
SELECT empno, ename, hiredate FROM emp
where hiredate <'2007/03/01'; --2007년 3월 1일 이전 입사한 정보 조회

SELECT empno, ename, hiredate FROM emp
where hiredate <'2007/03/01';

SELECT empno, ename, hiredate FROM emp
where hiredate <to_date ('2007/03/01', 'yyyy/mm/dd');

SELECT empno, ename, hiredate FROM emp
where hiredate <to_date ('01-3월-2007', 'dd-mon-yyyy');

--문자 데이터 비교
SELECT empno, ename, hiredate from emp
where ename = '홍길동'; --쌍따옴표 할 시, 변수로 취급해서 주의요망. (데이터로 저장이 안됨)

SELECT empno, ename, hiredate, birthday 생년_월일 from emp
where ename = '홍길동';

SELECT employee_id, last_name from employees
where last_name = 'anstin';

--김씨만 검색 _ = 오로지 하나의 문자와 일치, % = 여러 개의 문자, 어떤 것이라도 상관없음
SELECT * FROM emp where ename like = '김__'; --'김%' => 김으로 시작하는 단어 찾기
SELECT * FROM emp where ename like = '정__'; -- 이름에 '정'이 들어가면 다 출력
SELECT * FROM emp where ename like = '_사%'; -- 이름 중에서 중간 단어가 무조건 '사'
SELECT * FROM emp where ename like = '%기'; -- '기'로 끝나는 이름

--성이 김씨가 아닌 직원
SELECT * FROM emp where ename not like = '김%';
SELECT * FROM emp where ename like = '김%';

--조건이 여러개라면 AND, OR, HOT
--2006년 이후에 입사한 직원 중 월급이 350만원 이상인 직원

select empno, ename, sal, hiredate from emp
where hiredate > to_date('2006-12-31') and sal > 350; 

--직원중에서 급여가 350- 500 받는 사람
select ename sal job from emp
where sal >= 350 AND sal <= 500;

select ename sal job from emp
where sal retween 350 AND 500;


-- 부서 번호가 10이거나 40
select * from emp
where deptno = 10 or deptno = 40;

--in 연산자르 이용한 where절
select empno, ename from emp
where ename = '장동건' or ename = '박중훈';

--관리자번호가 1006이거나 1013 => 장동건이나 박중훈이 관리하는 사람들의 번호
select empno, ename from emp
where mgr = 1006 or mgr = 1013;

select empno, ename from emp
where mgr in (1006, 1013);

select empno, ename from emp
where mgr = 1006 or mgr = 1013 or mgr = 1008;

select empno, ename from emp
where mgr in (1006, 1013, 1008);

--부서번호가 30 소속 아닌 (영업부 소속이 아닌) 직원
select ename, deptno from emp
where not deptno = 30;

--입사일이 2007년도가 아닌 직원
select ename, hiredate from emp
where not hiredate >= '2007-01-01' and hiredate <= '2007-12-31';

select ename, hiredate from emp
where not hiredate between '2007-01-01' and '2007-12-31';

select ename, hiredate from emp
where hiredate not between '2007-01-01' and '2007-12-31';

--커미션 80, 100, 200
select * from emp
where comm not in  (80, 100, 200) or comm is null;

--데이터 정렬과 중복 제거
--2007년 입사자가 아닌 직원을 조회 입사일 순으로 정렬
select ename, hiredate from emp
where not hiredate >= '2007-01-01' and hiredate <= '2007-12-31'
order by hiredate desc; --default가 오름차순 정렬

--급여 오름차순 정렬
select * from emp
where comm not in  (80, 100, 200) or comm is null;
order by sal;

--정렬 조건이 2개 이상
select * from emp
order by mgr asc nulls first, sal asc; --null값이 첫 번째로 출력후 mgr값이 오름차순으로 정렬


--중복된 행을 제거
select distinct job from emp;
SELECT distinct deptno 부서 from emp
drder by deptno;

--집합연산자 => 합집합, 교집합, 차집합
select ename, job deptno from emp;
select ename, sal from emp;

select * from group_star;
select * from single_star;

--합집합
select * from group_star
union all
select * from single_star;

--컴퓨터공학과 교수와 학생들 조회
select *from department; --학과 전체조회

select profno, name, deptno from professor
where deptno = 101
union
select studno, name, deptno1 from student
where deptno1 = 101;

--교집합 => 그룹활동을 하며 싱글활동도 같이하는
select * from group_star
intersect
select * from group_star

-- 학생 테이블에서 컴퓨터 공학과 전자 공학을 복수 전공하는 학생
select studno, name, deptno1 from student
where deptno1 = 101
intersect
select studno, name, deptno1 from student
where deptno2 = 201;

--차집합
--싱글활동만 하는 연예인
select *from single_star
minus
select *from group_star;

select name, position from professor; --position => 교수직책

select name, position from professor 
where position = '전임강사';

--사원테이블에서 20번 부서 직원의 급여 오름차순 정렬, 입사일을 내림차순
select ename, sal, hiredate from emp
where deptno = 30 or deptno =20
where deptno in (20, 30)
order by sal, hiredate desc; --정렬 생략 시 default로 오름차순 정렬됨.















 





































 

