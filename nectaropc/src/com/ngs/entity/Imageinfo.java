package com.ngs.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

/**
 * Imageinfo entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "imageinfo", catalog = "nectar")
public class Imageinfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer questionId;
	private Integer optionNo;
	private byte[] image;

	// Constructors

	/** default constructor */
	public Imageinfo() {
	}

	/** full constructor */
	public Imageinfo(Integer id, Integer questionId, Integer optionNo,
			byte[] image) {
		this.id = id;
		this.questionId = questionId;
		this.optionNo = optionNo;
		this.image = image;
	}

	// Property accessors
	@Id
	@Column(name = "Id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "QuestionId", nullable = false)
	public Integer getQuestionId() {
		return this.questionId;
	}

	public void setQuestionId(Integer questionId) {
		this.questionId = questionId;
	}

	@Column(name = "OptionNo", nullable = false)
	public Integer getOptionNo() {
		return this.optionNo;
	}

	public void setOptionNo(Integer optionNo) {
		this.optionNo = optionNo;
	}

	  @Lob @Column(name="Image")
	  public byte[] getImage() {
	    return image;
	  }
	
	  public void setImage(byte[] picture) {
	    this.image = image;
	  }


}