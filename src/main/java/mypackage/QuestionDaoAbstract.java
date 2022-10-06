package mypackage;

import java.util.List;


public interface QuestionDaoAbstract {
	List<Question> get(int quizID);
	boolean update(Question question, int id);
	boolean save(Question question, int quizId);
	boolean delete(Question question, int id);
}
