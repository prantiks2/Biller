<head>
<link rel="stylesheet" type="text/css" href="css/insert_customer_to_db_style.css" />
</head>
<%@include file="menu.jsp"%>
<jsp:useBean id="incu" class="biller.Customer" scope="page"/>
<jsp:setProperty name="incu" property="*"/>
<%
int t=incu.insertCustomerToDb();
if(t>0)
{
%>
<div id="success">Customer added successfully,Customer Id:<%=t%></div>
<%
}
else
{
%>
<div id="fail">Unable to add customer!</div><font color=red>
<%
}
if(!incu.excep.equals(""))
out.println("An Exception Occured:-"+incu.excep);
%></font>
<a id="addanother" href=insertcustomer.jsp>Add Another Customer</a>
<a id="gotochome" href=customerhome.jsp?search=>Goto Customer Menu</a>