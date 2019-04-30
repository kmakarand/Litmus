package com.ngs.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;

/**
 * NextvaluesId entity. @author MyEclipse Persistence Tools
 */
@Embeddable
@NamedQueries({@NamedQuery(name="NextValues-NextvaluesId.sql1",
		query="SELECT nv.nextValue FROM NextValues nv WHERE nv.tableName=:table AND nv.fieldName=:field"),
		
		@NamedQuery(name="NextValues-NextvaluesId.sql2",
		query="UPDATE NextValues SET nv.nextValue=:nextValue WHERE nv.tableName=:table AND nv.fieldName=:field")
		})

public class NextvaluesId implements java.io.Serializable {

	// Fields

	private String tableName;
	private String fieldName;
	private Integer nextValue;

	// Constructors

	/** default constructor */
	public NextvaluesId() {
	}

	/** minimal constructor */
	public NextvaluesId(String tableName, String fieldName) {
		this.tableName = tableName;
		this.fieldName = fieldName;
	}

	/** full constructor */
	public NextvaluesId(String tableName, String fieldName, Integer nextValue) {
		this.tableName = tableName;
		this.fieldName = fieldName;
		this.nextValue = nextValue;
	}

	// Property accessors

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

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof NextvaluesId))
			return false;
		NextvaluesId castOther = (NextvaluesId) other;

		return ((this.getTableName() == castOther.getTableName()) || (this
				.getTableName() != null
				&& castOther.getTableName() != null && this.getTableName()
				.equals(castOther.getTableName())))
				&& ((this.getFieldName() == castOther.getFieldName()) || (this
						.getFieldName() != null
						&& castOther.getFieldName() != null && this
						.getFieldName().equals(castOther.getFieldName())))
				&& ((this.getNextValue() == castOther.getNextValue()) || (this
						.getNextValue() != null
						&& castOther.getNextValue() != null && this
						.getNextValue().equals(castOther.getNextValue())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getTableName() == null ? 0 : this.getTableName().hashCode());
		result = 37 * result
				+ (getFieldName() == null ? 0 : this.getFieldName().hashCode());
		result = 37 * result
				+ (getNextValue() == null ? 0 : this.getNextValue().hashCode());
		return result;
	}

}