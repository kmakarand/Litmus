package com.ngs.entity;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Usergroupxref entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "UserGroupXRef", catalog = "nectar")
public class Usergroupxref implements java.io.Serializable {

	// Fields

	private String username;
	private String groupId;

	// Constructors

	/** default constructor */
	public Usergroupxref() {
	}

	/** full constructor */
	public Usergroupxref(String username, String groupId) {
		this.username = username;
		this.groupId = groupId;
	}

	// Property accessors
	@Id
	@Column(name = "Username", nullable = false, length = 10)
	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Column(name = "GroupID", nullable = false, length = 2)
	public String getGroupId() {
		return this.groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof Usergroupxref))
			return false;
		Usergroupxref castOther = (Usergroupxref) other;

		return ((this.getUsername() == castOther.getUsername()) || (this
				.getUsername() != null
				&& castOther.getUsername() != null && this.getUsername()
				.equals(castOther.getUsername())))
				&& ((this.getGroupId() == castOther.getGroupId()) || (this
						.getGroupId() != null
						&& castOther.getGroupId() != null && this.getGroupId()
						.equals(castOther.getGroupId())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getUsername() == null ? 0 : this.getUsername().hashCode());
		result = 37 * result
				+ (getGroupId() == null ? 0 : this.getGroupId().hashCode());
		return result;
	}


}