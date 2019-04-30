package com.ngs.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Revenuesharing entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "RevenueSharing", catalog = "nectar")
public class Revenuesharing implements java.io.Serializable {

	// Fields

	private Integer shareId;
	private String client;
	private String criteria;
	private Float amount;
	private Float zilsShare;
	private Float clientShare;

	// Constructors

	/** default constructor */
	public Revenuesharing() {
	}

	/** full constructor */
	public Revenuesharing(Integer shareId, String client, String criteria,
			Float amount, Float zilsShare, Float clientShare) {
		this.shareId = shareId;
		this.client = client;
		this.criteria = criteria;
		this.amount = amount;
		this.zilsShare = zilsShare;
		this.clientShare = clientShare;
	}

	// Property accessors
	@Id
	@Column(name = "ShareID", unique = true, nullable = false)
	public Integer getShareId() {
		return this.shareId;
	}

	public void setShareId(Integer shareId) {
		this.shareId = shareId;
	}

	@Column(name = "Client", nullable = false, length = 5)
	public String getClient() {
		return this.client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	@Column(name = "Criteria", nullable = false, length = 25)
	public String getCriteria() {
		return this.criteria;
	}

	public void setCriteria(String criteria) {
		this.criteria = criteria;
	}

	@Column(name = "Amount", nullable = false, precision = 12, scale = 0)
	public Float getAmount() {
		return this.amount;
	}

	public void setAmount(Float amount) {
		this.amount = amount;
	}

	@Column(name = "ZilsShare", nullable = false, precision = 12, scale = 0)
	public Float getZilsShare() {
		return this.zilsShare;
	}

	public void setZilsShare(Float zilsShare) {
		this.zilsShare = zilsShare;
	}

	@Column(name = "ClientShare", nullable = false, precision = 12, scale = 0)
	public Float getClientShare() {
		return this.clientShare;
	}

	public void setClientShare(Float clientShare) {
		this.clientShare = clientShare;
	}

}