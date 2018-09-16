package biller;
import java.sql.*;
public class Product
{
public String excep="";
String upc,pname,pcomp,pdesc="",pcat,pty;
int punt;
double pcgst,psgst,pmrp,pcp,psp;
public void setUpc(String upc){this.upc=upc;}
public void setPname(String pname){this.pname=pname;}
public void setPcomp(String pcomp){this.pcomp=pcomp;}
public void setPdesc(String pdesc){this.pdesc=pdesc;}
public void setPcat(String pcat){this.pcat=pcat;}
public void setPty(String pty){this.pty=pty;}
public void setPunt(int punt){this.punt=punt;}
public void setPcgst(double pcgst){this.pcgst=pcgst;}
public void setPsgst(double psgst){this.psgst=psgst;}
public void setPmrp(double pmrp){this.pmrp=pmrp;}
public void setPcp(double pcp){this.pcp=pcp;}
public void setPsp(double psp){this.psp=psp;}

public String getUpc(){return upc;}
public String getPname(){return pname;}
public String getPcomp(){return pcomp;}
public String getPdesc(){return pdesc;}
public String getPcat(){return pcat;}
public String getPty(){return pty;}
public double getPcgst(){return pcgst;}
public double getPsgst(){return psgst;}
public double getPmrp(){return pmrp;}
public double getPcp(){return pcp;}
public double getPsp(){return psp;}
public int getPunt(){return punt;}

public int insertProductToDb()
{
	connect c=new connect();
	Connection con=c.getConnection();
	int t=0;
	try
	{
		PreparedStatement pst=con.prepareStatement("insert into biller.biller_product(upc,pname,pcomp,pdesc,pcgst,psgst,pcat,pty,punt)values(?,?,?,?,?,?,?,?,0)");
		pst.setString(1,upc);
		pst.setString(2,pname);
		pst.setString(3,pcomp);
		pst.setString(4,pdesc);
		pst.setString(5,String.valueOf(pcgst));
		pst.setString(6,String.valueOf(psgst));
		pst.setString(7,pcat);
		pst.setString(8,pty);
		int prod=pst.executeUpdate();
		pst=con.prepareStatement("insert into biller.biller_cost(upc,pmrp,pcp,psp)values(?,?,?,?)");
		pst.setString(1,upc);
		pst.setString(2,String.valueOf(pmrp));
		pst.setString(3,String.valueOf(pcp));
		pst.setString(4,String.valueOf(psp));
		int cost=pst.executeUpdate();
		if(prod>0&&cost>0)
		{
			t=1;
		}
		else if(prod>0)
		{
			pst=con.prepareStatement("delete from biller.biller_product where upc=?");
			pst.setString(1,upc);
			pst.executeUpdate();
		}
		else if(cost>0)
		{
			pst=con.prepareStatement("delete from biller.biller_cost where upc=?");
			pst.setString(1,upc);
			pst.executeUpdate();
		}
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return t;
}

public int getProduct()
{
	connect co=new connect();
	Connection con=co.getConnection();
	int t=0,p=0,c=0;
	ResultSet rs=null;
	try
	{
		PreparedStatement pst=con.prepareStatement("select * from biller.biller_product where upc=?");
		pst.setString(1,upc);
		rs=pst.executeQuery();
		if(rs.next())
		{
			this.pname=rs.getString(2);
			this.pcomp=rs.getString(3);
			this.pdesc=rs.getString(4);
			this.pcgst=Double.parseDouble(rs.getString(5));
			this.psgst=Double.parseDouble(rs.getString(6));
			this.pcat=rs.getString(7);
			this.pty=rs.getString(8);
			this.punt=Integer.parseInt(rs.getString(9));
			p=1;			
		}
		pst=con.prepareStatement("select * from biller.biller_cost where upc=?");
		pst.setString(1,upc);
		rs=pst.executeQuery();
		if(rs.next())
		{
			this.pmrp=Double.parseDouble(rs.getString(2));
			this.pcp=Double.parseDouble(rs.getString(3));
			this.psp=Double.parseDouble(rs.getString(4));
			c=1;			
		}
	if(c>0&&p>0)
		t=1;
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return t;
}

public int deleteProduct()
{
	connect co=new connect();
	Connection con=co.getConnection();
	int t=0,p=0,c=0;
	try
	{
		PreparedStatement pst=con.prepareStatement("delete from biller.biller_product where upc=?");
		pst.setString(1,upc);
		p=pst.executeUpdate();
		pst=con.prepareStatement("delete from biller.biller_cost where upc=?");
		pst.setString(1,upc);
		c=pst.executeUpdate();
		if(c>0&&p>0)
			t=1;
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return t;
}
public ResultSet getProductList(String search,String field)
{
	connect c=new connect();
	Connection con=c.getConnection();
	ResultSet rs=null;
	try
	{
		PreparedStatement pst=con.prepareStatement("select * from biller.biller_product where "+field+" like '"+search+"%'");
		rs=pst.executeQuery();
	}
	catch(Exception e)
	{
		this.excep=(String)e.getMessage();
	}
	return rs;
}
}