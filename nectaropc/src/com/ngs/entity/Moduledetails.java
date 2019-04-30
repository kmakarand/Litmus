package com.ngs.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Moduledetails entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "ModuleDetails", catalog = "nectar")
public class Moduledetails implements java.io.Serializable {

	// Fields

	private Integer candidateId;
	private String moduleName;
	private String chapterName;
	private Integer moduleCount;
	private Integer chapterCount;

	// Constructors

	/** default constructor */
	public Moduledetails() {
	}

	/** minimal constructor */
	public Moduledetails(Integer candidateId) {
		this.candidateId = candidateId;
	}

	/** full constructor */
	public Moduledetails(Integer candidateId, String moduleName,
			String chapterName, Integer moduleCount, Integer chapterCount) {
		this.candidateId = candidateId;
		this.moduleName = moduleName;
		this.chapterName = chapterName;
		this.moduleCount = moduleCount;
		this.chapterCount = chapterCount;
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

	@Column(name = "ModuleName", length = 45)
	public String getModuleName() {
		return this.moduleName;
	}

	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}

	@Column(name = "ChapterName", length = 45)
	public String getChapterName() {
		return this.chapterName;
	}

	public void setChapterName(String chapterName) {
		this.chapterName = chapterName;
	}

	@Column(name = "ModuleCount")
	public Integer getModuleCount() {
		return this.moduleCount;
	}

	public void setModuleCount(Integer moduleCount) {
		this.moduleCount = moduleCount;
	}

	@Column(name = "ChapterCount")
	public Integer getChapterCount() {
		return this.chapterCount;
	}

	public void setChapterCount(Integer chapterCount) {
		this.chapterCount = chapterCount;
	}

}