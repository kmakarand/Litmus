package com.ngs.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * CodemasterId entity. @author MyEclipse Persistence Tools
 */
@Embeddable
public class CodemasterId implements java.io.Serializable {

	// Fields

	private String codeId;
	private Integer examId;

	// Constructors

	/** default constructor */
	public CodemasterId() {
	}

	/** full constructor */
	public CodemasterId(String codeId, Integer examId) {
		this.codeId = codeId;
		this.examId = examId;
	}

	// Property accessors

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
		if (!(other instanceof CodemasterId))
			return false;
		CodemasterId castOther = (CodemasterId) other;

		return ((this.getCodeId() == castOther.getCodeId()) || (this
				.getCodeId() != null
				&& castOther.getCodeId() != null && this.getCodeId().equals(
				castOther.getCodeId())))
				&& ((this.getExamId() == castOther.getExamId()) || (this
						.getExamId() != null
						&& castOther.getExamId() != null && this.getExamId()
						.equals(castOther.getExamId())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getCodeId() == null ? 0 : this.getCodeId().hashCode());
		result = 37 * result
				+ (getExamId() == null ? 0 : this.getExamId().hashCode());
		return result;
	}

}