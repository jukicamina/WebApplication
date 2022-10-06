package mypackage;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DataBaseConnection {
	private static Connection connection = null;

	public static Connection openConnection() {
		if (connection != null)
			return connection;
		
		/*else {
			try {
				Class.forName("com.mysql.jdbc.Driver");
				connection = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/mydatabase?useUnicode=true&characterEncoding=utf8&useSSL=false"
								+ "&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "password");
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return connection;
		}*/
		
		else {
			try {
				Class.forName("com.mysql.jdbc.Driver");
				connection = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/mydatabase?useUnicode=true&characterEncoding=utf8&useSSL=false"
								+ "&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "1234");			}
			catch(Exception e) {
				//e.printStackTrace();
				try {
					Class.forName("com.mysql.jdbc.Driver");
					connection = DriverManager.getConnection(
							"jdbc:mysql://localhost:3306/mydatabase?useUnicode=true&characterEncoding=utf8&useSSL=false"
									+ "&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "1234");				}
				catch(Exception exc) {
					exc.printStackTrace();
				}
			}

		}
		return connection;
	}
}