<%@include file="menu.jsp"%>
<%@ page import = "java.util.*,java.text.*"%>
<html>
<head>
<script src="javascript/dynaform.js" type="text/javascript"></script>
<link href="css/home_style.css" rel="stylesheet" type="text/css">
</head>
<%!String cd="";%>
<%
Date d=new Date();
SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd");
cd=ft.format(d).toString();%>
<body onload="document.mainform.cid.focus()" ondblclick="scnr()">
<form action="billview.jsp" id="mainform" method="post" name="mainform" onsubmit="return setfields()">
<input type=text name=upcscan id="err" onchange="getProduct()" onblur="scnb()" onfocus="scnr()">
<div id="cusid"><h4>Customer ID:<input type=text id="cid" name=cid oninput="setcustname()"></h4><div id="ciderr"></div></div><div id="cusnamlabel"><h4>Customer Name:</h4></div><div id="cname"></div><div id="msg">Double click anywhere to scan items</div>
<div id="bdate"><h4>Date:<input type=date name=bdate value="<%=cd%>"></h4></div>
<table id="bill">
<tr>
<th id=res>Sl.No.</th>
<th id=res>Name</th>
<th id=res>MRP</th>
<th id=res>Cost Price</th>
<th id=res>Sale Price</th>
<th id=res>QTY</th>
<th id=res>Gross Total</th>
</tr>
<tr id="gt"><td></td><td></td><td></td><td>Total:</td><td align=right><input type=text class="psell" id="total" name=btot value=0 disabled></td><td>Rounded Off Total:</td><td align=right><input type=text class="psell" id="rtotal" name=brtot value=0 disabled></td></tr>
<tr><td></td><td></td><td></td><td></td><td></td><td>Additional Discount:</td><td align=right><input type=text class="psell" id="addis" name=bdis value=0 onchange="setgrandtotal()"></td></tr>
<tr><td></td><td></td><td></td><td></td><td></td><td>Grand Total:</td><td align=right><input type=text class="psell" id="grandtotal" name=bgtot value=0 disabled><div id="gterr"></div></td></tr>
<tr><td>Profit:</td><td align=right><input type=text class="psell" id="pft" name=bpft value=0 disabled></td><td></td><td>Amount Paid:</td><td align=right><input type=text class="psell" id="amtpaid" name=bpaid value=0 onchange="setgrandtotal()"></td><td>Amount Due:</td><td align=right><input type=text class="psell" id="amtdue" name=bdue value=0 disabled></td></tr>
<tr><td><input type=reset value=reset></td><td></td><td></td><td></td><td></td><td></td><td><input type="submit" value="create bill"></td></tr>
</table>
<input type=hidden id="bsln" name=bsln value=0>
</form>
<p id="diag"></p>
</body>
</html>