<%@include file="menu.jsp"%>
<%@ page import = "java.util.*,java.text.*,java.sql.*"%>
<%!String cd="";%>
<%
java.util.Date d=new java.util.Date();
SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd");
cd=ft.format(d).toString();
%>
<head>
<link rel="stylesheet" type="text/css" href="css/viewvbill_style.css" />
<script language="javascript">
function verify()
{
var vbpdate=document.getElementById("vbpdate").value;
var vbpamt=document.getElementById("vbpamt").value;
var vbpmode=document.getElementById("vbpmode").value;
var f=0;
if(vbpdate=="")
{
document.getElementById("vbpdatealert").innerHTML="<font color=red>Enter payment date!</font>";
f=1;
}
else
{
document.getElementById("vbpdatealert").innerHTML="";
}
if(vbpamt==""||isNaN(vbpamt))
{
document.getElementById("vbpamtalert").innerHTML="<font color=red>Enter a valid payment amount!</font>";
f=1;
}
else
{
document.getElementById("vbpamtalert").innerHTML="";
}
if(vbpmode=="")
{
document.getElementById("vbpmodealert").innerHTML="<font color=red>Enter payment mode!</font>";
f=1;
}
else
{
document.getElementById("vbpmodealert").innerHTML="";
}
if(f==1)
{
return false;
}
}
</script>
</head>
<jsp:useBean id="vbp" class="biller.Vbill" scope="page"/>
<jsp:setProperty name="vbp" property="*"/>
<%
vbp.getVbill();
%>
<table id="vbill">
<tr>
<th>Bill Date</th>
<th>Bill Amount</th>
<th>Total Amount Paid</th>
<th>Total Amount Due</th>
</tr>
<tr>
<td id="cen"><%=vbp.getVbdate()%></td>
<td id="cen"><%=vbp.getVbamt()%></td>
<td id="cen"><%=vbp.getVbamtpaid()%></td>
<td id="cen"><%=vbp.getVboutamt()%></td>
</tr>
</table>
<form action=insertvbillpay.jsp method=post onsubmit="return verify()">
<table id="vbillpayentry">
<caption>Make new bill payment</caption>
<tr>
<th>Date</th>
<th>Amount</th>
<th>Payment Mode</th>
</tr>
<tr>
<td><input type=date name=vbpdate id=vbpdate value="<%=cd%>"><div id=vbpdatealert></div></td>
<td><input type=text name=vbpamt id=vbpamt><div id=vbpamtalert></div></td>
<td><input type=text name=vbpmode id=vbpmode><div id=vbpmodealert></div></td>
</tr>
<tr><td><input type=reset  value=reset></td><td></td><td align=right><input type=submit value="Make Payment"></td></tr>
<input type=hidden name=vid  value=<%=request.getParameter("vid")%>>
<input type=hidden name=vbid  value=<%=request.getParameter("vbid")%>>
</table>
</form>
<table id="payhist">
<caption>Payment History</caption>
<tr><th id=res>Date</th><th id=res>Amount</th><th id=res>Payment Mode</th><th id=res>Date/time</th></tr>
<%
try
{
ResultSet rs=vbp.getVbillPayList();
while(rs.next())
{
%>
<tr id=resrow>
<td id=res><%=rs.getString(3)%></td>
<td id=res><%=rs.getString(4)%></td>
<td id=res><%=rs.getString(5)%></td>
<td id=res><%=rs.getString(1)%></td>
</tr>
<%
}
%>
</table>
<%
}
catch(Exception e){out.println(e);}
if(!vbp.excep.equals(""))
out.println("An Exception Occured:-"+vbp.excep);
%></font>
<a id="goback" href=viewvendor.jsp?vid=<%=request.getParameter("vid")%>>Go back to vendor page</a>