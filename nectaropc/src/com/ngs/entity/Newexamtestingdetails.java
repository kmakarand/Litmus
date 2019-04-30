package com.ngs.entity;

import java.sql.Time;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Newexamtestingdetails entity. @author MyEclipse Persistence Tools
 */
@Entity
@NamedQueries({@NamedQuery(name="Analysis-Newexamtestingdetails.sql8",
		query="SELECT nxtd from Newexamtestingdetails " +
		"nxtd where nxtd.sectionId=?1 AND nxtd.candidateId=?2 AND nxtd.examId=?3 " +
		"ORDER BY nxtd.sequenceNo"),
		
		@NamedQuery(name="Analysis-Newexamtestingdetails.sql9",
		query="SELECT nxtd from Newexamtestingdetails " +
		"nxtd where nxtd.sectionId=?1 AND nxtd.candidateId=?2 and nxtd.answerStatus=1 ORDER BY nxtd.sequenceNo"),
		
		@NamedQuery(name="Analysis-Newexamtestingdetails.sql10",
		query="SELECT nxtd from Newexamtestingdetails " +
		"nxtd where nxtd.sectionId=?1 AND nxtd.candidateId=?2 and nxtd.answerStatus=2 ORDER BY nxtd.sequenceNo"),
		
		@NamedQuery(name="Analysis-Newexamtestingdetails.sql11",
		query="SELECT nxtd from Newexamtestingdetails " +
		"nxtd where nxtd.sectionId=?1 AND nxtd.candidateId=?2 and nxtd.answerStatus=0 ORDER BY nxtd.sequenceNo"),
		
		@NamedQuery(name="Analysis-Newexamtestingdetails.sql12",
		query="SELECT nxtd from Newexamtestingdetails " +
		"nxtd where nxtd.sectionId=?1 AND nxtd.candidateId=?2 and nxtd.bookMark=1 ORDER BY nxtd.sequenceNo"),
		
		@NamedQuery(name="Analysis-Newexamtestingdetails.sql14",
		query="SELECT nxtd FROM Newexamtestingdetails nxtd WHERE nxtd.sectionId=?1 "+
		" and nxtd.candidateId=?2 and nxtd.questionId=?3 and nxtd.examId=?4")
		
	})

 

@Table(name = "NewExamTestingDetails", catalog = "nectar")
public class Newexamtestingdetails implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer sectionId;
	private String codeId;
	private Integer codeGroupId;
	private Integer examId;
	private Date date;
	private Time time;
	private Integer candidateId;
	private Integer questionId;
	private String answer;
	private Integer answerStatus;
	private Integer timeTaken;
	private Integer attemptNo;
	private Integer bookMark;
	private Integer sequenceNo;

	// Constructors

	/** default constructor */
	public Newexamtestingdetails() {
	}

	/** minimal constructor */
	public Newexamtestingdetails(Integer sectionId, String codeId,
			Integer codeGroupId, Integer examId, Date date, Time time,
			Integer candidateId, Integer questionId, String answer,
			Integer answerStatus, Integer timeTaken, Integer bookMark,
			Integer sequenceNo) {
		this.sectionId = sectionId;
		this.codeId = codeId;
		this.codeGroupId = codeGroupId;
		this.examId = examId;
		this.date = date;
		this.time = time;
		this.candidateId = candidateId;
		this.questionId = questionId;
		this.answer = answer;
		this.answerStatus = answerStatus;
		this.timeTaken = timeTaken;
		this.bookMark = bookMark;
		this.sequenceNo = sequenceNo;
	}

	/** full constructor */
	public Newexamtestingdetails(Integer sectionId, String codeId,
			Integer codeGroupId, Integer examId, Date date, Time time,
			Integer candidateId, Integer questionId, String answer,
			Integer answerStatus, Integer timeTaken, Integer attemptNo,
			Integer bookMark, Integer sequenceNo) {
		this.sectionId = sectionId;
		this.codeId = codeId;
		this.codeGroupId = codeGroupId;
		this.examId = examId;
		this.date = date;
		this.time = time;
		this.candidateId = candidateId;
		this.questionId = questionId;
		this.answer = answer;
		this.answerStatus = answerStatus;
		this.timeTaken = timeTaken;
		this.attemptNo = attemptNo;
		this.bookMark = bookMark;
		this.sequenceNo = sequenceNo;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "ID", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "SectionID", nullable = false)
	public Integer getSectionId() {
		return this.sectionId;
	}

	public void setSectionId(Integer sectionId) {
		this.sectionId = sectionId;
	}

	@Column(name = "CodeID", nullable = false, length = 8)
	public String getCodeId() {
		return this.codeId;
	}

	public void setCodeId(String codeId) {
		this.codeId = codeId;
	}

	@Column(name = "CodeGroupID", nullable = false)
	public Integer getCodeGroupId() {
		return this.codeGroupId;
	}

	public void setCodeGroupId(Integer codeGroupId) {
		this.codeGroupId = codeGroupId;
	}

	@Column(name = "ExamID", nullable = false)
	public Integer getExamId() {
		return this.examId;
	}

	public void setExamId(Integer examId) {
		this.examId = examId;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "Date", nullable = false, length = 10)
	public Date getDate() {
		return this.date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	@Column(name = "Time", nullable = false, length = 8)
	public Time getTime() {
		return this.time;
	}

	public void setTime(Time time) {
		this.time = time;
	}

	@Column(name = "CandidateID", nullable = false)
	public Integer getCandidateId() {
		return this.candidateId;
	}

	public void setCandidateId(Integer candidateId) {
		this.candidateId = candidateId;
	}

	@Column(name = "QuestionID", nullable = false)
	public Integer getQuestionId() {
		return this.questionId;
	}

	public void setQuestionId(Integer questionId) {
		this.questionId = questionId;
	}

	@Column(name = "Answer", nullable = false, length = 5)
	public String getAnswer() {
		return this.answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	@Column(name = "AnswerStatus", nullable = false)
	public Integer getAnswerStatus() {
		return this.answerStatus;
	}

	public void setAnswerStatus(Integer answerStatus) {
		this.answerStatus = answerStatus;
	}

	@Column(name = "TimeTaken", nullable = false)
	public Integer getTimeTaken() {
		return this.timeTaken;
	}

	public void setTimeTaken(Integer timeTaken) {
		this.timeTaken = timeTaken;
	}

	@Column(name = "AttemptNo")
	public Integer getAttemptNo() {
		return this.attemptNo;
	}

	public void setAttemptNo(Integer attemptNo) {
		this.attemptNo = attemptNo;
	}

	@Column(name = "BookMark", nullable = false)
	public Integer getBookMark() {
		return this.bookMark;
	}

	public void setBookMark(Integer bookMark) {
		this.bookMark = bookMark;
	}

	@Column(name = "SequenceNo", nullable = false)
	public Integer getSequenceNo() {
		return this.sequenceNo;
	}

	public void setSequenceNo(Integer sequenceNo) {
		this.sequenceNo = sequenceNo;
	}

}