package com.ngs.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;

/**
 * ImagedetailsId entity. @author MyEclipse Persistence Tools
 */
@Embeddable
@NamedQueries({@NamedQuery(name="Analysis-NewexamdetailsId.sql13",
		query="SELECT nxdid.testName FROM NewexamdetailsId nxdid WHERE nxdid.examId=:examid and nxid.sectionId=:sectionid")	
		
		
})

public class ImagedetailsId implements java.io.Serializable {

	// Fields

	private Integer questionId;
	private String image;
	private Integer sequenceId;

	// Constructors

	/** default constructor */
	public ImagedetailsId() {
	}

	/** full constructor */
	public ImagedetailsId(Integer questionId, String image, Integer sequenceId) {
		this.questionId = questionId;
		this.image = image;
		this.sequenceId = sequenceId;
	}

	// Property accessors

	@Column(name = "QuestionID", nullable = false)
	public Integer getQuestionId() {
		return this.questionId;
	}

	public void setQuestionId(Integer questionId) {
		this.questionId = questionId;
	}

	@Column(name = "Image", nullable = false, length = 50)
	public String getImage() {
		return this.image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	@Column(name = "SequenceID", nullable = false)
	public Integer getSequenceId() {
		return this.sequenceId;
	}

	public void setSequenceId(Integer sequenceId) {
		this.sequenceId = sequenceId;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof ImagedetailsId))
			return false;
		ImagedetailsId castOther = (ImagedetailsId) other;

		return ((this.getQuestionId() == castOther.getQuestionId()) || (this
				.getQuestionId() != null
				&& castOther.getQuestionId() != null && this.getQuestionId()
				.equals(castOther.getQuestionId())))
				&& ((this.getImage() == castOther.getImage()) || (this
						.getImage() != null
						&& castOther.getImage() != null && this.getImage()
						.equals(castOther.getImage())))
				&& ((this.getSequenceId() == castOther.getSequenceId()) || (this
						.getSequenceId() != null
						&& castOther.getSequenceId() != null && this
						.getSequenceId().equals(castOther.getSequenceId())));
	}

	public int hashCode() {
		int result = 17;

		result = 37
				* result
				+ (getQuestionId() == null ? 0 : this.getQuestionId()
						.hashCode());
		result = 37 * result
				+ (getImage() == null ? 0 : this.getImage().hashCode());
		result = 37
				* result
				+ (getSequenceId() == null ? 0 : this.getSequenceId()
						.hashCode());
		return result;
	}

}