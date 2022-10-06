package mypackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


public class AnswerDaoClass implements AnswerDaoAbstract {

	Connection connection = null;
	ResultSet resultSet = null;
	Statement statement = null;
	PreparedStatement preparedStatement = null;

	@Override
	public List<Answer> get(int questionID, int quizID) {
		List<Answer> list = null;
		Answer answer = null;

		try {
			list = new ArrayList<Answer>();
			String sql = "SELECT answ.* from answer answ where answ.questId='"+ questionID + "'" + "AND answ.quizId='"+ quizID + "'";
			connection = DataBaseConnection.openConnection();
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);
			while (resultSet.next()) {
				answer = new Answer();
				answer.setAnswId(resultSet.getInt("answId"));
				answer.setQuestionId(questionID);
				answer.setQuizId(resultSet.getInt("quizId"));
				answer.setAnswText(resultSet.getString("text"));
				answer.setCorrect(resultSet.getBoolean("correct"));
				list.add(answer);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public boolean update(Answer answer, int id) {
		boolean flag = false;
		try {
			String sql = "UPDATE answer answ set answ.text= '" + answer.getAnswText() + "', " + " answ.correct = "
					+ answer.isCorrect() + " where answId=" + id; 
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
	public boolean save(Answer answer, int quizId, int questionId) {
		boolean flag = false;
		try {
			String sql = "INSERT INTO answer(quizID, questId, text, correct) VALUES" + "('" + quizId + "', '" + questionId + "', '" + answer.getAnswText() + "', " + answer.isCorrect() +  ")";
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
	public boolean delete(int id) {
		boolean flag = false;
		try {
			String sql = "DELETE answ.* FROM answer answ where answId='"+ id + "'";
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
