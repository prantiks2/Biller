<%@include file="menu.jsp"%>
<%@ page import = "java.util.*,java.text.*"%>
<%@ page import ="java.sql.*"%>
<jsp:useBean id="b" class="biller.Bill" scope="page"/>
<jsp:useBean id="c" class="biller.Customer" scope="page"/>
<head>
<link href="css/updatebill_style.css" rel="stylesheet" type="text/css">
<script language="javascript">
function verifyform()
{
var bpaid=document.getElementById("bpaid").value;
if((bpaid=="")||(isNaN(bpaid)))
{
document.getElementById("bpaidalert").innerHTML="<font color=red>Enter a valid amount!</font>";
return false;
}
else
{
document.getElementById("bpaidalert").innerHTML="";
}
}
</script>
</head>
<%!String cd="";int bid=0;%>
<%
java.util.Date d=new java.util.Date();
SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd");
cd=ft.format(d).toString();
try
{
bid=Integer.parseInt(request.getParameter("bid"));
b.setBid(bid);
ResultSet rs=b.getBill();
c.setCid(b.getCid());
c.getCustomer();
String cname=c.getCname();
%>
<form action=addpayment.jsp method=post onsubmit="return verifyform()">
<div id="pay"><h4>Date:<input type=date name=bdate value="<%=cd%>">Amount:<input type=text id="bpaid" name=bpaid></h4><input type=hidden name=bid value="<%=bid%>"><input type=hidden name=cid value="<%=b.getCid()%>"><input type=submit value="Make Payment"></div>
</form>
<table id="billdetails">
<tr>
<td>Customer ID:<%=b.getCid()%></td><td>Customer Name:<%=cname%></td><td>Bill Date:</td><td><%=b.getBdate()%></td><td><%=b.getBstat()%></td><td>Bill-Id:<%=bid%></td>
</tr>
<tr>
<td>Serial No.</td><td>Item Name</td><td>MRP</td><td>Sale Price</td><td>Quantity</td><td>Gross Total</td>
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
<td></td><td></td><td>Total:</td><td><%=b.getBtot()%></td><td>Rounded Off Total</td><td><%=b.getBrtot()%></td>
</tr>
<tr>
<td></td><td></td><td></td><td></td><td>Additional Discount:</td><td><%=b.getBdis()%></td>
</tr>
<tr>
<td>Profit:</td><td><%=b.getBpft()%></td><td></td><td></td><td>Grand Total:</td><td><%=b.getBgtot()%></td>
</tr>
<tr>
<td>Initial Payment:</td><td><%=b.getBinitpay()%></td><td>Amount Paid:</td><td><%=b.getBpaid()%></td><td>Amount Due:</td><td><%=b.getBdue()%></td>
</tr>
<tr>
<td>-:Payments Made:-</td><td></td><td></td><td></td><td></td><td><a href="printbill.jsp?bid=<%=bid%>&pg=bill">Print Bill</a></td>
</tr>
<tr>
<td>Date</td><td>Amount</td>
</tr>
<%
rs=b.getCreditPay();
while(rs.next())
{
%>
<tr>
<td><%=rs.getString(2)%></td><td><%=rs.getString(3)%></td>
</tr>
<%
}
}
catch(Exception e){out.print(e);}
%>
</table><font color=red>
<%
if(!b.excep.equals(""))
out.println("An Exception Occured:-"+b.excep);
if(!c.excep.equals(""))
out.println("An Exception Occured:-"+c.excep);
%></font>
