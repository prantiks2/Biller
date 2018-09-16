<head>
<link rel="stylesheet" type="text/css" href="css/insert_product_to_db_style.css" />
</head>
<%@include file="menu.jsp"%>
<jsp:useBean id="item" class="biller.Product" scope="page"/>
<jsp:setProperty name="item" property="*"/>
<%
int t=item.insertProductToDb();
if(t>0)
{
%>
<div id="success">Item inserted Successfully</div>
<%
}
else
{
%>
<div id="fail">Item insertion Unsuccessfull</div><font color=red>
<%
}
if(!item.excep.equals(""))
out.println("An Exception Occured:-"+item.excep);
%></font>
<a id="addanother" href=insertproduct.jsp>Add Another Product</a>
<a id="gotophome" href=producthome.jsp?search=&field=pname>Goto Product Home</a>