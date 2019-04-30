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
 * Candidatedetails entity. @author MyEclipse Persistence Tools
 */
@Entity
@NamedQueries({
	@NamedQuery(name="Analysis-Candidatedetails.sql3",
	query="SELECT cd.examId from Candidatedetails cd where cd.candidateId =?1")
	})

@Table(name = "CandidateDetails", catalog = "nectar")
public class Candidatedetails implements java.io.Serializable {

	// Fields

	private Integer candidateId;
	private Integer examId;

	// Constructors

	/** default constructor */
	public Candidatedetails() {
	}

	/** full constructor */
	public Candidatedetails(Integer candidateId, Integer examId) {
		this.candidateId = candidateId;
		this.examId = examId;
	}

	// Property accessors
	@Id
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