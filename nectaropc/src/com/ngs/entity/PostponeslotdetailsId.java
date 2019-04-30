package com.ngs.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * PostponeslotdetailsId entity. @author MyEclipse Persistence Tools
 */
@Embeddable
public class PostponeslotdetailsId implements java.io.Serializable {

	// Fields

	private Integer candidateId;
	private Integer allotedScheduleId;
	private Integer requestedScheduleId;
	private Date postponeRequestDate;
	private Integer isApproved;

	// Constructors

	/** default constructor */
	public PostponeslotdetailsId() {
	}

	/** full constructor */
	public PostponeslotdetailsId(Integer candidateId,
			Integer allotedScheduleId, Integer requestedScheduleId,
			Date postponeRequestDate, Integer isApproved) {
		this.candidateId = candidateId;
		this.allotedScheduleId = allotedScheduleId;
		this.requestedScheduleId = requestedScheduleId;
		this.postponeRequestDate = postponeRequestDate;
		this.isApproved = isApproved;
	}

	// Property accessors

	@Column(name = "CandidateID", nullable = false)
	public Integer getCandidateId() {
		return this.candidateId;
	}

	public void setCandidateId(Integer candidateId) {
		this.candidateId = candidateId;
	}

	@Column(name = "AllotedScheduleID", nullable = false)
	public Integer getAllotedScheduleId() {
		return this.allotedScheduleId;
	}

	public void setAllotedScheduleId(Integer allotedScheduleId) {
		this.allotedScheduleId = allotedScheduleId;
	}

	@Column(name = "RequestedScheduleID", nullable = false)
	public Integer getRequestedScheduleId() {
		return this.requestedScheduleId;
	}

	public void setRequestedScheduleId(Integer requestedScheduleId) {
		this.requestedScheduleId = requestedScheduleId;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "PostponeRequestDate", nullable = false, length = 10)
	public Date getPostponeRequestDate() {
		return this.postponeRequestDate;
	}

	public void setPostponeRequestDate(Date postponeRequestDate) {
		this.postponeRequestDate = postponeRequestDate;
	}

	@Column(name = "isApproved", nullable = false)
	public Integer getIsApproved() {
		return this.isApproved;
	}

	public void setIsApproved(Integer isApproved) {
		this.isApproved = isApproved;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof PostponeslotdetailsId))
			return false;
		PostponeslotdetailsId castOther = (PostponeslotdetailsId) other;

		return ((this.getCandidateId() == castOther.getCandidateId()) || (this
				.getCandidateId() != null
				&& castOther.getCandidateId() != null && this.getCandidateId()
				.equals(castOther.getCandidateId())))
				&& ((this.getAllotedScheduleId() == castOther
						.getAllotedScheduleId()) || (this
						.getAllotedScheduleId() != null
						&& castOther.getAllotedScheduleId() != null && this
						.getAllotedScheduleId().equals(
								castOther.getAllotedScheduleId())))
				&& ((this.getRequestedScheduleId() == castOther
						.getRequestedScheduleId()) || (this
						.getRequestedScheduleId() != null
						&& castOther.getRequestedScheduleId() != null && this
						.getRequestedScheduleId().equals(
								castOther.getRequestedScheduleId())))
				&& ((this.getPostponeRequestDate() == castOther
						.getPostponeRequestDate()) || (this
						.getPostponeRequestDate() != null
						&& castOther.getPostponeRequestDate() != null && this
						.getPostponeRequestDate().equals(
								castOther.getPostponeRequestDate())))
				&& ((this.getIsApproved() == castOther.getIsApproved()) || (this
						.getIsApproved() != null
						&& castOther.getIsApproved() != null && this
						.getIsApproved().equals(castOther.getIsApproved())));
	}

	public int hashCode() {
		int result = 17;

		result = 37
				* result
				+ (getCandidateId() == null ? 0 : this.getCandidateId()
						.hashCode());
		result = 37
				* result
				+ (getAllotedScheduleId() == null ? 0 : this
						.getAllotedScheduleId().hashCode());
		result = 37
				* result
				+ (getRequestedScheduleId() == null ? 0 : this
						.getRequestedScheduleId().hashCode());
		result = 37
				* result
				+ (getPostponeRequestDate() == null ? 0 : this
						.getPostponeRequestDate().hashCode());
		result = 37
				* result
				+ (getIsApproved() == null ? 0 : this.getIsApproved()
						.hashCode());
		return result;
	}

}