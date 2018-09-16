<head>
<link rel="stylesheet" type="text/css" href="css/updateproduct_style.css" />
</head>
<%@include file="menu.jsp"%>
<jsp:useBean id="item" class="biller.Product" scope="page"/>
<jsp:setProperty name="item" property="*"/>
<%
int k=item.deleteProduct();
int t=item.insertProductToDb();
if(k>0)
{
%>
<div id="success">Item updated Successfully</div>
<%
}
else
{
%>
<div id="fail">Unable to Update Item</div><font color=red>
<%
}
if(!item.excep.equals(""))
out.println("An Exception Occured:-"+item.excep);
%></font>
<a id="gotophome" href=producthome.jsp?search=&field=pname>Goto Product Home</a>