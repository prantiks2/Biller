package billing;
import java.sql.*;
public class logincheck
{
String logid,pass;
public void setLogid(String logid)
{
	this.logid=logid;
}
public void setPass(String pass)
{
	this.pass=pass;
}
public String check()
{
	connect ob=new connect();
	String name="";
	try{
	PreparedStatement pst=ob.con.prepareStatement("select * from billing.billing_user where id=? and pass=?");
	pst.setString(1,logid);
	pst.setString(2,pass);
	ResultSet rs=pst.executeQuery();
	name=rs.getString(3);
	}
	catch(Exception e){System.out.println("Exception at logincheck.java"+e);}
	return name;
}
}