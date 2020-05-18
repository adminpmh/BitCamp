package ex;

public class PrefixOp {

	public static void main(String[] args) {
		
		int num1 = 7;		//num1 = 7
		int num2 = ++num1;	//num2 = 8 num1 = 8
		int num3 = --num1;	//num3 = 7 num2 = 8 num1 = 7
		
		System.out.println(++num1);
		System.out.println(num2);
		System.out.println(--num2);
		System.out.println(num3);

	}

}
