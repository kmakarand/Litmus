package com.ngs.entity;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Codegroupdetails entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "CodeGroupDetails", catalog = "nectar")
public class Codegroupdetails implements java.io.Serializable {

	private Integer noOfQuestions;
	private Integer codeGroupId;
	private String codeId;
	private Integer examId;

	// Constructors

	/** default constructor */
	public Codegroupdetails() {
	}

	/** full constructor */
	public Codegroupdetails(Integer examId,Integer codeGroupId, String codeId,  Integer noOfQuestions) {
		this.codeGroupId = codeGroupId;
		this.codeId = codeId;
		this.examId = examId;
		this.noOfQuestions = noOfQuestions;
	}

	// Property accessors
	
	@Id
	@Column(name = "CodeGroupID", nullable = false)
	public Integer getCodeGroupId() {
		return this.codeGroupId;
	}

	public void setCodeGroupId(Integer codeGroupId) {
		this.codeGroupId = codeGroupId;
	}
	
	@Column(name = "NoOfQuestions", nullable = false)
	public Integer getNoOfQuestions() {
		return this.noOfQuestions;
	}

	public void setNoOfQuestions(Integer noOfQuestions) {
		this.noOfQuestions = noOfQuestions;
	}
	
	@Column(name = "CodeID", nullable = false, length = 8)
	public String getCodeId() {
		return this.codeId;
	}

	public void setCodeId(String codeId) {
		this.codeId = codeId;
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
		if (!(other instanceof Codegroupdetails))
			return false;
		Codegroupdetails castOther = (Codegroupdetails) other;

		return ((this.getCodeGroupId() == castOther.getCodeGroupId()) || (this
				.getCodeGroupId() != null
				&& castOther.getCodeGroupId() != null && this.getCodeGroupId()
				.equals(castOther.getCodeGroupId())))
				&& ((this.getCodeId() == castOther.getCodeId()) || (this
						.getCodeId() != null
						&& castOther.getCodeId() != null && this.getCodeId()
						.equals(castOther.getCodeId())))
				&& ((this.getExamId() == castOther.getExamId()) || (this
						.getExamId() != null
						&& castOther.getExamId() != null && this.getExamId()
						.equals(castOther.getExamId())));
	}

	public int hashCode() {
		int result = 17;

		result = 37
				* result
				+ (getCodeGroupId() == null ? 0 : this.getCodeGroupId()
						.hashCode());
		result = 37 * result
				+ (getCodeId() == null ? 0 : this.getCodeId().hashCode());
		result = 37 * result
				+ (getExamId() == null ? 0 : this.getExamId().hashCode());
		return result;
	}


}