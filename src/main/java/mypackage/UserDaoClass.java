package mypackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserDaoClass implements UserDaoAbstract {
	Connection connection = null;
	ResultSet resultSet = null;
	Statement statement = null;
	PreparedStatement preparedStatement = null;

	@Override
	public List<User> get() {

		List<User> list = null;
		User userAccount = null;

		try {

			list = new ArrayList<User>();
			String sql = "SELECT * FROM user";
			connection = DataBaseConnection.openConnection();
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);
			while (resultSet.next()) {
				userAccount = new User();
				userAccount.setUserName(resultSet.getString("username"));
				userAccount.setPassword(resultSet.getString("password"));
				userAccount.setRole(resultSet.getInt("role"));
				list.add(userAccount);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public User get(String userName) {
		User userAccount = null;
		try {
			userAccount = new User();
			String sql = "SELECT * FROM user where username='" + userName + "'";
			connection = DataBaseConnection.openConnection();
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);
			if (resultSet.next()) {
				userAccount.setUserName(resultSet.getString("username"));
				userAccount.setPassword(resultSet.getString("password"));
				userAccount.setRole(resultSet.getInt("role"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return userAccount;
	}

	@Override
	public User get(String userName, String password) {
		User userAccount = null;
		try {
			userAccount = new User();
			String sql = "SELECT * FROM user where username='" + userName + "' AND password='" + password + "'";
			connection = DataBaseConnection.openConnection();
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);
			if (resultSet.next()) {
				userAccount.setUserName(resultSet.getString("username"));
				userAccount.setPassword(resultSet.getString("password"));
				userAccount.setRole(resultSet.getInt("role"));
			} else {
				userAccount = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return userAccount;
	}

	@Override
	public boolean update(User userAccount, String userName) {
		boolean flag = false;
		try {
			String sql = "UPDATE user SET username = '" + userAccount.getUserName() + "', " + "password = '"
					+ userAccount.getPassword() + "', " + "role = '" + userAccount.getRole() + "' where username='"
					+ userName + "'";
			connection = DataBaseConnection.openConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.executeUpdate();
			flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean save(User userAccount) {
		boolean flag = false;
		try {
			String sql = "INSERT INTO user(username, password, role)VALUES" + "('" + userAccount.getUserName()
					+ "', '" + userAccount.getPassword() + "', '" + userAccount.getRole() + "')";
			connection = DataBaseConnection.openConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.executeUpdate();
			flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean delete(String userName) {
		boolean flag = false;
		try {
			String sql = "DELETE FROM user where username=" + "\'" + userName + "\'";
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
