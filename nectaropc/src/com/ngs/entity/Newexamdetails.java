package com.ngs.entity;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * Newexamdetails entity. @author MyEclipse Persistence Tools
 */
@Entity
@NamedQueries({
		
	@NamedQuery(name="AddScheduleForm-NewexamdetailsId.sql3",
	query="SELECT nxid FROM Newexamdetails nxid"),
	
	@NamedQuery(name="Analysis-NewExamDetails.sql4",
	query="SELECT nxid.sectionId,nxid.testName from Newexamdetails nxid where nxid.examId =?1"),
			
	@NamedQuery(name="Analysis-NewExamDetailsId.sql7",
	query="SELECT nxid.negativeMarks from Newexamdetails nxid where nxid.examId=?1"),
	
	@NamedQuery(name="Analysis-NewexamdetailsId.sql13",
	query="SELECT nxdid.testName FROM Newexamdetails nxdid WHERE nxdid.examId=?1 and nxdid.sectionId=?2"),	

	@NamedQuery(name="Analysis-NewexamdetailsId.sql20",
	query="Select nxdid.noOfQuestions,nxdid.levelId from Newexamdetails nxdid where nxdid.examId=?1 and nxdid.sectionId=?2")	
			
	
})

@Table(name = "NewExamDetails", catalog = "nectar")
public class Newexamdetails implements java.io.Serializable {

	// Fields

	private Integer examId;
	private Integer sectionId;
	private Integer codeGroupId;
	private String testName;
	private Integer noOfSections;
	private String sectionName;
	private Integer noOfQuestions;
	private Integer timerType;
	private Integer responseTime;
	private Integer sectionTime;
	private Integer sequenceId;
	private Float negativeMarks;
	private Integer levelId;
	private Integer includeSublevels;
	private Float criteria;
	private Integer noOfBreaksAllowed;
	private Integer breakInterval;
	private Integer prerequisite;
	private Integer noOfAttemptsAllowed;
	private Integer examTime;
	private Integer adaptive;
	private Integer uplimit;
	private Integer downlimit;

	// Constructors

	/** default constructor */
	public Newexamdetails() {
	}

	/** minimal constructor */
	public Newexamdetails(Integer examId, Integer sectionId,
			Integer codeGroupId, String testName, Integer noOfSections,
			String sectionName, Integer noOfQuestions, Integer timerType,
			Integer responseTime, Integer sectionTime, Float negativeMarks,
			Integer levelId, Float criteria, Integer breakInterval,
			Integer examTime, Integer adaptive, Integer uplimit,
			Integer downlimit) {
		this.examId = examId;
		this.sectionId = sectionId;
		this.codeGroupId = codeGroupId;
		this.testName = testName;
		this.noOfSections = noOfSections;
		this.sectionName = sectionName;
		this.noOfQuestions = noOfQuestions;
		this.timerType = timerType;
		this.responseTime = responseTime;
		this.sectionTime = sectionTime;
		this.negativeMarks = negativeMarks;
		this.levelId = levelId;
		this.criteria = criteria;
		this.breakInterval = breakInterval;
		this.examTime = examTime;
		this.adaptive = adaptive;
		this.uplimit = uplimit;
		this.downlimit = downlimit;
	}

	/** full constructor */
	public Newexamdetails(Integer examId, Integer sectionId,
			Integer codeGroupId, String testName, Integer noOfSections,
			String sectionName, Integer noOfQuestions, Integer timerType,
			Integer responseTime, Integer sectionTime, Integer sequenceId,
			Float negativeMarks, Integer levelId, Integer includeSublevels,
			Float criteria, Integer noOfBreaksAllowed, Integer breakInterval,
			Integer prerequisite, Integer noOfAttemptsAllowed,
			Integer examTime, Integer adaptive, Integer uplimit,
			Integer downlimit) {
		this.examId = examId;
		this.sectionId = sectionId;
		this.codeGroupId = codeGroupId;
		this.testName = testName;
		this.noOfSections = noOfSections;
		this.sectionName = sectionName;
		this.noOfQuestions = noOfQuestions;
		this.timerType = timerType;
		this.responseTime = responseTime;
		this.sectionTime = sectionTime;
		this.sequenceId = sequenceId;
		this.negativeMarks = negativeMarks;
		this.levelId = levelId;
		this.includeSublevels = includeSublevels;
		this.criteria = criteria;
		this.noOfBreaksAllowed = noOfBreaksAllowed;
		this.breakInterval = breakInterval;
		this.prerequisite = prerequisite;
		this.noOfAttemptsAllowed = noOfAttemptsAllowed;
		this.examTime = examTime;
		this.adaptive = adaptive;
		this.uplimit = uplimit;
		this.downlimit = downlimit;
	}

	// Property accessors
	@Id
	@Column(name = "ExamID", nullable = false)
	public Integer getExamId() {
		return this.examId;
	}

	public void setExamId(Integer examId) {
		this.examId = examId;
	}

	@Column(name = "SectionID", nullable = false)
	public Integer getSectionId() {
		return this.sectionId;
	}

	public void setSectionId(Integer sectionId) {
		this.sectionId = sectionId;
	}

	@Column(name = "CodeGroupID", nullable = false)
	public Integer getCodeGroupId() {
		return this.codeGroupId;
	}

	public void setCodeGroupId(Integer codeGroupId) {
		this.codeGroupId = codeGroupId;
	}

	@Column(name = "TestName", nullable = false, length = 100)
	public String getTestName() {
		return this.testName;
	}

	public void setTestName(String testName) {
		this.testName = testName;
	}

	@Column(name = "NoOfSections", nullable = false)
	public Integer getNoOfSections() {
		return this.noOfSections;
	}

	public void setNoOfSections(Integer noOfSections) {
		this.noOfSections = noOfSections;
	}

	@Column(name = "SectionName", nullable = false, length = 25)
	public String getSectionName() {
		return this.sectionName;
	}

	public void setSectionName(String sectionName) {
		this.sectionName = sectionName;
	}

	@Column(name = "NoOfQuestions", nullable = false)
	public Integer getNoOfQuestions() {
		return this.noOfQuestions;
	}

	public void setNoOfQuestions(Integer noOfQuestions) {
		this.noOfQuestions = noOfQuestions;
	}

	@Column(name = "TimerType", nullable = false)
	public Integer getTimerType() {
		return this.timerType;
	}

	public void setTimerType(Integer timerType) {
		this.timerType = timerType;
	}

	@Column(name = "ResponseTime", nullable = false)
	public Integer getResponseTime() {
		return this.responseTime;
	}

	public void setResponseTime(Integer responseTime) {
		this.responseTime = responseTime;
	}

	@Column(name = "SectionTime", nullable = false)
	public Integer getSectionTime() {
		return this.sectionTime;
	}

	public void setSectionTime(Integer sectionTime) {
		this.sectionTime = sectionTime;
	}

	@Column(name = "SequenceID")
	public Integer getSequenceId() {
		return this.sequenceId;
	}

	public void setSequenceId(Integer sequenceId) {
		this.sequenceId = sequenceId;
	}

	@Column(name = "NegativeMarks", nullable = false, precision = 4)
	public Float getNegativeMarks() {
		return this.negativeMarks;
	}

	public void setNegativeMarks(Float negativeMarks) {
		this.negativeMarks = negativeMarks;
	}

	@Column(name = "LevelID", nullable = false)
	public Integer getLevelId() {
		return this.levelId;
	}

	public void setLevelId(Integer levelId) {
		this.levelId = levelId;
	}

	@Column(name = "IncludeSublevels")
	public Integer getIncludeSublevels() {
		return this.includeSublevels;
	}

	public void setIncludeSublevels(Integer includeSublevels) {
		this.includeSublevels = includeSublevels;
	}

	@Column(name = "Criteria", nullable = false, precision = 5)
	public Float getCriteria() {
		return this.criteria;
	}

	public void setCriteria(Float criteria) {
		this.criteria = criteria;
	}

	@Column(name = "NoOfBreaksAllowed")
	public Integer getNoOfBreaksAllowed() {
		return this.noOfBreaksAllowed;
	}

	public void setNoOfBreaksAllowed(Integer noOfBreaksAllowed) {
		this.noOfBreaksAllowed = noOfBreaksAllowed;
	}

	@Column(name = "BreakInterval", nullable = false)
	public Integer getBreakInterval() {
		return this.breakInterval;
	}

	public void setBreakInterval(Integer breakInterval) {
		this.breakInterval = breakInterval;
	}

	@Column(name = "Prerequisite")
	public Integer getPrerequisite() {
		return this.prerequisite;
	}

	public void setPrerequisite(Integer prerequisite) {
		this.prerequisite = prerequisite;
	}

	@Column(name = "NoOfAttemptsAllowed")
	public Integer getNoOfAttemptsAllowed() {
		return this.noOfAttemptsAllowed;
	}

	public void setNoOfAttemptsAllowed(Integer noOfAttemptsAllowed) {
		this.noOfAttemptsAllowed = noOfAttemptsAllowed;
	}

	@Column(name = "ExamTime", nullable = false)
	public Integer getExamTime() {
		return this.examTime;
	}

	public void setExamTime(Integer examTime) {
		this.examTime = examTime;
	}

	@Column(name = "adaptive", nullable = false)
	public Integer getAdaptive() {
		return this.adaptive;
	}

	public void setAdaptive(Integer adaptive) {
		this.adaptive = adaptive;
	}

	@Column(name = "uplimit", nullable = false)
	public Integer getUplimit() {
		return this.uplimit;
	}

	public void setUplimit(Integer uplimit) {
		this.uplimit = uplimit;
	}

	@Column(name = "downlimit", nullable = false)
	public Integer getDownlimit() {
		return this.downlimit;
	}

	public void setDownlimit(Integer downlimit) {
		this.downlimit = downlimit;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof Newexamdetails))
			return false;
		Newexamdetails castOther = (Newexamdetails) other;

		return ((this.getExamId() == castOther.getExamId()) || (this
				.getExamId() != null
				&& castOther.getExamId() != null && this.getExamId().equals(
				castOther.getExamId())))
				&& ((this.getSectionId() == castOther.getSectionId()) || (this
						.getSectionId() != null
						&& castOther.getSectionId() != null && this
						.getSectionId().equals(castOther.getSectionId())))
				&& ((this.getCodeGroupId() == castOther.getCodeGroupId()) || (this
						.getCodeGroupId() != null
						&& castOther.getCodeGroupId() != null && this
						.getCodeGroupId().equals(castOther.getCodeGroupId())))
				&& ((this.getTestName() == castOther.getTestName()) || (this
						.getTestName() != null
						&& castOther.getTestName() != null && this
						.getTestName().equals(castOther.getTestName())))
				&& ((this.getNoOfSections() == castOther.getNoOfSections()) || (this
						.getNoOfSections() != null
						&& castOther.getNoOfSections() != null && this
						.getNoOfSections().equals(castOther.getNoOfSections())))
				&& ((this.getSectionName() == castOther.getSectionName()) || (this
						.getSectionName() != null
						&& castOther.getSectionName() != null && this
						.getSectionName().equals(castOther.getSectionName())))
				&& ((this.getNoOfQuestions() == castOther.getNoOfQuestions()) || (this
						.getNoOfQuestions() != null
						&& castOther.getNoOfQuestions() != null && this
						.getNoOfQuestions()
						.equals(castOther.getNoOfQuestions())))
				&& ((this.getTimerType() == castOther.getTimerType()) || (this
						.getTimerType() != null
						&& castOther.getTimerType() != null && this
						.getTimerType().equals(castOther.getTimerType())))
				&& ((this.getResponseTime() == castOther.getResponseTime()) || (this
						.getResponseTime() != null
						&& castOther.getResponseTime() != null && this
						.getResponseTime().equals(castOther.getResponseTime())))
				&& ((this.getSectionTime() == castOther.getSectionTime()) || (this
						.getSectionTime() != null
						&& castOther.getSectionTime() != null && this
						.getSectionTime().equals(castOther.getSectionTime())))
				&& ((this.getSequenceId() == castOther.getSequenceId()) || (this
						.getSequenceId() != null
						&& castOther.getSequenceId() != null && this
						.getSequenceId().equals(castOther.getSequenceId())))
				&& ((this.getNegativeMarks() == castOther.getNegativeMarks()) || (this
						.getNegativeMarks() != null
						&& castOther.getNegativeMarks() != null && this
						.getNegativeMarks()
						.equals(castOther.getNegativeMarks())))
				&& ((this.getLevelId() == castOther.getLevelId()) || (this
						.getLevelId() != null
						&& castOther.getLevelId() != null && this.getLevelId()
						.equals(castOther.getLevelId())))
				&& ((this.getIncludeSublevels() == castOther
						.getIncludeSublevels()) || (this.getIncludeSublevels() != null
						&& castOther.getIncludeSublevels() != null && this
						.getIncludeSublevels().equals(
								castOther.getIncludeSublevels())))
				&& ((this.getCriteria() == castOther.getCriteria()) || (this
						.getCriteria() != null
						&& castOther.getCriteria() != null && this
						.getCriteria().equals(castOther.getCriteria())))
				&& ((this.getNoOfBreaksAllowed() == castOther
						.getNoOfBreaksAllowed()) || (this
						.getNoOfBreaksAllowed() != null
						&& castOther.getNoOfBreaksAllowed() != null && this
						.getNoOfBreaksAllowed().equals(
								castOther.getNoOfBreaksAllowed())))
				&& ((this.getBreakInterval() == castOther.getBreakInterval()) || (this
						.getBreakInterval() != null
						&& castOther.getBreakInterval() != null && this
						.getBreakInterval()
						.equals(castOther.getBreakInterval())))
				&& ((this.getPrerequisite() == castOther.getPrerequisite()) || (this
						.getPrerequisite() != null
						&& castOther.getPrerequisite() != null && this
						.getPrerequisite().equals(castOther.getPrerequisite())))
				&& ((this.getNoOfAttemptsAllowed() == castOther
						.getNoOfAttemptsAllowed()) || (this
						.getNoOfAttemptsAllowed() != null
						&& castOther.getNoOfAttemptsAllowed() != null && this
						.getNoOfAttemptsAllowed().equals(
								castOther.getNoOfAttemptsAllowed())))
				&& ((this.getExamTime() == castOther.getExamTime()) || (this
						.getExamTime() != null
						&& castOther.getExamTime() != null && this
						.getExamTime().equals(castOther.getExamTime())))
				&& ((this.getAdaptive() == castOther.getAdaptive()) || (this
						.getAdaptive() != null
						&& castOther.getAdaptive() != null && this
						.getAdaptive().equals(castOther.getAdaptive())))
				&& ((this.getUplimit() == castOther.getUplimit()) || (this
						.getUplimit() != null
						&& castOther.getUplimit() != null && this.getUplimit()
						.equals(castOther.getUplimit())))
				&& ((this.getDownlimit() == castOther.getDownlimit()) || (this
						.getDownlimit() != null
						&& castOther.getDownlimit() != null && this
						.getDownlimit().equals(castOther.getDownlimit())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getExamId() == null ? 0 : this.getExamId().hashCode());
		result = 37 * result
				+ (getSectionId() == null ? 0 : this.getSectionId().hashCode());
		result = 37
				* result
				+ (getCodeGroupId() == null ? 0 : this.getCodeGroupId()
						.hashCode());
		result = 37 * result
				+ (getTestName() == null ? 0 : this.getTestName().hashCode());
		result = 37
				* result
				+ (getNoOfSections() == null ? 0 : this.getNoOfSections()
						.hashCode());
		result = 37
				* result
				+ (getSectionName() == null ? 0 : this.getSectionName()
						.hashCode());
		result = 37
				* result
				+ (getNoOfQuestions() == null ? 0 : this.getNoOfQuestions()
						.hashCode());
		result = 37 * result
				+ (getTimerType() == null ? 0 : this.getTimerType().hashCode());
		result = 37
				* result
				+ (getResponseTime() == null ? 0 : this.getResponseTime()
						.hashCode());
		result = 37
				* result
				+ (getSectionTime() == null ? 0 : this.getSectionTime()
						.hashCode());
		result = 37
				* result
				+ (getSequenceId() == null ? 0 : this.getSequenceId()
						.hashCode());
		result = 37
				* result
				+ (getNegativeMarks() == null ? 0 : this.getNegativeMarks()
						.hashCode());
		result = 37 * result
				+ (getLevelId() == null ? 0 : this.getLevelId().hashCode());
		result = 37
				* result
				+ (getIncludeSublevels() == null ? 0 : this
						.getIncludeSublevels().hashCode());
		result = 37 * result
				+ (getCriteria() == null ? 0 : this.getCriteria().hashCode());
		result = 37
				* result
				+ (getNoOfBreaksAllowed() == null ? 0 : this
						.getNoOfBreaksAllowed().hashCode());
		result = 37
				* result
				+ (getBreakInterval() == null ? 0 : this.getBreakInterval()
						.hashCode());
		result = 37
				* result
				+ (getPrerequisite() == null ? 0 : this.getPrerequisite()
						.hashCode());
		result = 37
				* result
				+ (getNoOfAttemptsAllowed() == null ? 0 : this
						.getNoOfAttemptsAllowed().hashCode());
		result = 37 * result
				+ (getExamTime() == null ? 0 : this.getExamTime().hashCode());
		result = 37 * result
				+ (getAdaptive() == null ? 0 : this.getAdaptive().hashCode());
		result = 37 * result
				+ (getUplimit() == null ? 0 : this.getUplimit().hashCode());
		result = 37 * result
				+ (getDownlimit() == null ? 0 : this.getDownlimit().hashCode());
		return result;
	}

}