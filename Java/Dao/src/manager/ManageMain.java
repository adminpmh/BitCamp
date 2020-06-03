package manager;

import java.sql.Date;
import java.util.Scanner;

public class ManageMain {

	static Scanner sc = new Scanner(System.in);

	public static void main(String[] args) throws ClassNotFoundException {

		// 0. 드라이버 LIB 추가
		// 1. 데이터베이스 드라이버 로드
		// Class.forName(드라이버 클래스 전체이름)
		// Oracle : oracle.jdbc.driver.OracleDriver
		Class.forName("oracle.jdbc.driver.OracleDriver");
		System.out.println("데이터베이스 드라이버 로드 완료...!!");
		
		Date sysdate = new Date(new java.util.Date().getDate());
		
		DEPTManager deptManager = new DEPTManager();
		EMPManager empManager = new EMPManager();

		while (true) {
			System.out.println("Select Menu");
			System.out.println("----------------");
			System.out.println("1. EMP,  2. DEPT");
			System.out.println("----------------");

			int select = sc.nextInt();

			switch (select) {
			case 1:
				empManager.empManager();
				break;
			case 2:
				deptManager.deptManager();
				break;
			}

		}

	}
}




	

