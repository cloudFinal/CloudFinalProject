package beans;

import java.io.Serializable;

public class Education implements Serializable{
	/** 
	 * Get- and Set-methods for persistent variables. The default
	 * behaviour does not make any checks against malformed data,
	 * so these might require some manual additions.
	 */
	private int educationId;
    private String school;
    private String major;
    private String degree;
	public int getEducationId() {
	      return this.educationId;
	}
	public void setEducationId(int educationIdIn) {
	      this.educationId = educationIdIn;
	}

	public String getSchool() {
	      return this.school;
	}
	public void setSchool(String schoolIn) {
	      this.school = schoolIn;
	}
	public String getMajor() {
	      return this.major;
	}
	public void setMajor(String majorIn) {
	      this.major = majorIn;
	}

	public String getDegree() {
	      return this.degree;
	}
	public void setDegree(String degreeIn) {
	      this.degree = degreeIn;
	}



	/** 
	 * setAll allows to set all persistent variables in one method call.
	 * This is useful, when all data is available and it is needed to 
	 * set the initial state of this object. Note that this method will
	 * directly modify instance variales, without going trough the 
	 * individual set-methods.
	 */

	public void setAll(int educationIdIn,
	      String schoolIn,
	      String majorIn,
	      String degreeIn) {
	      this.educationId = educationIdIn;
	      this.school = schoolIn;
	      this.major = majorIn;
	      this.degree = degreeIn;
	}
}