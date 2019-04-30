package com.ngs.entity;

import java.util.Date;
import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Paymentdetails entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "PaymentDetails", catalog = "nectar")
public class Paymentdetails implements java.io.Serializable {

	// Fields

	private Integer examId;
	private Integer candidateId;
	private Float amount;
	private String currency;
	private Date date;
	private String modeOfPayment;
	private String bank;
	private String branch;
	private String chequeNo;
	private Integer isPaymentRealized;
	private Date realizationDate;
	private Integer isChequeBounced;

	// Constructors

	/** default constructor */
	public Paymentdetails() {
	}

	/** minimal constructor */
	public Paymentdetails(Integer examId, Integer candidateId, Float amount, String currency,
			Date date) {
		this.examId = examId;
		this.candidateId = candidateId;
		this.amount = amount;
		this.currency = currency;
		this.date = date;
	}

	/** full constructor */
	public Paymentdetails(Integer examId, Integer candidateId,Float amount, String currency,
			Date date, String modeOfPayment, String bank, String branch,
			String chequeNo, Integer isPaymentRealized, Date realizationDate,
			Integer isChequeBounced) {
		this.examId = examId;
		this.candidateId = candidateId;
		this.amount = amount;
		this.currency = currency;
		this.date = date;
		this.modeOfPayment = modeOfPayment;
		this.bank = bank;
		this.branch = branch;
		this.chequeNo = chequeNo;
		this.isPaymentRealized = isPaymentRealized;
		this.realizationDate = realizationDate;
		this.isChequeBounced = isChequeBounced;
	}

	@Id
	@Column(name = "CandidateID", nullable = false)
	public Integer getCandidateId() {
		return this.candidateId;
	}

	public void setCandidateId(Integer candidateId) {
		this.candidateId = candidateId;
	}
	@Column(name = "ExamID", nullable = false)
	public Integer getExamId() {
		return this.examId;
	}

	public void setExamId(Integer examId) {
		this.examId = examId;
	}

	@Column(name = "Amount", nullable = false, precision = 12, scale = 0)
	public Float getAmount() {
		return this.amount;
	}

	public void setAmount(Float amount) {
		this.amount = amount;
	}

	@Column(name = "Currency", nullable = false, length = 5)
	public String getCurrency() {
		return this.currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "Date", nullable = false, length = 10)
	public Date getDate() {
		return this.date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	@Column(name = "ModeOfPayment", length = 10)
	public String getModeOfPayment() {
		return this.modeOfPayment;
	}

	public void setModeOfPayment(String modeOfPayment) {
		this.modeOfPayment = modeOfPayment;
	}

	@Column(name = "Bank", length = 50)
	public String getBank() {
		return this.bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	@Column(name = "Branch", length = 25)
	public String getBranch() {
		return this.branch;
	}

	public void setBranch(String branch) {
		this.branch = branch;
	}

	@Column(name = "ChequeNo", length = 10)
	public String getChequeNo() {
		return this.chequeNo;
	}

	public void setChequeNo(String chequeNo) {
		this.chequeNo = chequeNo;
	}

	@Column(name = "isPaymentRealized")
	public Integer getIsPaymentRealized() {
		return this.isPaymentRealized;
	}

	public void setIsPaymentRealized(Integer isPaymentRealized) {
		this.isPaymentRealized = isPaymentRealized;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "RealizationDate", length = 10)
	public Date getRealizationDate() {
		return this.realizationDate;
	}

	public void setRealizationDate(Date realizationDate) {
		this.realizationDate = realizationDate;
	}

	@Column(name = "isChequeBounced")
	public Integer getIsChequeBounced() {
		return this.isChequeBounced;
	}

	public void setIsChequeBounced(Integer isChequeBounced) {
		this.isChequeBounced = isChequeBounced;
	}

}