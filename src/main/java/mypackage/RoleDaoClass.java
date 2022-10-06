package mypackage;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class RoleDaoClass implements RoleDaoAbstract{

	Connection connection = null;
	ResultSet resultSet = null;
	Statement statement = null;
	PreparedStatement preparedStatement = null;
	
	@Override
	public List<Role> getRoles() {
		List<Role> list = null;
		Role role = null;

		try {
			list = new ArrayList<Role>();
			String sql = "SELECT * from role";
			connection = DataBaseConnection.openConnection();
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);
			while (resultSet.next()) {
				role = new Role();
				role.setId(resultSet.getInt("id"));
				role.setRole(resultSet.getString("name"));
				list.add(role);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

}
