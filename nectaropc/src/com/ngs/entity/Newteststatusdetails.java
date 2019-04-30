package com.ngs.entity;

import java.util.Date;
import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Newteststatusdetails entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "NewTestStatusDetails", catalog = "nectar")
public class Newteststatusdetails implements java.io.Serializable {

	// Fields

	private Integer candidateId;
	private Integer codeGroupId;
	private Integer examId;
	private Integer sectionId;
	private Integer testMode;
	private Integer status;
	private Date downloadDate;
	private Date uploadDate;
	private Integer sequenceId;
	private Integer attemptNo;

	// Constructors

	/** default constructor */
	public Newteststatusdetails() {
	}

	/** minimal constructor */
	public Newteststatusdetails(Integer candidateId, Integer codeGroupId,
			Integer examId, Integer sectionId,
			Integer status, Integer sequenceId) {
		this.candidateId = candidateId;
		this.codeGroupId = codeGroupId;
		this.examId = examId;
		this.sectionId = sectionId;
		this.status = status;
		this.sequenceId = sequenceId;
	}

	/** full constructor */
	public Newteststatusdetails(Integer candidateId, Integer codeGroupId,
			Integer examId, Integer sectionId,
			Integer testMode, Integer status, Date downloadDate,
			Date uploadDate, Integer sequenceId, Integer attemptNo) {
		this.candidateId = candidateId;
		this.codeGroupId = codeGroupId;
		this.examId = examId;
		this.sectionId = sectionId;
		this.testMode = testMode;
		this.status = status;
		this.downloadDate = downloadDate;
		this.uploadDate = uploadDate;
		this.sequenceId = sequenceId;
		this.attemptNo = attemptNo;
	}
	
	@Id
	@Column(name = "CandidateID", nullable = false)
	public Integer getCandidateId() {
		return this.candidateId;
	}

	public void setCandidateId(Integer candidateId) {
		this.candidateId = candidateId;
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

	@Column(name = "SectionID", nullable = false)
	public Integer getSectionId() {
		return this.sectionId;
	}

	public void setSectionId(Integer sectionId) {
		this.sectionId = sectionId;
	}

	@Column(name = "TestMode")
	public Integer getTestMode() {
		return this.testMode;
	}

	public void setTestMode(Integer testMode) {
		this.testMode = testMode;
	}

	@Column(name = "Status", nullable = false)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "DownloadDate", length = 10)
	public Date getDownloadDate() {
		return this.downloadDate;
	}

	public void setDownloadDate(Date downloadDate) {
		this.downloadDate = downloadDate;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "UploadDate", length = 10)
	public Date getUploadDate() {
		return this.uploadDate;
	}

	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}

	@Column(name = "SequenceID", nullable = false)
	public Integer getSequenceId() {
		return this.sequenceId;
	}

	public void setSequenceId(Integer sequenceId) {
		this.sequenceId = sequenceId;
	}

	@Column(name = "AttemptNo")
	public Integer getAttemptNo() {
		return this.attemptNo;
	}

	public void setAttemptNo(Integer attemptNo) {
		this.attemptNo = attemptNo;
	}

}