package ex;

public class ByteOverFlow {

	public static void main(String[] args) {
		
		byte b = 0;
		int i = 0;
		
		for(int y=0; y<270; y++) {
			System.out.print(b++);
			System.out.print("\t");
			System.out.println(i++);
		}

	}

}
