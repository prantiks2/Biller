<head>
<link rel="stylesheet" type="text/css" href="css/updatecustomer_style.css" />
</head>
<%@include file="menu.jsp"%>
<jsp:useBean id="upcu" class="biller.Customer" scope="page"/>
<jsp:setProperty name="upcu" property="*"/>
<%
int t=upcu.updateCustomer();
if(t>0)
{
%>
<div id="success">Customer information updated Successfully</div>
<%
}
else
{
%>
<div id="fail">Unable to Update Customer Information!</div><font color=red>
<%
}
if(!upcu.excep.equals(""))
out.println("An Exception Occured:-"+upcu.excep);
%></font>
<a id="gotochome" href=customerhome.jsp?search=>Goto Customer Menu</a>