package com.ngs.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Userdetails entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "UserDetails", catalog = "nectar")
public class Userdetails implements java.io.Serializable {

	// Fields

	private Integer candidateId;
	private Integer examId;
	private Integer levelId;
	private Integer moduleCount;
	private Integer language;

	// Constructors

	/** default constructor */
	public Userdetails() {
	}

	/** minimal constructor */
	public Userdetails(Integer candidateId) {
		this.candidateId = candidateId;
	}

	/** full constructor */
	public Userdetails(Integer candidateId, Integer examId, Integer levelId,
			Integer moduleCount, Integer language) {
		this.candidateId = candidateId;
		this.examId = examId;
		this.levelId = levelId;
		this.moduleCount = moduleCount;
		this.language = language;
	}

	// Property accessors
	@Id
	@Column(name = "CandidateID", unique = true, nullable = false)
	public Integer getCandidateId() {
		return this.candidateId;
	}

	public void setCandidateId(Integer candidateId) {
		this.candidateId = candidateId;
	}

	@Column(name = "ExamID")
	public Integer getExamId() {
		return this.examId;
	}

	public void setExamId(Integer examId) {
		this.examId = examId;
	}

	@Column(name = "LevelID")
	public Integer getLevelId() {
		return this.levelId;
	}

	public void setLevelId(Integer levelId) {
		this.levelId = levelId;
	}

	@Column(name = "ModuleCount")
	public Integer getModuleCount() {
		return this.moduleCount;
	}

	public void setModuleCount(Integer moduleCount) {
		this.moduleCount = moduleCount;
	}

	@Column(name = "Language")
	public Integer getLanguage() {
		return this.language;
	}

	public void setLanguage(Integer language) {
		this.language = language;
	}

}