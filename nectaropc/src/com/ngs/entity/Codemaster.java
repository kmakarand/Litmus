package com.ngs.entity;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Codemaster entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "CodeMaster", catalog = "nectar")
public class Codemaster implements java.io.Serializable {

	// Fields

	private String description;
	private String codeId;
	private Integer examId;

	// Constructors

	/** default constructor */
	public Codemaster() {
	}

	/** full constructor */
	public Codemaster(String codeId, Integer examId, String description) {
		this.examId = examId;
		this.description = description;
		this.codeId = codeId;
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

	@Column(name = "CodeID", nullable = false, length = 8)
	public String getCodeId() {
		return this.codeId;
	}

	public void setCodeId(String codeId) {
		this.codeId = codeId;
	}
	@Column(name = "Description", nullable = false, length = 100)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}