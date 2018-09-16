<head>
<link rel="stylesheet" type="text/css" href="css/insertvbillpay_style.css" />
</head>
<%@include file="menu.jsp"%>
<jsp:useBean id="pay" class="biller.Vbill" scope="page"/>
<jsp:setProperty name="pay" property="*"/>
<%
int t=pay.Vbillpay();
if(t>0)
{
response.sendRedirect("viewvbill.jsp?vbid="+request.getParameter("vbid")+"&vid="+request.getParameter("vid"));
}
else
{
%>
<div id="fail">Unable to make payment!</div><font color=red>
<%
}
if(!pay.excep.equals(""))
out.println("An Exception Occured:-"+pay.excep);
%></font>
<a id="gotochome" href=# onclick="window.history.back()">Go back</a>