package mypackage;


import java.util.List;

public interface AnswerDaoAbstract {
	List<Answer> get(int questionID, int quizID);
	boolean update(Answer answer, int id);
	boolean save(Answer answer, int quizId, int questionId);
	boolean delete(int id);
}
