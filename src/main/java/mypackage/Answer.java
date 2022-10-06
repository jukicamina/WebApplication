package mypackage;


public class Answer {
	private int answId;
	private int quizId; 
	private int questionId;
	private String answText;
	private Boolean correct;
	
	public Answer() {}
	
	public Answer(int answId, int questionId, String answText) {
		super();
		this.answId = answId;
		this.questionId = questionId;
		this.answText = answText;
	}

	public int getAnswId() {
		return answId;
	}

	public void setAnswId(int answId) {
		this.answId = answId;
	}

	public int getQuizId() {
		return quizId;
	}

	public void setQuizId(int quizId) {
		this.quizId = quizId;
	}

	public int getQuestionId() {
		return questionId;
	}

	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}

	public String getAnswText() {
		return answText;
	}

	public void setAnswText(String answText) {
		this.answText = answText;
	}

	public Boolean isCorrect() {
		return correct;
	}

	public void setCorrect(Boolean correct) {
		this.correct = correct;
	}

	@Override
	public String toString() {
		return "id=" + this.answId + ", text=" + this.answText + ", questID=" + this.questionId + "";
	}
	
}