<%@page import="java.sql.*"%>
<%@include file="menu.jsp"%>
<head>
<link rel="stylesheet" type="text/css" href="css/producthome_style.css" />
</head>
<jsp:useBean id="gl" class="biller.Product" scope="page"/>
<a id="addproductlink" href=insertproduct.jsp>Add new Product</a>
<div id="searchbox">
<form action=producthome.jsp>
<input type=text name=search value=""><input type=radio name=field value=pname checked>name<input type=radio name=field value=pcomp>Company
<input type=radio name=field value=pcat>Category<input type=radio name=field value=pty>Type<input type=submit value=search>
</form>
</div>
<table id="result">
<tr><th id=res>Name/HSN</th><th id=res>Company Name</th><th id=res>Category</th><th id=res>Type</th><th id=res>Units Sold</th><th id=res>Delete Item</th></tr>
<%
try
{
ResultSet rs=gl.getProductList(request.getParameter("search"),request.getParameter("field"));
while(rs.next())
{
%>
<tr id=resrow>
<td id=res><a id=itemlink href=viewproduct.jsp?upc=<%=rs.getString(1)%>><%=rs.getString(2)%></a></td>
<td id=res><%=rs.getString(3)%></td>
<td id=res><%=rs.getString(7)%></td>
<td id=res><%=rs.getString(8)%></td>
<td id=res><%=rs.getString(9)%></td>
<td id=res><a id=itemlink href=deleteproduct.jsp?upc=<%=rs.getString(1)%> onclick="return confirm('Are you sure you want to delete <%=rs.getString(2)%>?')">delete</a></td>
</tr>
<%
}
%></table>
<font color=red>
<%
}
catch(Exception e){out.println(e);}
if(!gl.excep.equals(""))
out.println("An Exception Occured:-"+gl.excep);
%></font>