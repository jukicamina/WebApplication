package mypackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


public class QuestionDaoClass implements QuestionDaoAbstract {
	
	Connection connection = null;
	ResultSet resultSet = null;
	Statement statement = null;
	PreparedStatement preparedStatement = null;
	AnswerDaoAbstract AnswerDaoAbstract = new AnswerDaoClass();
	
	@Override
	public List<Question> get(int quizID) {
		List<Question> list = null;
		Question question = null;

		try {
			list = new ArrayList<Question>();
			String sql = "SELECT quest.* from question quest where quest.quizId='"+ quizID + "'";
			connection = DataBaseConnection.openConnection();
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);
			while (resultSet.next()) {
				question = new Question();
				question.setQuestId(resultSet.getInt("questId"));
				question.setQuizId(quizID);
				question.setText(resultSet.getString("text"));
				question.setPoints(resultSet.getInt("points"));
				question.setTime(resultSet.getInt("time"));
				List<Answer> answers = AnswerDaoAbstract.get(resultSet.getInt("questId"), quizID);
				question.setAnswers(answers);
				list.add(question);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public boolean update(Question question, int id) {
		// update question que inner join quiz qui ON que.quizId=qui.id set questId=1, text="edited1", time=30, points=10 where questId=1;
		boolean flag = false;
		try {
			String sql = "UPDATE question que SET questId = '" + question.getQuestId() + "', " + "text = '"
					+ question.getText() + "', " + "time = '" + question.getTime() + "', " + "points = '" + question.getPoints() + "' where questId='"
					+ id + "' AND que.quizId='"+ question.getQuizId() + "'";
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
	public boolean save(Question question, int quizId) {
		boolean flag = false;
		try {
			String sql = "INSERT INTO question(quizId, text, time, points) VALUES" + "('" + quizId + "', '" + question.getText() + "', '" + question.getTime() + "', '" + question.getPoints() +  "')";
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
	public boolean delete(Question question, int id) {
		boolean flag = false;
		try {
//			DELETE que, answ FROM question que INNER JOIN answer answ ON answ.questId = que.questId  where que.questId=1 AND que.quizId=1;
			String sql = "DELETE que, answ FROM question que INNER JOIN answer answ ON answ.questId = que.questId where que.questId='"+ id + "' AND que.quizId='"+ question.getQuizId() + "'";
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
