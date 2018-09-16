<%@page import="java.sql.*"%>
<%@include file="menu.jsp"%>
<head>
<link rel="stylesheet" type="text/css" href="css/invoicehome_style.css" />
</head>
<jsp:useBean id="bllst" class="biller.Bill" scope="page"/>
<jsp:useBean id="cn" class="biller.Customer" scope="page"/>
<form action=invoicehome.jsp>
<table id="sort">
<tr>
<td>Sort By:</td>
<td>
<select name=srtval>
<option value=bid>Bill-id</option>
<option value=bdate>Bill-Date</option>
<option value=cid>Customer-Id</option>
<option value=bstat>Bill-Status</option>
</select>
</td>
<td>Order:</td>
<td>
<select name=d>
<option value="">Ascending</option>
<option value=desc>Descending</option>
</select>
</td><td><input type=submit value=sort></td>
</tr>
</table>
</form>
<table id="result">
<tr><th id=res>Bill Id</th><th id=res>Customer ID</th><th id=res>Customer Name</th><th id=res>Bill Date</th><th id=res>Bill Amount</th><th id=res>Amount Paid</th><th id=res>Amount Due</th><th id=res>Delete Bill</th></tr>
<%
try
{
String d=request.getParameter("d");
if(d==null)
d="";
String sr=request.getParameter("srtval");
ResultSet rs=bllst.getBillList(sr,d);
while(rs.next())
{
cn.setCid(rs.getInt(2));
cn.getCustomer();
%>
<tr id=resrow>
<td id=res><a id=itemlink href=updatebill.jsp?bid=<%=rs.getInt(1)%>><%=rs.getInt(1)%></a></td>
<td id=res><%=rs.getInt(2)%></td>
<td id=res><%=cn.getCname()%></td>
<td id=res><%=rs.getString(3)%></td>
<td id=res><%=rs.getString(7)%></td>
<td id=res><%=rs.getString(8)%></td>
<td id=res><%=rs.getString(9)%></td>
<td id=res><a id=itemlink href=deletebill.jsp?bid=<%=rs.getInt(1)%>&cid= onclick="return confirm('Are you sure you want to delete bill with bill id:<%=rs.getInt(1)%>?')">delete</a></td>
</tr>
<%
}
%>
</table><font color=red>
<%
}
catch(Exception e){out.println(e);}
if(!bllst.excep.equals(""))
out.println("An Exception Occured:-"+bllst.excep);
if(!cn.excep.equals(""))
out.println("An Exception Occured:-"+cn.excep);
%></font>