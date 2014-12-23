package beans;

import java.io.Serializable;

import org.json.JSONObject;
//not used yet
public class ReceiveEducation implements Serializable,JsonAble{

    /** 
     * Persistent Instance variables. This data is directly 
     * mapped to the columns of database table.
     */
    private int userId;
    private int educationId;
    private long startDate;
    private long endDate;



    /** 
     * Constructors. DaoGen generates two constructors by default.
     * The first one takes no arguments and provides the most simple
     * way to create object instance. The another one takes one
     * argument, which is the primary key of the corresponding table.
     */

    public ReceiveEducation () {

    }

    public ReceiveEducation (int userIdIn, int educationIdIn) {

          this.userId = userIdIn;
          this.educationId = educationIdIn;

    }


    /** 
     * Get- and Set-methods for persistent variables. The default
     * behaviour does not make any checks against malformed data,
     * so these might require some manual additions.
     */

    public int getUserId() {
          return this.userId;
    }
    public void setUserId(int userIdIn) {
          this.userId = userIdIn;
    }

    public int getEducationId() {
          return this.educationId;
    }
    public void setEducationId(int educationIdIn) {
          this.educationId = educationIdIn;
    }

    public long getStartDate() {
          return this.startDate;
    }
    public void setStartDate(long startDateIn) {
          this.startDate = startDateIn;
    }

    public long getEndDate() {
          return this.endDate;
    }
    public void setEndDate(long endDateIn) {
          this.endDate = endDateIn;
    }



    /** 
     * setAll allows to set all persistent variables in one method call.
     * This is useful, when all data is available and it is needed to 
     * set the initial state of this object. Note that this method will
     * directly modify instance variales, without going trough the 
     * individual set-methods.
     */

    public void setAll(int userIdIn,
          int educationIdIn,
          long startDateIn,
          long endDateIn) {
          this.userId = userIdIn;
          this.educationId = educationIdIn;
          this.startDate = startDateIn;
          this.endDate = endDateIn;
    }
	public JSONObject toJson(){
		JSONObject jo = new JSONObject();
		jo.put("user_id", userId);
		jo.put("education_id", educationId);
		jo.put("start_date", startDate);
		jo.put("end_date", endDate);
		return jo;
	}
}
