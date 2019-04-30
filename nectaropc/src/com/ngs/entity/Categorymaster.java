package com.ngs.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Categorymaster entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "CategoryMaster", catalog = "nectar")
public class Categorymaster implements java.io.Serializable {

	// Fields

	private String categoryId;
	private String category;

	// Constructors

	/** default constructor */
	public Categorymaster() {
	}

	/** full constructor */
	public Categorymaster(String categoryId, String category) {
		this.categoryId = categoryId;
		this.category = category;
	}

	// Property accessors
	@Id
	@Column(name = "CategoryID", unique = true, nullable = false, length = 5)
	public String getCategoryId() {
		return this.categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	@Column(name = "Category", nullable = false, length = 50)
	public String getCategory() {
		return this.category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

}