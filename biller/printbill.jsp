<head>
<link rel="stylesheet" type="text/css" href="css/printbill_style.css" />
<script language="javascript">
<%
String pg=request.getParameter("pg");
String bll=request.getParameter("bid");
%>
function goback()
{
var p='<%=pg%>';
if(p==="home")
window.location.replace("home.jsp");
else
window.location.replace("updatebill.jsp?bid=<%=bll%>");
}
</script>
</head>
<body onload="javascript:window.print();" onclick="goback()">
<%@page import="java.sql.*"%>
<jsp:useBean id="bl" class="biller.Bill" scope="page"/>
<jsp:useBean id="cus" class="biller.Customer" scope="page"/>
<%
try
{
bl.setBid(Integer.parseInt(request.getParameter("bid")));
ResultSet rs=bl.getBill();
cus.setCid(bl.getCid());
cus.getCustomer();
bl.getShopDetail();
%>
<div id="shopinfo">
<%=bl.getShopName()%></br>
GSTIN:<%=bl.getShopGst()%></br>
Phone:<%=bl.getShopPhn()%></br>
Address:<%=bl.getShopAddr()%>
</div>
<div id="cusinfo">
Customer Id:<%=cus.getCid()%></br>
Customer Name:<%=cus.getCname()%></br>
Customer GSTIN:<%=cus.getCgstin()%></br>
Customer Address:<%=cus.getCaddr()%>
</div>
<div id="billinfo">
<center>Bill Of Supply</br>Composition taxable person</br>
Date:<%=bl.getBdate()%></br>
Bill ID:<%=bl.getBid()%>-17/18</center>
</div>
<table id="fnbill">
<tr>
<th>Serial no.</th><th>Item Name/HSN No.</th><th>MRP</th><th>Sale Price</th><th>Quantity</th><th>Gross Total</th>
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
</table><font color=red>
<%
}catch(Exception e){out.print(e);}
if(!bl.excep.equals(""))
out.println("An Exception Occured:-"+bl.excep);
if(!cus.excep.equals(""))
out.println("An Exception Occured:-"+cus.excep);
%></font>
</body>
