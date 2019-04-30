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
 * Nextvalues entity. @author MyEclipse Persistence Tools
 */
@Entity
@NamedQueries({@NamedQuery(name="NextValues-NextvaluesId.sql1",
		query="SELECT nv FROM Nextvalues nv WHERE nv.tableName=?1 AND nv.fieldName=?2"),
		
		@NamedQuery(name="NextValues-NextvaluesId.sql2",
		query="UPDATE Nextvalues nv SET nv.nextValue=?1 WHERE nv.tableName=?2 AND nv.fieldName=?3")
		})
@Table(name = "NextValues", catalog = "nectar")
public class Nextvalues implements java.io.Serializable {

	// Fields

	private String tableName;
	private String fieldName;
	private Integer nextValue;

	// Constructors

	/** default constructor */
	public Nextvalues() {
	}

	/** minimal constructor */
	public Nextvalues(String tableName, String fieldName) {
		this.tableName = tableName;
		this.fieldName = fieldName;
	}

	/** full constructor */
	public Nextvalues(String tableName, String fieldName, Integer nextValue) {
		this.tableName = tableName;
		this.fieldName = fieldName;
		this.nextValue = nextValue;
	}

	// Property accessors
	@Id
	@Column(name = "TableName", nullable = false, length = 50)
	public String getTableName() {
		return this.tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	@Column(name = "FieldName", nullable = false, length = 50)
	public String getFieldName() {
		return this.fieldName;
	}

	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}

	@Column(name = "NextValue")
	public Integer getNextValue() {
		return this.nextValue;
	}

	public void setNextValue(Integer nextValue) {
		this.nextValue = nextValue;
	}

}