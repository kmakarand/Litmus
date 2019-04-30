package com.ngs.ats;

public class ExamMaster {
	private int ExamID;
	private int ModeratorID;
	private String Exam;
	private int ExamMode;
	private String StartDate;
	private String EndDate;
	private String ConductedBy;
	private String Centre;
	private String Country;
	private int Frequency;
	private int ShowResults;
	private int DisplayTests;
	private int StoreID;
	private float RegistrationFee;

	public ExamMaster() {
		ExamID = 0;
		ModeratorID = 0;
		Exam = null;
		ExamMode = 0;
		StartDate = null;
		EndDate = null;
		ConductedBy = null;
		Centre = null;
		Country = null;
		Frequency = 0;
		ShowResults = 0;
		DisplayTests = 0;
		StoreID = 0;
		RegistrationFee=0;
	}
	
	public void setExamID(int value) {
		if(value > 0)
			ExamID = value;
	}
	public int getExamID() {
		return ExamID;
	}
	public void setModeratorID(int value) {
		if(value > 0)
			ModeratorID = value;
	}
	public int getModeratorID() {
		return ModeratorID;
	}
	public void setExam(String value) {
		if(value != null || !value.equals(null) || value!="")
			Exam = value;
	}
	public String getExam() {
		return Exam;
	}
	public void setExamMode(int value) {
		if(value > 0)
			ExamMode = value;
	}
	public int getExamMode() {
		return ExamMode;
	}
	public void setStartDate(String value) {
		if(value != null || !value.equals(null) || value!="")
			StartDate = value;
	}
	public String getStartDate() {
		return StartDate;
	}
	public void setEndDate(String value) {
		if(value != null || !value.equals(null) || value!="")
			EndDate = value;
	}
	public String getEndDate() {
		return EndDate;
	}
	public void setConductedBy(String value) {
		if(value != null || !value.equals(null) || value!="")
			ConductedBy = value;
	}
	public String getConductedBy() {
		return ConductedBy;
	}
	public void setCentre(String value) {
		if(value != null || !value.equals(null) || value!="")
			Centre = value;
	}
	public String getCentre() {
		return Centre;
	}
	public void setCountry(String value) {
		if(value != null || !value.equals(null) || value!="")
			Country = value;
	}
	public String getCountry() {
		return Country;
	}
	public void setFrequency(int value) {
		if(value > 0)
			Frequency = value;
	}
	public int getFrequency() {
		return Frequency;
	}
	public void setShowResults(int value) {
		if(value > 0)
			ShowResults = value;
	}
	public int getShowResults() {
		return ShowResults;
	}
	public void setDisplayTests(int value) {
		if(value > 0)
			DisplayTests = value;
	}
	public int getDisplayTests() {
		return DisplayTests;
	}
	public void setStoreID(int value) {
		if(value > 0)
			StoreID = value;
	}
	public int getStoreID() {
		return StoreID;
	}
	public void setRegistrationFee(float value) {
		if(value > 0)
			RegistrationFee = value;
	}
	public float getRegistrationFee() {
		return RegistrationFee;
	}
}