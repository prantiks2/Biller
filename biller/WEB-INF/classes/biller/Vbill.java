package biller;
import java.sql.*;
import java.util.*;
import java.text.*;
public class Vbill
{
public String excep="";
String vbdate="",vbpdate="",vbpmode="",vbpid="";
int vbid,vid;
double vbamt,vbamtpaid,vboutamt,vbpamt,vtotdue;

public void setVbdate(String vbdate){this.vbdate=vbdate;}
public void setVbpdate(String vbpdate){this.vbpdate=vbpdate;}
public void setVbpmode(String vbpmode){this.vbpmode=vbpmode;}
public void setVbid(int vbid){this.vbid=vbid;}
public void setVid(int vid){this.vid=vid;}
public void setVbamt(double vbamt){this.vbamt=vbamt;}
public void setVbpamt(double vbpamt){this.vbpamt=vbpamt;}

public String getVbdate(){return vbdate;}
public String getVbpdate(){return vbpdate;}
public String getVbpmode(){return vbpmode;}
public String getVbpid(){return vbpid;}
public int getVbid(){return vbid;}
public int getVid(){return vid;}
public double getVbamt(){return vbamt;}
public double getVbpamt(){return vbpamt;}
public double getVbamtpaid(){return vbamtpaid;}
public double getVboutamt(){return vboutamt;}

public int insertVbillToDb()
{
	connect c=new connect();
	Connection con=c.getConnection();
	int t=0;vbamtpaid=0;vboutamt=vbamt;
	try
	{
		PreparedStatement pst=con.prepareStatement("insert into biller.biller_vbill(vid,vbdate,vbamt,vbamtpaid,vboutamt)values(?,?,?,?,?)");
		pst.setInt(1,vid);
		pst.setString(2,vbdate);
		pst.setString(3,String.valueOf(vbamt));
		pst.setString(4,String.valueOf(vbamtpaid));
		pst.setString(5,String.valueOf(vboutamt));
		t=pst.executeUpdate();
		this.caltotdue();
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return t;
}
public int Vbillpay()
{
	connect c=new connect();
	Connection con=c.getConnection();
	int t=0;double amtpa=0,otamt=0;
	DateFormat df = new SimpleDateFormat("dd/MM/yy HH:mm:ss");
        java.util.Date dateobj = new java.util.Date();
        vbpid=df.format(dateobj);
	ResultSet rs=null;
	try
	{
		PreparedStatement pst=con.prepareStatement("insert into biller.biller_vpayhist(vbpid,vbid,vbpdate,vbpamt,vbpmode)values(?,?,?,?,?)");
		pst.setString(1,vbpid);
		pst.setInt(2,vbid);
		pst.setString(3,vbpdate);
		pst.setString(4,String.valueOf(vbpamt));
		pst.setString(5,vbpmode);
		t=pst.executeUpdate();
		if(t>0)
		{
			pst=con.prepareStatement("select * from biller.biller_vbill where vbid=?");
			pst.setInt(1,vbid);
			rs=pst.executeQuery();
			if(rs.next())
			{
				amtpa=Double.parseDouble(rs.getString(5));
				otamt=Double.parseDouble(rs.getString(6));
				amtpa=amtpa+vbpamt;
				otamt=otamt-vbpamt;
				pst=con.prepareStatement("update biller.biller_vbill set vbamtpaid=?,vboutamt=? where vbid=?");
				pst.setString(1,String.valueOf(amtpa));
				pst.setString(2,String.valueOf(otamt));
				pst.setInt(3,vbid);
				t=pst.executeUpdate();
				this.caltotdue();
			}
		}

	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return t;
}
public int deleteVbill()
{
	connect co=new connect();
	Connection con=co.getConnection();
	int t=0;
	try
	{
		PreparedStatement pst=con.prepareStatement("delete from biller.biller_vpayhist where vbid=?");
		pst.setInt(1,vbid);
		t=pst.executeUpdate();
		pst=con.prepareStatement("delete from biller.biller_vbill where vbid=?");
		pst.setInt(1,vbid);
		t=pst.executeUpdate();
		this.caltotdue();
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return t;
}
public ResultSet getVbillListByVid()
{
	connect c=new connect();
	Connection con=c.getConnection();
	ResultSet rs=null;
	try
	{
		PreparedStatement pst=con.prepareStatement("select * from biller.biller_vbill where vid=?");
		pst.setInt(1,vid);
		rs=pst.executeQuery();
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return rs;
}
public int getVbill()
{
	connect c=new connect();
	Connection con=c.getConnection();
	ResultSet rs=null;int t=0;
	try
	{
		PreparedStatement pst=con.prepareStatement("select * from biller.biller_vbill where vbid=?");
		pst.setInt(1,vbid);
		rs=pst.executeQuery();
		if(rs.next())
		{
			this.vbdate=rs.getString(3);
			this.vbamt=Double.parseDouble(rs.getString(4));
			this.vbamtpaid=Double.parseDouble(rs.getString(5));
			this.vboutamt=Double.parseDouble(rs.getString(6));
			t=1;			
		}
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return t;
}
public void caltotdue()
{
	connect c=new connect();
	Connection con=c.getConnection();
	ResultSet rs=null;
	double tot=0;
	try
	{
		PreparedStatement pst=con.prepareStatement("select vboutamt from biller.biller_vbill where vid=?");
		pst.setInt(1,vid);
		rs=pst.executeQuery();
		while(rs.next())
		{
			tot=tot+Double.parseDouble(rs.getString(1));	
		}
		pst=con.prepareStatement("update biller.biller_vendor set vtotdue=? where vid=?");
		pst.setString(1,String.valueOf(tot));
		pst.setInt(2,vid);
		pst.executeUpdate();
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
}
public ResultSet getVbillPayList()
{
	connect c=new connect();
	Connection con=c.getConnection();
	ResultSet rs=null;
	try
	{
		PreparedStatement pst=con.prepareStatement("select * from biller.biller_vpayhist where vbid=? order by vbpid");
		pst.setInt(1,vbid);
		rs=pst.executeQuery();
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return rs;
}
}