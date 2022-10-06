package mypackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Inbox {
	private String firstName;
	private String lastName; 
	//private String email;
	private int score;
	private int quizId;
	
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	/*public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}*/
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public int getQuizId() {
		return quizId;
	}
	public void setQuizId(int quizId) {
		this.quizId = quizId;
	}
	
	public boolean update() {
		Connection connection = null;
		ResultSet resultSet = null;
		Statement statement = null;
		PreparedStatement preparedStatement = null;

		boolean flag = false;
		try {
			String sql = "UPDATE inbox SET score = '" + this.getScore() + "'WHERE firstName = '" + this.getFirstName() + "' AND lastName = '" + this.getLastName() + "' AND quizId ='" + this.getQuizId()+"'";
			connection = DataBaseConnection.openConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.executeUpdate();
			flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}
	
}
