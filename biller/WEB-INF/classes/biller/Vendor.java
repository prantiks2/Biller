 package biller;
import java.sql.*;
public class Vendor
{
int vid;public String excep="";
String vname="",vaddress="",vboss="",vbossno="",vsales="",vsalesno="",vdel="",vdelno="",voffice="",vgst="";
double vtotdue=0;
public void setVid(int vid){this.vid=vid;}
public void setVname(String vname){this.vname=vname;}
public void setVaddress(String vaddress){this.vaddress=vaddress;}
public void setVboss(String vboss){this.vboss=vboss;}
public void setVbossno(String vbossno){this.vbossno=vbossno;}
public void setVsales(String vsales){this.vsales=vsales;}
public void setVsalesno(String vsalesno){this.vsalesno=vsalesno;}
public void setVdel(String vdel){this.vdel=vdel;}
public void setVdelno(String vdelno){this.vdelno=vdelno;}
public void setVoffice(String voffice){this.voffice=voffice;}
public void setVtotdue(double vtotdue){this.vtotdue=vtotdue;}
public void setVgst(String vgst){this.vgst=vgst;}

public int getVid(){return vid;}
public String getVname(){return vname;}
public String getVaddress(){return vaddress;}
public String getVboss(){return vboss;}
public String getVbossno(){return vbossno;}
public String getVsales(){return vsales;}
public String getVsalesno(){return vsalesno;}
public String getVdel(){return vdel;}
public String getVdelno(){return vdelno;}
public String getVoffice(){return voffice;}
public double getVtotdue(){return vtotdue;}
public String getVgst(){return vgst;}

public int addVendorToDb()
{
	connect c=new connect();
	Connection con=c.getConnection();
	int t=0;ResultSet rs=null;
	try
	{
		PreparedStatement pst=con.prepareStatement("insert into biller.biller_vendor(vname,vaddress,vboss,vbossno,vsales,vsalesno,vdel,vdelno,voffice,vtotdue,vgst)values(?,?,?,?,?,?,?,?,?,0,?)");
		pst.setString(1,vname);
		pst.setString(2,vaddress);
		pst.setString(3,vboss);
		pst.setString(4,vbossno);
		pst.setString(5,vsales);
		pst.setString(6,vsalesno);
		pst.setString(7,vdel);
		pst.setString(8,vdelno);
		pst.setString(9,voffice);
		pst.setString(10,vgst);
		t=pst.executeUpdate();
		if(t>0)
		{
			pst=con.prepareStatement("select max(vid) from biller.biller_vendor");
			rs=pst.executeQuery();
			if(rs.next())
			t=rs.getInt(1);
		}
		con.close();
	}
	catch(Exception e){this.excep=(String)e.getMessage();}
	return t;
}
public ResultSet getVendorList(String search)
{
	connect c=new connect();
	Connection con=c.getConnection();
	ResultSet rs=null;
	try
	{
		PreparedStatement pst=con.prepareStatement("select * from biller.biller_vendor where vname like '"+search+"%'");
		rs=pst.executeQuery();
	}
	catch(Exception e){this.excep=(String)e.getMessage();}
	return rs;
}
public int getVendorByVid()
{
	connect c=new connect();
	Connection con=c.getConnection();
	ResultSet rs=null;int t=0;
	try
	{
		PreparedStatement pst=con.prepareStatement("select * from biller.biller_vendor where vid=?");
		pst.setInt(1,vid);
		rs=pst.executeQuery();
		if(rs.next())
		{
			this.vname=rs.getString(2);
			this.vaddress=rs.getString(3);
			this.vboss=rs.getString(4);
			this.vbossno=rs.getString(5);
			this.vsales=rs.getString(6);
			this.vsalesno=rs.getString(7);
			this.vdel=rs.getString(8);
			this.vdelno=rs.getString(9);
			this.voffice=rs.getString(10);
			this.vtotdue=Double.parseDouble(rs.getString(11));
			this.vgst=rs.getString(12);
			t=1;	
		}
		con.close();
	}
	catch(Exception e){this.excep=(String)e.getMessage();}
	return t;
}
public int deleteVendorByVid()
{
	connect c=new connect();
	Connection con=c.getConnection();
	int t=0;
	try
	{
		PreparedStatement pst=con.prepareStatement("delete from biller.biller_vendor where vid=?");
		pst.setInt(1,vid);
		t=pst.executeUpdate();
		con.close();
	}
	catch(Exception e){this.excep=(String)e.getMessage();}
	return t;
}

public int updateVendor()
{
	connect c=new connect();
	Connection con=c.getConnection();
	int t=0;
	try
	{
		PreparedStatement pst=con.prepareStatement("update biller.biller_vendor set vname=?,vaddress=?,vboss=?,vbossno=?,vsales=?,vsalesno=?,vdel=?,vdelno=?,voffice=?,vgst=? where vid=?");
		pst.setString(1,vname);
		pst.setString(2,vaddress);
		pst.setString(3,vboss);
		pst.setString(4,vbossno);
		pst.setString(5,vsales);
		pst.setString(6,vsalesno);
		pst.setString(7,vdel);
		pst.setString(8,vdelno);
		pst.setString(9,voffice);
		pst.setString(10,vgst);
		pst.setInt(11,vid);
		t=pst.executeUpdate();
		con.close();
	}
	catch(Exception e){this.excep=(String)e.getMessage();}
	return t;
}
}