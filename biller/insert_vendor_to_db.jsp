<head>
<link rel="stylesheet" type="text/css" href="css/insert_vendor_to_db_style.css" />
</head>
<%@include file="menu.jsp"%>
<jsp:useBean id="inv" class="biller.Vendor" scope="page"/>
<jsp:setProperty name="inv" property="*"/>
<%
int t=inv.addVendorToDb();
if(t>0)
{
%>
<div id="success">Vendor added successfully,Vendor Id:<%=t%></div>
<%
}
else
{
%>
<div id="fail">Unable to add Vendor!</div><font color=red>
<%
}
if(!inv.excep.equals(""))
out.println("An Exception Occured:-"+inv.excep);
%></font>
<a id="addanother" href=insertvendor.jsp>Add Another Vendor</a>
<a id="gotochome" href=vendorhome.jsp?search=>Goto Vendor Menu</a>