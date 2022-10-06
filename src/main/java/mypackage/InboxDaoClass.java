package mypackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class InboxDaoClass implements InboxDaoAbstract {
	
	Connection connection = null;
	ResultSet resultSet = null;
	Statement statement = null;
	PreparedStatement preparedStatement = null;

	@Override
	public boolean save(Inbox inbox) {
		boolean flag = false;
		try {
			String sql = "INSERT INTO inbox(firstName, lastName, score, quizId) VALUES" + "('" + inbox.getFirstName() + "', '" + inbox.getLastName() +  "', " + inbox.getScore() +  ", " + inbox.getQuizId() +")";
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
	public List<Inbox> getInboxesForQuiz(int quizId) {
		//System.out.println("Download Inbox");
		List<Inbox> list = null;
		Inbox inbox = null;

		try {
			list = new ArrayList<Inbox>();
			String sql = "SELECT * from inbox where quizId='"+ quizId + "'" + "ORDER BY score DESC LIMIT 10";
			connection = DataBaseConnection.openConnection();
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);
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
	
	@Override
	public boolean update(Inbox inbox) {
		boolean flag = false;
		try {
			System.out.println(inbox.getFirstName());
			System.out.println(inbox.getLastName());

			System.out.println(inbox.getScore());
			System.out.println(inbox.getQuizId());

			String sql = "UPDATE inbox SET score = '" + inbox.getScore() + "'WHERE firstName = '" + inbox.getFirstName() + "' AND lastName = '" + inbox.getLastName() + "' AND quizId ='" + inbox.getQuizId()+"'";
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
