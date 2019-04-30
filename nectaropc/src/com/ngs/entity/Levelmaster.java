package com.ngs.entity;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Levelmaster entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "LevelMaster", catalog = "nectar")
public class Levelmaster implements java.io.Serializable {

	// Fields

	private Integer examId;
	private Integer levelId;
	private String level;

	// Constructors

	/** default constructor */
	public Levelmaster() {
	}

	/** full constructor */
	public Levelmaster(Integer examId, Integer levelId, String level) {
		this.examId = examId;
		this.levelId = levelId;
		this.level = level;
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

	@Column(name = "LevelID", nullable = false)
	public Integer getLevelId() {
		return this.levelId;
	}

	public void setLevelId(Integer levelId) {
		this.levelId = levelId;
	}

	@Column(name = "Level", nullable = false, length = 15)
	public String getLevel() {
		return this.level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof Levelmaster))
			return false;
		Levelmaster castOther = (Levelmaster) other;

		return ((this.getExamId() == castOther.getExamId()) || (this
				.getExamId() != null
				&& castOther.getExamId() != null && this.getExamId().equals(
				castOther.getExamId())))
				&& ((this.getLevelId() == castOther.getLevelId()) || (this
						.getLevelId() != null
						&& castOther.getLevelId() != null && this.getLevelId()
						.equals(castOther.getLevelId())))
				&& ((this.getLevel() == castOther.getLevel()) || (this
						.getLevel() != null
						&& castOther.getLevel() != null && this.getLevel()
						.equals(castOther.getLevel())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getExamId() == null ? 0 : this.getExamId().hashCode());
		result = 37 * result
				+ (getLevelId() == null ? 0 : this.getLevelId().hashCode());
		result = 37 * result
				+ (getLevel() == null ? 0 : this.getLevel().hashCode());
		return result;
	}

}