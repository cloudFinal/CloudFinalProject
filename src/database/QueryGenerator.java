package database;
//generate query available in sql
public class QueryGenerator {
	public static String locationIdGenerate(String address){
		return String.valueOf(address.hashCode());
	}
	public static String dateFormat(String date){
		return "to_date('"+date+"','yyyy-mm-dd')";
	}
	public static String timeFormat(String time){
		return "to_date('"+time+"','yyyy-mm-dd HH24:MI:SS')";
	}
	//name+type:value
	public static String insertQ(String tableName, String... parameters){
		if(parameters.length!=0 && parameters.length%3==0){
			String[] attributeName = new String[parameters.length/3];
			String[] value = new String[parameters.length/3];
			String[] type = new String[parameters.length/3];
			for(int i=0;i<value.length;i++){
				attributeName[i]=parameters[3*i];
				type[i]=parameters[3*i+1];
				value[i]=parameters[3*i+2];
			}
			StringBuffer sb = new StringBuffer();
			sb.append("insert into "+tableName+"(");
			for(int i=0;i<attributeName.length;i++){
				sb.append(attributeName[i]+",");
			}
			sb.deleteCharAt(sb.length()-1);
			sb.append(") values(");
			insertAppend(sb,value,type);
			sb.deleteCharAt(sb.length()-1);
			sb.append(")");
			System.out.println(sb.toString());
			return sb.toString(); 
		}else{
			return null;
		}
	}
	public static String updateQ(String tableName, String... parameters){
		if(parameters.length!=0 && parameters.length%3==0){
			String[] attributeName = new String[parameters.length/3];
			String[] value = new String[parameters.length/3];
			String[] type = new String[parameters.length/3];
			for(int i=0;i<value.length;i++){
				attributeName[i]=parameters[3*i];
				type[i]=parameters[3*i+1];
				value[i]=parameters[3*i+2];
			}
			StringBuffer sb = new StringBuffer();
			sb.append("update "+tableName+" set ");
			updateAppend(sb,attributeName,value,type);
			sb.deleteCharAt(sb.length()-1);
			sb.append(" ");
			System.out.println(sb.toString());
			return sb.toString(); 
		}else{
			return null;
		}
	}
	public static String whereQ(String... parameters){
		if(parameters.length!=0 && parameters.length%3==0){
			String[] attributeName = new String[parameters.length/3];
			String[] value = new String[parameters.length/3];
			String[] type = new String[parameters.length/3];
			for(int i=0;i<value.length;i++){
				attributeName[i]=parameters[3*i];
				type[i]=parameters[3*i+1];
				value[i]=parameters[3*i+2];
			}
			StringBuffer sb = new StringBuffer();
			sb.append("where ");
			updateAppend(sb,attributeName,value,type);
			sb.deleteCharAt(sb.length()-1);
			System.out.println(sb.toString());
			return sb.toString(); 
		}else{
			return null;
		}
	}
	public static String deleteQ(String tableName,String... parameters){
		if(parameters.length!=0 && parameters.length%3==0){
			String[] attributeName = new String[parameters.length/3];
			String[] value = new String[parameters.length/3];
			String[] type = new String[parameters.length/3];
			for(int i=0;i<value.length;i++){
				attributeName[i]=parameters[3*i];
				type[i]=parameters[3*i+1];
				value[i]=parameters[3*i+2];
			}
			StringBuffer sb = new StringBuffer();
			sb.append("delete from "+tableName+" where ");
			deleteAppend(sb,attributeName,value,type);
			sb.deleteCharAt(sb.length()-1);
			sb.deleteCharAt(sb.length()-1);
			sb.deleteCharAt(sb.length()-1);
			sb.deleteCharAt(sb.length()-1);
			sb.deleteCharAt(sb.length()-1);
			sb.append(" ");
			System.out.println(sb.toString());
			return sb.toString(); 
		}else{
			return null;
		}
	}
	public static void updateAppend(StringBuffer sb,String[] attributeName,String[] value,String[] type){
		for(int i=0;i<value.length;i++){
			if(value[i]==null || !type[i].equals("String")){
				if(type[i].equals("Date")){
					sb.append(attributeName[i]+"="+dateFormat(value[i])+",");
					continue;
					//sb.append(attributeName[i]+"="+"what"+",");
				}
				if(type[i].equals("Time")){
					sb.append(attributeName[i]+"="+timeFormat(value[i])+",");
					continue;
				}
					sb.append(attributeName[i]+"="+value[i]+",");
			}else{
				sb.append(attributeName[i]+"='"+value[i]+"',");
			}
		}
	}
	public static void insertAppend(StringBuffer sb,String[] value,String[] type){
		for(int i=0;i<value.length;i++){
			if(value[i]==null || !type[i].equals("String")){
				if(type[i].equals("Date")){
					sb.append(dateFormat(value[i])+",");
					continue;
				}
				if(type[i].equals("Time")){
					sb.append(timeFormat(value[i])+",");
					continue;
				}
					sb.append(value[i]+",");
			}else{
				sb.append("'"+value[i]+"',");
			}
		}
	}
	public static void deleteAppend(StringBuffer sb,String[] attributeName,String[] value,String[] type){
		for(int i=0;i<value.length;i++){
			if(value[i]==null || !type[i].equals("String")){
				if(type[i].equals("Date")){
					sb.append(attributeName[i]+"="+dateFormat(value[i])+" and ");
					continue;
					//sb.append(attributeName[i]+"="+"what"+",");
				}
				if(type[i].equals("Time")){
					sb.append(attributeName[i]+"="+timeFormat(value[i])+" and ");
					continue;
				}
				sb.append(attributeName[i]+"="+value[i]+" and ");
			}else{
				sb.append(attributeName[i]+"='"+value[i]+"' and ");
			}
		}
	}
}
