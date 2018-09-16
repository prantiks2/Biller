<html>
<head>
<link rel="stylesheet" type="text/css" href="css/logincheck_style.css" />
</head>
<jsp:useBean id="ob" class="biller.checkuser" scope="page"/>
<jsp:setProperty name="ob" property="*"/>
<%
if(ob.check())
{
session.setAttribute("user",ob.name);
response.sendRedirect("home.jsp");
}
else
{
%>
<div id=error_warn>Invalid User ID or Password, try again!</div>
<%
}
%>
<%@include file="index.html"%><font color=red>
<%
if(!ob.excep.equals(""))
out.println("Exception occured:-"+ob.excep);%>
</font></html>