<%@page import="java.sql.*"%>
<%@include file="menu.jsp"%>
<head>
<link rel="stylesheet" type="text/css" href="css/customerhome_style.css" />
</head>
<jsp:useBean id="cuhm" class="biller.Customer" scope="page"/>
<a id="addcustlink" href=insertcustomer.jsp>Add new Customer</a>
<div id="searchbox">
<form action=customerhome.jsp>
<input type=text name=search value=""><input type=submit value=search>
</form>
</div>
<table id="result">
<tr><th id=res>Customer id</th><th id=res>Name</th><th id=res>GSTIN</th><th id=res>Mobile</th><th id=res>Amount due</th><th id=res>Delete Customer</th></tr>
<%
try
{
ResultSet rs=cuhm.getCustomerList(request.getParameter("search"));
while(rs.next())
{
%>
<tr id=resrow>
<td id=res><a id=itemlink href=viewcustomer.jsp?cid=<%=rs.getInt(1)%>><%=rs.getInt(1)%></a></td>
<td id=res><%=rs.getString(2)%></td>
<td id=res><%=rs.getString(4)%></td>
<td id=res><%=rs.getString(5)%></td>
<td id=res><%=rs.getString(7)%></td>
<td id=res><a id=itemlink href=deletecustomer.jsp?cid=<%=rs.getInt(1)%> onclick="return confirm('Are you sure you want to delete <%=rs.getString(2)%> from customers?')">delete</a></td>
</tr>
<%
}
%></table>
<font color=red>
<%
}
catch(Exception e){out.println(e);}
if(!cuhm.excep.equals(""))
out.println("An Exception Occured:-"+cuhm.excep);
%></font>