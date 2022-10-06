package mypackage;


public class User {
	private String userName;
	   private String password;
	   int role;
	 
	   public User() {}
	 
	   public User(String userName, String password, int role) {
	      this.userName = userName;
	      this.password = password;
	      this.role = role;
	   }

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}
	   
	public boolean checkAdminRole(int role) {
		if (role == 1 || role == 2) 
			// super admin - 1
			// editor - 2
			return true;
		else 
			// other - 0
			return false;
	   }
	
	public String checkRole(int roleId) {
		if (roleId == 1 ) 
			// super admin - 1
			// editor - 2
			return "admin";
		else if (roleId == 2)
			// other - 0
			return "editor";
		else 
			return "other";
	}

	@Override
	public String toString() {
		String roleStr = null;
		if (role == 0 ) roleStr = "other";
		else if (role == 1) roleStr = "admin";
		else if(role == 2) roleStr = "editor";
		return "username=" + userName + ", password=" + password + ", role=" + roleStr + "";
	} 

}
