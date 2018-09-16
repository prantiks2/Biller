package biller;
import java.sql.*;
public class checkuser
{
String logid,pass;
public String name="",excep="";
public void setLogid(String logid)
{
	this.logid=logid;
}
public void setPass(String pass)
{
	this.pass=pass;
}
public boolean check()
{
	connect c=new connect();
	Connection con=c.getConnection();
	boolean validity=false;
	try
	{
	PreparedStatement pst=con.prepareStatement("select * from biller.biller_user where id=? and pass=?");
	pst.setString(1,logid);
	pst.setString(2,pass);	
	ResultSet rs=pst.executeQuery();
	if(rs.next())
		{
			name=rs.getString(3);
			validity=true;
		}
	con.close();
	}
	catch(Exception e)
	{
	this.excep="Exception in class checkuser method check():"+(String)e.getMessage();
	}
	finally
	{
	return validity;
	}
}
}