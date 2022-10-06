package mypackage;

import java.util.List;


public class Quiz {
	private int id;
	private String title;
	private String description;
	List<Question> questions;
	private int points;
	private String img;
	private String creator;

	public Quiz() {}

	public Quiz(int id, String title, String description, List<Question> questions, int points) {
		this.id = id;
		this.title = title;
		this.description = description;
		this.questions = questions;
		this.points = points;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<Question> getQuestions() {
		return questions;
	}

	public void setQuestions(List<Question> questions) {
		this.questions = questions;
	}

	public int getPoints() {
		return points;
	}

	public void setPoints(int points) {
		this.points = points;
	}


	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}
	
	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	@Override
	public String toString() {
		return "id=" + id + ", title=" + title + ", description=" + description + "";
	}

	
}
