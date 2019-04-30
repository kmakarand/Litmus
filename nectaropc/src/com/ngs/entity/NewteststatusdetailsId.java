package com.ngs.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * NewteststatusdetailsId entity. @author MyEclipse Persistence Tools
 */
@Embeddable
public class NewteststatusdetailsId implements java.io.Serializable {

	// Fields

	private Integer candidateId;
	private Integer codeGroupId;
	private Integer examId;

	// Constructors

	/** default constructor */
	public NewteststatusdetailsId() {
	}

	/** full constructor */
	public NewteststatusdetailsId(Integer candidateId, Integer codeGroupId,
			Integer examId) {
		this.candidateId = candidateId;
		this.codeGroupId = codeGroupId;
		this.examId = examId;
	}

	// Property accessors

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

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof NewteststatusdetailsId))
			return false;
		NewteststatusdetailsId castOther = (NewteststatusdetailsId) other;

		return ((this.getCandidateId() == castOther.getCandidateId()) || (this
				.getCandidateId() != null
				&& castOther.getCandidateId() != null && this.getCandidateId()
				.equals(castOther.getCandidateId())))
				&& ((this.getCodeGroupId() == castOther.getCodeGroupId()) || (this
						.getCodeGroupId() != null
						&& castOther.getCodeGroupId() != null && this
						.getCodeGroupId().equals(castOther.getCodeGroupId())))
				&& ((this.getExamId() == castOther.getExamId()) || (this
						.getExamId() != null
						&& castOther.getExamId() != null && this.getExamId()
						.equals(castOther.getExamId())));
	}

	public int hashCode() {
		int result = 17;

		result = 37
				* result
				+ (getCandidateId() == null ? 0 : this.getCandidateId()
						.hashCode());
		result = 37
				* result
				+ (getCodeGroupId() == null ? 0 : this.getCodeGroupId()
						.hashCode());
		result = 37 * result
				+ (getExamId() == null ? 0 : this.getExamId().hashCode());
		return result;
	}

}