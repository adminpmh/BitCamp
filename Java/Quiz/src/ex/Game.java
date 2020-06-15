package ex;

import java.util.Scanner;

public class Game {

	public static void main(String[] args) {
		
		int user,com,cnt = 1;
		Scanner sc = new Scanner(System.in);
		com = (int)(Math.random()*100)+1;
		
		System.out.println("HIGH LOW GAME");
		System.out.println("시작합니다.");
		System.out.println("1~100까지 숫자를 입력해 주세요");
		while(cnt<=10) {
			user = sc.nextInt();
			if(user==com) {
				System.out.println("정답입니다.");
				System.out.println("정답은"+com);
				System.out.println("축하드립니다.");
			}else if(user>com) {
				System.out.println(user+"값보다 낮습니다. 낮은 숫자를 입력하세요");
				cnt++;
			}else if(user<com) {
				System.out.println(user+"값보다 높습니다. 높은 숫자를 입력하세요");
				cnt++;
			}
		}
		System.out.println("당신은 패배하였습니다.");
			
		}
		
		

	}

