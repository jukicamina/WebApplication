package mypackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;


public class QuizDaoClass implements QuizDaoAbstract{
	Connection connection = null;
	ResultSet resultSet = null;
	Statement statement = null;
	PreparedStatement preparedStatement = null;
	
	QuestionDaoAbstract QuestionDaoAbstract = new QuestionDaoClass();
	
	@Override
	public List<Quiz> get() {
		List<Quiz> list = null;
		Quiz quiz = null;

		try {

			list = new ArrayList<Quiz>();
			String sql = "SELECT * FROM quiz";
			connection = DataBaseConnection.openConnection();
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);
			while (resultSet.next()) {
				quiz = new Quiz();
				quiz.setId(resultSet.getInt("id"));
				quiz.setTitle(resultSet.getString("title"));
				quiz.setDescription(resultSet.getString("description"));
				quiz.setImg(resultSet.getString("quiz_image"));
				List<Question> questions = QuestionDaoAbstract.get(resultSet.getInt("id"));
				quiz.setQuestions(questions);
				quiz.setCreator(resultSet.getString("creator"));
				list.add(quiz);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public boolean update(Quiz quiz, int id) {
		boolean flag = false;
		try {
			String sql = "UPDATE quiz SET id = '" + quiz.getId() + "', " + "title = '"
					+ quiz.getTitle() + "', " + "description = '" + quiz.getDescription() +  "', " + "quiz_image = '" + quiz.getImg() +"' where id='"
					+ id + "'";
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
	public boolean save(Quiz quiz) {
		boolean flag = false;
		try {
			String sql = "INSERT INTO quiz(title, description, quiz_image, creator) VALUES" + "('" + quiz.getTitle()
					+ "', '" + quiz.getDescription() + "', '" + quiz.getImg() + "', '" + quiz.getCreator() +"')";
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
//			DELETE qui, que, answ FROM quiz qui INNER JOIN question que ON que.quizId = qui.id INNER JOIN answer answ ON answ.questId = que.questId where qui.id=1;
			String sql = "DELETE FROM quiz WHERE id ='" + id + "'";
			String sql_ = "DELETE FROM question WHERE quizId ='" + id + "'";
			String sqll = "DELETE FROM answer WHERE quizId ='" + id + "'";
			connection = DataBaseConnection.openConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.executeUpdate();
			preparedStatement = connection.prepareStatement(sql_);
			preparedStatement.executeUpdate();
			preparedStatement = connection.prepareStatement(sqll);
			preparedStatement.executeUpdate();
			flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public Quiz getQuiz(int id) {
		Quiz quiz = null;
		try {
			quiz = new Quiz();
			String sql = "SELECT * FROM quiz where id='" + id + "'";
			connection = DataBaseConnection.openConnection();
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);
			if (resultSet.next()) {
				quiz.setId(resultSet.getInt("id"));
				quiz.setTitle(resultSet.getString("title"));
				quiz.setDescription(resultSet.getString("description"));
				quiz.setImg(resultSet.getString("quiz_image"));
				List<Question> questions = QuestionDaoAbstract.get(resultSet.getInt("id"));
//				System.out.println(questions.size());
				quiz.setQuestions(questions);
				quiz.setCreator(resultSet.getString("creator"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return quiz;
	}
	
	@Override
	public Quiz getQuiz(String desc) {
		Quiz quiz = null;
		try {
			quiz = new Quiz();
			String sql = "SELECT * FROM quiz where description='" + desc + "'";
			connection = DataBaseConnection.openConnection();
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);
			if (resultSet.next()) {
				quiz.setId(resultSet.getInt("id"));
				quiz.setTitle(resultSet.getString("title"));
				quiz.setDescription(resultSet.getString("description"));
				quiz.setImg(resultSet.getString("quiz_image"));
				List<Question> questions = QuestionDaoAbstract.get(resultSet.getInt("id"));
//				System.out.println(questions.size());
				quiz.setQuestions(questions);
				quiz.setCreator(resultSet.getString("creator"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return quiz;
	}

	
	@Override
	public List<Quiz> getQuizzesforCreator(String creator) {
		List<Quiz> list = null;
		Quiz quiz = null;

		try {

			list = new ArrayList<Quiz>();
			String sql = "SELECT * FROM quiz where creator='" + creator + "'";
			connection = DataBaseConnection.openConnection();
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);
			while (resultSet.next()) {
				quiz = new Quiz();
				quiz.setId(resultSet.getInt("id"));
				quiz.setTitle(resultSet.getString("title"));
				quiz.setDescription(resultSet.getString("description"));
				quiz.setImg(resultSet.getString("quiz_image"));
				List<Question> questions = QuestionDaoAbstract.get(resultSet.getInt("id"));
				quiz.setQuestions(questions);
				quiz.setCreator(resultSet.getString("creator"));
				list.add(quiz);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	

	@Override
	public Quiz getRandomQuiz() {
		List<Quiz> quizzes = this.get();
		Random random = new Random();
		int maxIndex = quizzes.size();
		int randomIndex = random.nextInt(maxIndex);
		return quizzes.get(randomIndex);
	}
}
