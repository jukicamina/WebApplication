package mypackage;

import java.util.List;
import java.util.Random;


public interface QuizDaoAbstract {
	List<Quiz> get();
	Quiz getQuiz(int id);
	Quiz getQuiz(String desc);
	boolean update(Quiz quiz, int id);
	boolean save(Quiz quiz);
	boolean delete(int id);
	Quiz getRandomQuiz();
	List<Quiz> getQuizzesforCreator(String creator);
		
}
