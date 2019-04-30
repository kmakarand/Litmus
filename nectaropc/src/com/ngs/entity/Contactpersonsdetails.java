package com.ngs.entity;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Contactpersonsdetails entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "ContactPersonsDetails", catalog = "nectar")
public class Contactpersonsdetails implements java.io.Serializable {

	// Fields

	private Integer clientId;
	private String name;
	private String designation;
	private String phone1;
	private String phone2;
	private String email1;
	private String email2;

	// Constructors

	/** default constructor */
	public Contactpersonsdetails() {
	}

	/** minimal constructor */
	public Contactpersonsdetails(Integer clientId, String name) {
		this.clientId = clientId;
		this.name = name;
	}

	/** full constructor */
	public Contactpersonsdetails(Integer clientId, String name,
			String designation, String phone1, String phone2, String email1,
			String email2) {
		this.clientId = clientId;
		this.name = name;
		this.designation = designation;
		this.phone1 = phone1;
		this.phone2 = phone2;
		this.email1 = email1;
		this.email2 = email2;
	}

	// Property accessors
	@Id
	@Column(name = "ClientID", nullable = false)
	public Integer getClientId() {
		return this.clientId;
	}

	public void setClientId(Integer clientId) {
		this.clientId = clientId;
	}

	@Column(name = "Name", nullable = false)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "Designation")
	public String getDesignation() {
		return this.designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

	@Column(name = "Phone1", length = 20)
	public String getPhone1() {
		return this.phone1;
	}

	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}

	@Column(name = "Phone2", length = 20)
	public String getPhone2() {
		return this.phone2;
	}

	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}

	@Column(name = "Email1", length = 50)
	public String getEmail1() {
		return this.email1;
	}

	public void setEmail1(String email1) {
		this.email1 = email1;
	}

	@Column(name = "Email2", length = 50)
	public String getEmail2() {
		return this.email2;
	}

	public void setEmail2(String email2) {
		this.email2 = email2;
	}

}