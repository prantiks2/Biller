package biller;
import java.sql.*;
public class Customer
{
public String excep="";
String cname,caddr="",cmob,cgstin="";
int cid,cnbill;
double camtdue;
public void setCname(String cname){this.cname=cname;}
public void setCaddr(String caddr){this.caddr=caddr;}
public void setCgstin(String cgstin){this.cgstin=cgstin;}
public void setCmob(String cmob){this.cmob=cmob;}
public void setCid(int cid){this.cid=cid;}
public void setCnbill(int cnbill){this.cnbill=cnbill;}
public void setCamtdue(double camtdue){this.camtdue=camtdue;}

public String getCname(){return cname;}
public String getCaddr(){return caddr;}
public String getCgstin(){return cgstin;}
public String getCmob(){return cmob;}
public double getCamtdue(){return camtdue;}
public int getCid(){return cid;}
public int getCnbill(){return cnbill;}

public int insertCustomerToDb()
{
	connect c=new connect();
	Connection con=c.getConnection();
	int t=0;
	ResultSet rs=null;
	try
	{
		PreparedStatement pst=con.prepareStatement("insert into biller.biller_customer(cname,caddr,cgstin,cmob,cnbill,camtdue)values(?,?,?,?,0,0)");
		pst.setString(1,cname);
		pst.setString(2,caddr);
		pst.setString(3,cgstin);
		pst.setString(4,cmob);
		t=pst.executeUpdate();
		if(t>0)
		{
			pst=con.prepareStatement("select max(cid) from biller.biller_customer");
			rs=pst.executeQuery();
			if(rs.next())
			t=rs.getInt(1);
		}
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return t;
}

public int getCustomer()
{
	connect co=new connect();
	Connection con=co.getConnection();
	int t=0;
	ResultSet rs=null;
	try
	{
		PreparedStatement pst=con.prepareStatement("select * from biller.biller_customer where cid=?");
		pst.setInt(1,cid);
		rs=pst.executeQuery();
		if(rs.next())
		{
			this.cname=rs.getString(2);
			this.caddr=rs.getString(3);
			this.cgstin=rs.getString(4);
			this.cmob=rs.getString(5);
			this.cnbill=Integer.parseInt(rs.getString(6));
			this.camtdue=Double.parseDouble(rs.getString(7));
			t=1;			
		}
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return t;
}

public int deleteCustomer()
{
	connect co=new connect();
	Connection con=co.getConnection();
	int t=0;
	try
	{
		PreparedStatement pst=con.prepareStatement("delete from biller.biller_customer where cid=?");
		pst.setInt(1,cid);
		t=pst.executeUpdate();
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return t;
}
public ResultSet getCustomerList(String search)
{
	connect c=new connect();
	Connection con=c.getConnection();
	ResultSet rs=null;
	try
	{
		PreparedStatement pst=con.prepareStatement("select * from biller.biller_customer where cname like '"+search+"%'");
		rs=pst.executeQuery();
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return rs;
}
public int updateCustomer()
{
	connect c=new connect();
	Connection con=c.getConnection();
	int t=0;
	try
	{
		PreparedStatement pst=con.prepareStatement("update biller.biller_customer set cname=?,caddr=?,cgstin=?,cmob=?,cnbill=?,camtdue=? where cid=?");
		pst.setString(1,cname);
		pst.setString(2,caddr);
		pst.setString(3,cgstin);
		pst.setString(4,cmob);
		pst.setString(5,String.valueOf(cnbill));
		pst.setString(6,String.valueOf(camtdue));
		pst.setInt(7,cid);
		t=pst.executeUpdate();
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return t;
}
}