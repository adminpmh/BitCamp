package member.model;

import java.sql.Date;

public class Member {

	private int idx;
	private String uid;
	private String upw;
	private String uname;
	private String email;
	private String ugender;
	private Date regdate;
	
	public Member() {
		
	}

	public Member(int idx, String uid, String upw, String uname, String email, String ugender, Date regdate) {
		super();
		this.idx = idx;
		this.uid = uid;
		this.upw = upw;
		this.uname = uname;
		this.email = email;
		this.ugender = ugender;
		this.regdate = regdate;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getUpw() {
		return upw;
	}

	public void setUpw(String upw) {
		this.upw = upw;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUgender() {
		return ugender;
	}

	public void setUgender(String ugender) {
		this.ugender = ugender;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "Member [idx=" + idx + ", uid=" + uid + ", upw=" + upw + ", uname=" + uname + ", email=" + email
				+ ", ugender=" + ugender + ", regdate=" + regdate + "]";
	}
	
	

	

}
