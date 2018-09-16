<html>
<head>
<link rel="stylesheet" type="text/css" href="css/menu_style.css" />
</head>
<div id=usrnm>
<%
String name=(String)session.getAttribute("user");
out.println("Hello "+name);
%>
</div>
<div align=right><a href=home.jsp>Home</a>|<a href=logout.jsp>Logout</a></div>
<table id=menubar>
<col width=100>
<col width=100>
<col width=100>
<col width=100>
<tr>
<th class="menu"><a class="menu" href=vendorhome.jsp?search=>Vendors</a></th>
<th class="menu"><a class="menu" href=producthome.jsp?search=&field=pname>Products</a></th>
<th class="menu"><a class="menu" href=invoicehome.jsp?sortval=bid&d=>Invoices</a></th>
<th class="menu"><a class="menu" href=customerhome.jsp?search=>Customers</a></th>
</tr>
</table>
</html>

	     
