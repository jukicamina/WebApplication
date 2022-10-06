package mypackage;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.ResultSet;
import com.mysql.jdbc.Statement;


public interface InboxDaoAbstract {
	boolean save(Inbox inbox);
	boolean update(Inbox inbox);
	public List<Inbox> getInboxesForQuiz(int quizId);
	
	public static List<Inbox> getNewInbox(int quizId) {
		System.out.println("NOVI INBOX");
		Connection connection = null;
		ResultSet resultSet = null;
		Statement statement = null;
		
		List<Inbox> list = null;
		Inbox inbox = null;

		try {
			list = new ArrayList<Inbox>();
			String sql = "SELECT * from inbox where quizId='"+ quizId + "'" + "ORDER BY score DESC LIMIT 10";
			connection = (Connection) DataBaseConnection.openConnection();
			statement = (Statement) connection.createStatement();
			resultSet = (ResultSet) statement.executeQuery(sql);
			while (resultSet.next()) {
				inbox = new Inbox();
				inbox.setFirstName(resultSet.getString("firstName"));
				inbox.setLastName(resultSet.getString("lastName"));
				//inbox.setEmail(resultSet.getString("email"));
				inbox.setScore(resultSet.getInt("score"));
				inbox.setQuizId(resultSet.getInt("quizId"));
				list.add(inbox);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
		
		
		
	}
}
