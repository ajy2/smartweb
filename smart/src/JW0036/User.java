package JW0036;

import java.io.Serializable;

public class User implements Serializable{
	private String userid; 
	private String passwd;
	private String email;
	private String lastLogin;
	
	public User(){		
	}
	
	public void setUserid(String userid){
		this.userid = userid;
	}
	
	public String getUserid(){
		return userid;
	}
	
	public void setPasswd(String passwd){
		this.passwd = passwd;
	}
	
	public String getPasswd(){
		return passwd;
	}
	
	public void setEmail(String email){
		this.email = email;
	}
	
	public String getEmail(){
		return email;
	}

	public void setLastLogin(String lastLogin){
		this.lastLogin = lastLogin;
	}
	
	public String getLastLogin(){
		return lastLogin;
	}
}