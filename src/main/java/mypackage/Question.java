package mypackage;

import java.util.List;
import com.fasterxml.jackson.annotation.JsonIgnore;


public class Question {
	private int questId;
	private int quizId;
	private int time;
	private int points;
	private String text;
	List<Answer> answers;
	int index;
	
	public Question() {}
	
	
	public Question(int questId, int quizId, int time, int points, String text, List<Answer> answers, int index) {
		super();
		this.questId = questId;
		this.quizId = quizId;
		this.time = time;
		this.points = points;
		this.text = text;
		this.answers = answers;
		this.index = index;
	}

	public int getQuestId() {
		return questId;
	}

	public void setQuestId(int questId) {
		this.questId = questId;
	}

	public int getQuizId() {
		return quizId;
	}

	public void setQuizId(int quizId) {
		this.quizId = quizId;
	}

	public int getTime() {
		return time;
	}

	public void setTime(int time) {
		this.time = time;
		
	}

	public int getPoints() {
		return points;
	}

	public void setPoints(int points) {
		this.points = points;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public List<Answer> getAnswers() {
		return answers;
	}

	public void setAnswers(List<Answer> answers) {
		this.answers = answers;
	}
	
	@JsonIgnore
	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	@Override
	public String toString() {
		return "id=" + this.questId + ", text=" + this.text + ", quiz=" + this.quizId + "answers, " + this.answers;
	}	
	
	
}
