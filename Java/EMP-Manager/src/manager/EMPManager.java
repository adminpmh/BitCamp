package manager;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

public class EMPManager {

	EmpDao dao = new EmpDao();

	/////////////////////////////////////////////////////////////////
	// EMP MANAGER
	/////////////////////////////////////////////////////////////////

	public void empManager() {
		System.out.println("EMP Manager Menu");
		System.out.println("=========================================");
		System.out.println("1. List  2. Insert  3. Search  4. Delete  5. Edit  ");
		System.out.println("=========================================");

		int select = ManageMain.sc.nextInt();

		switch (select) {
		case 1:
			System.out.println("전체 리스트 출력");
			empList();
			break;
		case 2:
			System.out.println("사원 정보를 입력합니다.");
			empInsert();
			break;
		case 3:
			System.out.println("사원 정보를 검색합니다.");
			empSearch();
			break;
		case 4:
			System.out.println("사원정보를 삭제합니다.");
			empDelete();
			break;
		case 5:
			System.out.println("사원정보를 수정합니다.");
			empEdit();
			break;

		}

	}


	public void empEdit() {

		Connection conn = null;

		try {

			conn = ConnectionProvider.getConnection();

			conn.setAutoCommit(false);	//기본값은 true : 자동 커밋

			//1. 수정하고자 하는 데이터 유무 확인 - > 2. 사용자로부터 데이터 받아서 전달

			int rowCnt = dao.empSearchCount(searchName, conn);


			if (rowCnt > 0) {
				Emp emp = dao.empSearchName(searchName, conn);

				if(emp ==null) {
					System.out.println("찾으시는 이름의 정보가 존재하지 않습니다.");
					return;
				}
			}

			// 사용자 입력정보 변수
			System.out.println("사원 정보를 입력해주세요.");

			System.out.println("사원번호 : " + emp.getEmpno());
			System.out.println("사원번호는 수정되지 않습니다.");

			System.out.println("사원이름 ( " + emp.getEname() + "  ) : ");
			String ename = ManageMain.sc.nextLine();

			System.out.println("급여( " + emp.getSal() + "  ) : ");
			int sal = ManageMain.sc.nextInt();

			System.out.println("부서번호( " + emp.getDeptno() + "  ) : ");
			int deptno = ManageMain.sc.nextInt();

			// 공백 입력에 대한 예외처리가 있어야 하나 이번 버전에서는 모두 잘 입력된것으로 처리합니다.

			Emp newEmp = new Emp(emp.getEmpno(),newEmp,conn);

			int resultCnt = dao.empEdit(newDept, conn);

			if (resultCnt > 0) {
				System.out.println("정상적으로 수정 되었습니다.");
				System.out.println(resultCnt + "행이 수정되었습니다.");
			} else {
				System.out.println("수정이 되지않았습니다. 확인후 재 시도해주세요.");
			}
		}else {
			System.out.println("찾으시는 이름의 정보가 존재 하지 않습니다.");
		}

		conn.commit();

	}catch (SQLException e) {

		if(conn != null) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				System.out.println("conn.close()");
				e1.printStackTrace();
			}
		}



		e.printStackTrace();
	}
}


public void empList() {

	List<Emp> empList = dao.empList();

	if(empList != null && !empList.isEmpty()) {

		for(int i=0; i<empList.size(); i++) {
			System.out.printf("%5s",empList.get(i).getEmpno()+"\t");
			System.out.printf("%10s",empList.get(i).getEname()+"\t");
			System.out.printf("%10s",empList.get(i).getJob()+"\t");
			System.out.printf("%5s",empList.get(i).getMgr()+"\t");
			System.out.printf("%10s",empList.get(i).getHiredate()+"\t");
			System.out.printf("%5s",empList.get(i).getSal()+"\t");
			System.out.printf("%5s",empList.get(i).getComm()+"\t");
			System.out.printf("%5s",empList.get(i).getDeptno()+"\n");

		}
	}else {
		System.out.println("입력된 데이터가 없습니다.");
	}

}

public void empDelete() {

	// 사용자 입력정보 변수
	System.out.println("삭제하고자 하는 사원이름 : ");
	ManageMain.sc.nextLine();
	String searchName = ManageMain.sc.nextLine();

	int resultCnt = dao.empDelete(searchName);

	if (resultCnt < 1) {
		System.out.println("삭제할 정보가 검색 결과가 없습니다.");
	} else {
		System.out.println(resultCnt + "행이 삭제 되었습니다.");
	}

	System.out.println("=================================");

	// 4. 데이터베이스 연결 종료
	// pstmt.close();
	// conn.close();

} 



public void empSearch() {
	// 사용자 입력정보 변수

	System.out.println("검색하고자 하는 사원이름 : ");
	ManageMain.sc.nextLine();
	String searchName = ManageMain.sc.nextLine();

	List<Emp> list = dao.empSearch(searchName);

	System.out.println("검색 결과");
	System.out.println("=======================================================================");
	for(Emp e : list) {
		System.out.printf("%5s",e.getEmpno()+"\t");
		System.out.printf("%10s",e.getEname()+"\t");
		System.out.printf("%10s",e.getJob()+"\t");
		System.out.printf("%5s",e.getMgr()+"\t");
		System.out.printf("%10s",e.getHiredate()+"\t");
		System.out.printf("%5s",e.getSal()+"\t");
		System.out.printf("%5s",e.getComm()+"\t");
		System.out.printf("%5s",e.getDeptno()+"\n");
	}

	System.out.println("=======================================================================");

	// 4. 데이터베이스 연결 종료
	// pstmt.close();
	// conn.close();



}

public void empInsert() {

	// 사용자 입력정보 변수
	System.out.println("사원 정보를 입력해주세요.");

	System.out.println("사원번호 : ");
	int empno = ManageMain.sc.nextInt();

	System.out.println("사원이름 : ");
	ManageMain.sc.nextLine();
	String ename = ManageMain.sc.nextLine();

	System.out.println("직급(업무) : ");
	String job = ManageMain.sc.nextLine();

	System.out.println("관리자 : ");
	int mgr = ManageMain.sc.nextInt();

	System.out.println("입사일 : ");
	ManageMain.sc.nextLine();
	String hiredate = ManageMain.sc.nextLine();

	System.out.println("급여 : ");
	int sal = ManageMain.sc.nextInt();

	System.out.println("수당 : ");
	int comm = ManageMain.sc.nextInt();

	System.out.println("부서번호 : ");
	int deptno = ManageMain.sc.nextInt();

	// 공백 입력에 대한 예외처리가 있어야 하나 이번 버전에서는 모두 잘 입력된것으로 처리합니다.

	Emp emp = new Emp(empno, ename, job, mgr, hiredate, sal, comm, deptno);

	int resultCnt = dao.empInsert(emp); 

	if (resultCnt > 0) {
		System.out.println("정상적으로 입력 되었습니다.");
		System.out.println(resultCnt + "행이 입력되었습니다.");
	} else {
		System.out.println("입력이 되지않았습니다. 확인후 재 시도해주세요.");
	}

}

}


