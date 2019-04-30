package com.ngs.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Chapterdetails entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "ChapterDetails", catalog = "nectar")
public class Chapterdetails implements java.io.Serializable {

	// Fields

	private Integer candidateId;
	private String moduleName;
	private Integer ch1count;
	private Integer ch2count;
	private Integer ch3count;
	private Integer ch4count;
	private Integer ch5count;
	private Integer ch6count;
	private Integer ch7count;
	private Integer ch8count;

	// Constructors

	/** default constructor */
	public Chapterdetails() {
	}

	/** minimal constructor */
	public Chapterdetails(Integer candidateId) {
		this.candidateId = candidateId;
	}

	/** full constructor */
	public Chapterdetails(Integer candidateId, String moduleName,
			Integer ch1count, Integer ch2count, Integer ch3count,
			Integer ch4count, Integer ch5count, Integer ch6count,
			Integer ch7count, Integer ch8count) {
		this.candidateId = candidateId;
		this.moduleName = moduleName;
		this.ch1count = ch1count;
		this.ch2count = ch2count;
		this.ch3count = ch3count;
		this.ch4count = ch4count;
		this.ch5count = ch5count;
		this.ch6count = ch6count;
		this.ch7count = ch7count;
		this.ch8count = ch8count;
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

	@Column(name = "Ch1Count")
	public Integer getCh1count() {
		return this.ch1count;
	}

	public void setCh1count(Integer ch1count) {
		this.ch1count = ch1count;
	}

	@Column(name = "Ch2Count")
	public Integer getCh2count() {
		return this.ch2count;
	}

	public void setCh2count(Integer ch2count) {
		this.ch2count = ch2count;
	}

	@Column(name = "Ch3Count")
	public Integer getCh3count() {
		return this.ch3count;
	}

	public void setCh3count(Integer ch3count) {
		this.ch3count = ch3count;
	}

	@Column(name = "Ch4Count")
	public Integer getCh4count() {
		return this.ch4count;
	}

	public void setCh4count(Integer ch4count) {
		this.ch4count = ch4count;
	}

	@Column(name = "Ch5Count")
	public Integer getCh5count() {
		return this.ch5count;
	}

	public void setCh5count(Integer ch5count) {
		this.ch5count = ch5count;
	}

	@Column(name = "Ch6Count")
	public Integer getCh6count() {
		return this.ch6count;
	}

	public void setCh6count(Integer ch6count) {
		this.ch6count = ch6count;
	}

	@Column(name = "Ch7Count")
	public Integer getCh7count() {
		return this.ch7count;
	}

	public void setCh7count(Integer ch7count) {
		this.ch7count = ch7count;
	}
	
	@Column(name = "Ch8Count")
	public Integer getCh8count() {
		return this.ch8count;
	}

	public void setCh8count(Integer ch8count) {
		this.ch8count = ch8count;
	}

}