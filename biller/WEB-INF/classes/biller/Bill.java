package biller;
import java.sql.*;
public class Bill
{
public String excep="";
String bdate,btot,brtot,bdis,bgtot,bpaid,bdue,bpft,bstat,binitpay;
int cid,bid,bsln;

String shpname,shpgst,shpphn,shpadr;

public void setBdate(String bdate){this.bdate=bdate;}
public void setBtot(String btot){this.btot=btot;}
public void setBrtot(String brtot){this.brtot=brtot;}
public void setBdis(String bdis){this.bdis=bdis;}
public void setBgtot(String bgtot){this.bgtot=bgtot;}
public void setBpaid(String bpaid){this.bpaid=bpaid;}
public void setBdue(String bdue){this.bdue=bdue;}
public void setBpft(String bpft){this.bpft=bpft;}
public void setBstat(String bstat){this.bstat=bstat;}
public void setBid(int bid){this.bid=bid;}
public void setCid(int cid){this.cid=cid;}
public void setBsln(int bsln){this.bsln=bsln;}

public String getBdate(){return bdate;}
public String getBtot(){return btot;}
public String getBrtot(){return brtot;}
public String getBdis(){return bdis;}
public String getBgtot(){return bgtot;}
public String getBpaid(){return bpaid;}
public String getBdue(){return bdue;}
public String getBpft(){return bpft;}
public String getBstat(){return bstat;}
public String getBinitpay(){return binitpay;}
public int getBid(){return bid;}
public int getCid(){return cid;}

public String getShopName(){return shpname;}
public String getShopGst(){return shpgst;}
public String getShopPhn(){return shpphn;}
public String getShopAddr(){return shpadr;}

public int insertBillToDb()
{
	connect c=new connect();
	Connection con=c.getConnection();
	int t=0;
	if(this.bdue.equals("0"))
	this.bstat="Full Paid";
	else
	this.bstat="Due Bill";
	ResultSet rs=null;
	try
	{
		PreparedStatement pst=con.prepareStatement("insert into biller.biller_bill(cid,bdate,btot,brtot,bdis,bgtot,bpaid,bdue,bstat,bpft,binitpay)values(?,?,?,?,?,?,?,?,?,?,?)");
		pst.setInt(1,cid);
		pst.setString(2,bdate);
		pst.setString(3,btot);
		pst.setString(4,brtot);
		pst.setString(5,bdis);
		pst.setString(6,bgtot);
		pst.setString(7,bpaid);
		pst.setString(8,bdue);
		pst.setString(9,bstat);
		pst.setString(10,bpft);
		pst.setString(11,bpaid);
		t=pst.executeUpdate();
		if(t>0)
		{
			pst=con.prepareStatement("select max(bid) from biller.biller_bill");
			rs=pst.executeQuery();
			if(rs.next())
			t=rs.getInt(1);
		}
		this.updateTotalAmtDue();
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return t;
}
public ResultSet getBill()
{
	connect c=new connect();
	Connection con=c.getConnection();
	ResultSet rs=null;
	try
	{
		PreparedStatement pst=con.prepareStatement("select * from biller.biller_bill where bid=?");
		pst.setInt(1,bid);
		rs=pst.executeQuery();
		if(rs.next())
		{
			this.cid=rs.getInt(2);
			this.bdate=rs.getString(3);
			this.btot=rs.getString(4);
			this.brtot=rs.getString(5);
			this.bdis=rs.getString(6);
			this.bgtot=rs.getString(7);
			this.bpaid=rs.getString(8);
			this.bdue=rs.getString(9);
			this.bstat=rs.getString(10);
			this.bpft=rs.getString(11);
			this.binitpay=rs.getString(12);
			pst=con.prepareStatement("select * from biller.biller_billitem where bid=? order by bsl");
			pst.setInt(1,bid);
			rs=pst.executeQuery();			
		}
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return rs;
}
public int creditPay()
{
	connect c=new connect();
	Connection con=c.getConnection();
	int t=0;
	try
	{
		PreparedStatement pst=con.prepareStatement("insert into biller.biller_creditbills(bid,bdate,bpaid)values(?,?,?)");
		pst.setInt(1,bid);
		pst.setString(2,bdate);
		pst.setString(3,bpaid);
		t=pst.executeUpdate();
		this.bpcreditset();
		this.updateTotalAmtDue();
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return t;
}
public void bpcreditset()
{
	connect c=new connect();
	Connection con=c.getConnection();
	ResultSet rs=null;
	double totpaid=0,totdue=0;String st="";
	try
	{
		PreparedStatement pst=con.prepareStatement("select bpaid,bgtot from biller.biller_bill where bid=?");
		pst.setInt(1,bid);
		rs=pst.executeQuery();
		if(rs.next())
		{
			totpaid=Double.parseDouble(rs.getString(1))+Double.parseDouble(bpaid);
			totdue=Double.parseDouble(rs.getString(2))-totpaid;
			if(totdue<=0)
			st="Full Paid";
			else
			st="Due Bill";
			pst=con.prepareStatement("update biller.biller_bill set bpaid=?,bdue=?,bstat=? where bid=?");
			pst.setString(1,String.valueOf(totpaid));
			pst.setString(2,String.valueOf(totdue));
			pst.setString(3,st);
			pst.setInt(4,bid);
			pst.executeUpdate();
		}
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
}
public void updateTotalAmtDue()
{
	connect c=new connect();
	Connection con=c.getConnection();
	ResultSet rs=null;
	double totdue=0;
	try
	{
		PreparedStatement pst=con.prepareStatement("select bdue from biller.biller_bill where cid=?");
		pst.setInt(1,cid);
		rs=pst.executeQuery();
		while(rs.next())
		{
			totdue=Double.parseDouble(rs.getString(1))+totdue;
		}
		pst=con.prepareStatement("update biller.biller_customer set camtdue=? where cid=?");
		pst.setString(1,String.valueOf(totdue));
		pst.setInt(2,cid);
		pst.executeUpdate();
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
}
public ResultSet getCreditPay()
{
	connect c=new connect();
	Connection con=c.getConnection();
	ResultSet rs=null;
	try
	{
		PreparedStatement pst=con.prepareStatement("select * from biller.biller_creditbills where bid=? order by bdate");
		pst.setInt(1,bid);
		rs=pst.executeQuery();
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return rs;
}
public int deleteBill()
{
	connect co=new connect();
	Connection con=co.getConnection();
	int t=0;
	try
	{
		PreparedStatement pst=con.prepareStatement("delete from biller.biller_creditbills where bid=?");
		pst.setInt(1,bid);
		t=pst.executeUpdate();
		pst=con.prepareStatement("delete from biller.biller_billitem where bid=?");
		pst.setInt(1,bid);
		t=pst.executeUpdate();
		pst=con.prepareStatement("delete from biller.biller_bill where bid=?");
		pst.setInt(1,bid);
		t=pst.executeUpdate();
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return t;
}
public ResultSet getBillListByCid(int cusid)
{
	connect c=new connect();
	Connection con=c.getConnection();
	ResultSet rs=null;
	try
	{
		PreparedStatement pst=con.prepareStatement("select * from biller.biller_bill where cid=?");
		pst.setInt(1,cusid);
		rs=pst.executeQuery();
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return rs;
}
public ResultSet getBillList(String sortval,String d)
{
	connect c=new connect();
	Connection con=c.getConnection();
	ResultSet rs=null;
	try
	{
		PreparedStatement pst=con.prepareStatement("select * from biller.biller_bill order by "+sortval+" "+d);
		rs=pst.executeQuery();
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return rs;
}
public void getShopDetail()
{
	connect c=new connect();
	Connection con=c.getConnection();
	ResultSet rs=null;
	try
	{
		PreparedStatement pst=con.prepareStatement("select * from biller.biller_company");
		rs=pst.executeQuery();
		if(rs.next())
		{
			this.shpname=rs.getString(1);
			this.shpgst=rs.getString(2);
			this.shpphn=rs.getString(3);
			this.shpadr=rs.getString(4);	
		}
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
}
}