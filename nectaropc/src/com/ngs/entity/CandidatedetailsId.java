package com.ngs.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;

/**
 * CandidatedetailsId entity. @author MyEclipse Persistence Tools
 */
@Embeddable

public class CandidatedetailsId implements java.io.Serializable {

	// Fields

	private Integer candidateId;
	private Integer examId;

	// Constructors

	/** default constructor */
	public CandidatedetailsId() {
	}

	/** full constructor */
	public CandidatedetailsId(Integer candidateId, Integer examId) {
		this.candidateId = candidateId;
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
		if (!(other instanceof CandidatedetailsId))
			return false;
		CandidatedetailsId castOther = (CandidatedetailsId) other;

		return ((this.getCandidateId() == castOther.getCandidateId()) || (this
				.getCandidateId() != null
				&& castOther.getCandidateId() != null && this.getCandidateId()
				.equals(castOther.getCandidateId())))
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
		result = 37 * result
				+ (getExamId() == null ? 0 : this.getExamId().hashCode());
		return result;
	}

}