<head>
<link rel="stylesheet" type="text/css" href="css/billview_style.css" />
</head>
<%@page import="java.sql.*"%>
<%@include file="menu.jsp"%>
<jsp:useBean id="bl" class="biller.Bill" scope="page"/>
<jsp:useBean id="cus" class="biller.Customer" scope="page"/>
<jsp:useBean id="c" class="biller.connect" scope="page"/>
<jsp:setProperty name="bl" property="*"/>
<%
int t=bl.insertBillToDb();
try
{
Connection con=c.getConnection();
PreparedStatement pst=null;
int bsln=Integer.parseInt(request.getParameter("bsln"));
if(t>0)
{
for(int i=1;i<=bsln;i++)
		{
			int bsl=i;
			String bname=request.getParameter("proname"+i);
			String bmrp=request.getParameter("promrp"+i);
			String bsp=request.getParameter("prosp"+i);
			String bqty=request.getParameter("proqty"+i);
			String bgt=request.getParameter("progtot"+i);
			pst=con.prepareStatement("insert into biller.biller_billitem(bid,bsl,bname,bmrp,bsp,bqty,bgt)values(?,?,?,?,?,?,?)");
			pst.setInt(1,t);
			pst.setInt(2,bsl);
			pst.setString(3,bname);
			pst.setString(4,bmrp);
			pst.setString(5,bsp);
			pst.setString(6,bqty);
			pst.setString(7,bgt);
			pst.executeUpdate();
			pst=con.prepareStatement("select punt from biller.biller_product where upc=?");
			pst.setString(1,request.getParameter("UPC"+i));
			ResultSet rs=pst.executeQuery();
			if(rs.next())
			{
				int qntyty=Integer.parseInt(rs.getString(1))+Integer.parseInt(bqty);
				pst=con.prepareStatement("update biller.biller_product set punt=? where upc=?");
				pst.setString(1,String.valueOf(qntyty));
				pst.setString(2,request.getParameter("UPC"+i));
				pst.executeUpdate();
			}
		}
out.print("");
}
else
out.print("");
cus.setCid(Integer.parseInt(request.getParameter("cid")));
cus.getCustomer();
bl.setBid(t);
ResultSet rs=bl.getBill();
bl.getShopDetail();
%>
<div id="shopinfo">
<%=bl.getShopName()%></br>
GSTIN:<%=bl.getShopGst()%></br>
Phone:<%=bl.getShopPhn()%></br>
Address:<%=bl.getShopAddr()%>
</div>
<div id="cusinfo">
Date:<%=bl.getBdate()%></br>
Bill ID:<%=bl.getBid()%></br>
Customer Id:<%=cus.getCid()%></br>
Customer Name:<%=cus.getCname()%>
</div>
<table id="fnbill">
<tr>
<th>Serial no.</th><th>Item Name</th><th>MRP</th><th>Sale Price</th><th>Quantity</th><th>Gross Total</th>
</tr>
<%
while(rs.next())
{
%>
<tr>
<td><%=rs.getInt(2)%></td><td><%=rs.getString(3)%></td><td><%=rs.getString(4)%></td><td><%=rs.getString(5)%></td><td><%=rs.getString(6)%></td><td><%=rs.getString(7)%></td>
</tr>
<%
}
%>
<tr>
<td></td><td></td><td>Total:</td><td><%=bl.getBtot()%></td><td>Rounded Off Total</td><td><%=bl.getBrtot()%></td>
</tr>
<tr>
<td></td><td></td><td></td><td></td><td>Additional Discount:</td><td><%=bl.getBdis()%></td>
</tr>
<tr>
<td></td><td></td><td></td><td></td><td>Grand Total:</td><td><%=bl.getBgtot()%></td>
</tr>
<tr>
<td></td><td><a href=home.jsp>go to home</a></td><td></td><td></td><td></td><td><a href=printbill.jsp?bid=<%=t%>&pg=home>Print</a></td>
</tr>
</table><font color=red>
<%
}catch(Exception e){out.print(e);}
if(!bl.excep.equals(""))
out.println("An Exception Occured:-"+bl.excep);
if(!cus.excep.equals(""))
out.println("An Exception Occured:-"+cus.excep);
%></font>
