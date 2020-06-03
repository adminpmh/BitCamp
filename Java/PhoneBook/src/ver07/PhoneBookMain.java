package ver07;

import java.util.InputMismatchException;

import ver05.exception.BadNumberException;
import ver06.Menu;
import ver06.MenuNum;


public class PhoneBookMain {

	public static void main(String[] args) throws ClassNotFoundException {

		//PhoneBookManager manager = new PhoneBookManager(100);
		Class.forName("oracle.jdbc.driver.OracleDriver");
		System.out.println("데이터베이스 드라이버 로드 완료...!!");
		PhoneBookManager manager = PhoneBookManager.getInstance();


		while(true) {

			Menu.showMenu();

			int select = 0;

			try {
				select = manager.kb.nextInt();

				// 정상 범위는 1~6
				// MenuNum.INSERT ~ MenuNum.EXIT
				if(!(select >= MenuNum.INSERT && select <= MenuNum.EXIT)) {

					BadNumberException e = new BadNumberException("잘못된 메뉴입력");

					// 강제적인 예외 발생
					throw e;

				}


			} catch (InputMismatchException e) {
				System.out.println("잘못된 메뉴 입력입니다. \n확인하시고 다시 입력해주세요.");
				//manager.kb.nextLine();
				continue;
			} catch (BadNumberException e) {
				System.out.println("메뉴 범위는 벗어난 숫자 입력입니다.\n다시 확인 후 입력해주세요.");
				continue;				
			} catch (Exception e) {
				System.out.println("잘못된 메뉴 입력입니다. \n확인하시고 다시 입력해주세요.");
				//manager.kb.nextLine();
				continue;
			} finally {
				manager.kb.nextLine();
			}

			//manager.kb.nextLine();


			switch(select) {
			case MenuNum.INSERT:
				manager.createInfo();
				break;
			case MenuNum.SEARCH:
				manager.showInfo();
				break;
			case MenuNum.DELETE:
				manager.deleteInfo();
				break;
			case MenuNum.EDIT:
				manager.editInfo();
				break;
			case MenuNum.PRINT_ALL:
				manager.showAllInfo();
				break;
			case MenuNum.EXIT:
				System.out.println("프로그램을 종료합니다.");
				return;
			}



		}

	}

}
