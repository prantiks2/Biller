<jsp:useBean id="bil" class="biller.Bill" scope="page"/>
<jsp:setProperty name="bil" property="*"/>
<%@include file="menu.jsp"%>
<head>
<link rel="stylesheet" type="text/css" href="css/addpayment_style.css" />
</head>
<%
String b=request.getParameter("bid");
int t=bil.creditPay();
if(t>0)
{
response.sendRedirect("updatebill.jsp?bid="+b);
}
else
{
%>
<div id=delfail>Unable to update payment information!</div><font color=red>
<%
}
if(!bil.excep.equals(""))
out.println("An Exception Occured:-"+bil.excep);
%></font>