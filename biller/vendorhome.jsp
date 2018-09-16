<%@page import="java.sql.*"%>
<%@include file="menu.jsp"%>
<head>
<link rel="stylesheet" type="text/css" href="css/vendorhome_style.css" />
</head>
<jsp:useBean id="vhm" class="biller.Vendor" scope="page"/>
<a id="addvendlink" href=insertvendor.jsp>Add new Vendor</a>
<div id="searchbox">
<form action=vendorhome.jsp>
<input type=text name=search value=""><input type=submit value=search>
</form>
</div>
<table id="result">
<tr><th id=res>Vendor id</th><th id=res>Name</th><th id=res>GSTIN</th><th id=res>Salesman No.</th><th id=res>Amount due</th><th id=res>Delete Vendor</th></tr>
<%
try
{
ResultSet rs=vhm.getVendorList(request.getParameter("search"));
while(rs.next())
{
%>
<tr id=resrow>
<td id=res><a id=itemlink href=viewvendor.jsp?vid=<%=rs.getInt(1)%>><%=rs.getInt(1)%></a></td>
<td id=res><%=rs.getString(2)%></td>
<td id=res><%=rs.getString(12)%></td>
<td id=res><%=rs.getString(7)%></td>
<td id=res><%=rs.getString(11)%></td>
<td id=res><a id=itemlink href=deletevendor.jsp?vid=<%=rs.getInt(1)%> onclick="return confirm('Are you sure you want to delete <%=rs.getString(2)%> from vendors?')">delete</a></td>
</tr>
<%
}
%></table>
<font color=red>
<%
}
catch(Exception e){out.println("Exception at vendorhome.jsp:"+e);}
if(!vhm.excep.equals(""))
out.println("An Exception Occured:-"+vhm.excep);
%></font>