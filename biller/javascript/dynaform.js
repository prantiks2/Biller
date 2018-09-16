var i = 1;
var pid=0;
var request;
function increment()
{
i += 1;
}
function getProduct()
{
	pid=document.mainform.upcscan.value;
	document.mainform.upcscan.value="";
	document.mainform.upcscan.focus();
	var flag=0;
	var j=0;
//document.getElementById("diag").innerHTML="<font color=red>start of getproduct</font>";
	for(j=1;j<i;j=j+1)
	{//document.getElementById("diag").innerHTML="<font color=red>in for</font>";
		if(pid==document.getElementById("upcid"+j).value)
		{
			flag=1;
			var q=parseInt(document.getElementById("proqtyid"+j).value);
			q=q+1;//document.getElementById("diag").innerHTML="<font color=red>q=q+1</font>";
			document.getElementById("proqtyid"+j).value=q;
			//document.getElementById("diag").innerHTML="<font color=red>breaking from for</font>";
			setgrtot(j);
			break;
		}
			
	}
	if(flag!=1)
	{
		var r = document.createElement('tr');
		r.setAttribute("id", "itemrow"+i);
		var d = document.createElement('td');
		d.innerHTML=i;
		var y = document.createElement('input');
		y.setAttribute("type","hidden");
		y.setAttribute("value",pid);
		y.setAttribute("id", "upcid" + i);
		y.setAttribute("name","UPC"+i);
		d.appendChild(y);
		r.appendChild(d);
		var lastrow=document.getElementById("gt");
		var tab=document.getElementById("bill");
		//document.getElementById("diag").innerHTML="<font color=red>start of row insertion</font>";
		lastrow.before(r);
		//document.getElementById("diag").innerHTML="<font color=red>reached end of else in getproduct</font>";
		setname();
	}
}
function setname()  
{    
	var url="proinfo.jsp?id="+pid+"&attr=name"; 
	if(window.XMLHttpRequest)
	{  
	request=new XMLHttpRequest();  
	}  
	else if(window.ActiveXObject)
	{  
	request=new ActiveXObject("Microsoft.XMLHTTP");  
	}  
	try
	{  
		//document.getElementById("diag").innerHTML="<font color=red>reached start of try in setname</font>";
		request.onreadystatechange=getproductname
		request.open("GET",url,true);  
		request.send();  
	}
	catch(e){alert("Unable to connect to server");}  
}
function getproductname()
{
	if(request.readyState==4)
	{  

	var val=request.responseText;
	var d = document.createElement('td');
	d.innerHTML=val;
	var y = document.createElement('input');
	y.setAttribute("type","hidden");
	y.setAttribute("value",val);
	y.setAttribute("name", "proname" + i);
	d.appendChild(y);
	document.getElementById('itemrow'+i).appendChild(d);
	setmrp();
//document.getElementById("diag").innerHTML="<font color=red>reached end of getProductname</font>";
	}
}

function setmrp()  
{    
	var url="proinfo.jsp?id="+pid+"&attr=mrp";
	if(window.XMLHttpRequest)
	{  
	request=new XMLHttpRequest();  
	}  
	else if(window.ActiveXObject)
	{  
	request=new ActiveXObject("Microsoft.XMLHTTP");  
	}  
	try
	{  
		//document.getElementById("diag").innerHTML="<font color=red>reached start of try in setmrp</font>";
		request.onreadystatechange=getproductmrp
		request.open("GET",url,true);  
		request.send();  
	}
	catch(e){alert("Unable to connect to server");}  
}
function getproductmrp()
{
	if(request.readyState==4)
	{  

	var val=request.responseText;
	var d = document.createElement('td');
	d.innerHTML=val;
	var y = document.createElement('input');
	y.setAttribute("type","hidden");
	y.setAttribute("value",val);
	y.setAttribute("name", "promrp" + i);
	d.appendChild(y);
	document.getElementById('itemrow'+i).appendChild(d);
	setcp();
//document.getElementById("diag").innerHTML="<font color=red>reached end of getProductmrp</font>";
	}
}
function setcp()  
{    
	var url="proinfo.jsp?id="+pid+"&attr=cp";
	if(window.XMLHttpRequest)
	{  
	request=new XMLHttpRequest();  
	}  
	else if(window.ActiveXObject)
	{  
	request=new ActiveXObject("Microsoft.XMLHTTP");  
	}  
	try
	{  
		//document.getElementById("diag").innerHTML="<font color=red>reached start of try in setcp</font>";
		request.onreadystatechange=getproductcp
		request.open("GET",url,true);  
		request.send();  
	}
	catch(e){alert("Unable to connect to server");}  
}
function getproductcp()
{
	if(request.readyState==4)
	{  

	var val=request.responseText;
	var d = document.createElement('td');
	d.innerHTML=val;
	var y = document.createElement('input');
	y.setAttribute("type","hidden");
	y.setAttribute("value",val);
	y.setAttribute("name", "procp" + i);
	y.setAttribute("id", "procpid" + i);
	d.appendChild(y);
	document.getElementById('itemrow'+i).appendChild(d);
	setsp();
//document.getElementById("diag").innerHTML="<font color=red>reached end of getProductcp</font>";
	}
}
function setsp()  
{    
	var url="proinfo.jsp?id="+pid+"&attr=sp";
	if(window.XMLHttpRequest)
	{  
	request=new XMLHttpRequest();  
	}  
	else if(window.ActiveXObject)
	{  
	request=new ActiveXObject("Microsoft.XMLHTTP");  
	}  
	try
	{  
		//document.getElementById("diag").innerHTML="<font color=red>reached start of try in setsp</font>";
		request.onreadystatechange=getproductsp
		request.open("GET",url,true);  
		request.send();  
	}
	catch(e){alert("Unable to connect to server");}  
}
function getproductsp()
{
	if(request.readyState==4)
	{  

	var val=request.responseText;
	var d = document.createElement('td');
	var y = document.createElement('input');
	y.setAttribute("type","text");
	y.setAttribute("value",val);
	y.setAttribute("name", "prosp" + i);
	y.setAttribute("id", "prospid" + i);
	y.setAttribute("class", "psell");
	y.setAttribute("onchange", "setgrtot("+i+")");
	d.appendChild(y);
	document.getElementById('itemrow'+i).appendChild(d);
//document.getElementById("diag").innerHTML="<font color=red>reached end of getProductsp</font>";
	setqty();
	}
}
function setqty()
{
	//document.getElementById("diag").innerHTML="<font color=red>reached start of setqty</font>";
	var d = document.createElement('td');
	var y = document.createElement('input');
	y.setAttribute("type","text");
	y.setAttribute("value","1");
	y.setAttribute("name", "proqty" + i);
	y.setAttribute("id", "proqtyid" + i);
	y.setAttribute("class", "pqt");
	y.setAttribute("onchange", "setgrtot("+i+")");
	d.appendChild(y);
	document.getElementById('itemrow'+i).appendChild(d);
//document.getElementById("diag").innerHTML="<font color=red>reached end of setqty</font>";
	creategrtot();
}
function creategrtot()
{
	//document.getElementById("diag").innerHTML="<font color=red>reached start of creategrtot</font>";
	var d = document.createElement('td');
	var y = document.createElement('input');
	y.setAttribute("type","text");
	y.setAttribute("name", "progtot" + i);
	y.setAttribute("value","0");
	y.setAttribute("id", "progtotid" + i);
	y.disabled=true;
	y.setAttribute("class", "psell");
	d.appendChild(y);
	document.getElementById('itemrow'+i).appendChild(d);
	increment();
	setgrtot(i-1);
//document.getElementById("diag").innerHTML="<font color=red>reached end of creategrtot</font>";
}
function setgrtot(row)
{
	//document.getElementById("diag").innerHTML="<font color=red>reached start of setgrtot yo</font>";
	var iqty=parseFloat(document.getElementById("proqtyid"+row).value);
	var isp=parseFloat(document.getElementById("prospid"+row).value);
	var tot=iqty*isp;
	document.getElementById("progtotid"+row).value=tot;
	//document.getElementById("diag").innerHTML="<font color=red>reached end of setgrtot</font>";
	setgrandtotal();
}
function setfields()
{
	var j=0;
	if(document.getElementById("grandtotal").value==0)
	{	
		document.getElementById("gterr").innerHTML="<font color=red>Grand total cannot be zero, please scan item to create bill!</font>";
		j=1;
	}
	else
	document.getElementById("gterr").innerHTML="";
	if(document.getElementById("cid").value=="")
	{	
		document.getElementById("ciderr").innerHTML="<font color=red>Please provide customer ID!</font>";
		j=1;
	}
	else
	document.getElementById("ciderr").innerHTML="";
	if(j==1)
	return false;
	for(j=1;j<i;j++)
	{
		document.getElementById("progtotid"+j).disabled=false;
	}
	document.getElementById("total").disabled=false;
	document.getElementById("rtotal").disabled=false;
	document.getElementById("grandtotal").disabled=false;
	document.getElementById("amtdue").disabled=false;
	document.getElementById("pft").disabled=false;
	document.getElementById("bsln").value=i-1;
}
function setgrandtotal()
{
	var j=0;
	var tot=0;
	var totcp=0;
	for(j=1;j<i;j++)
	{
		tot=tot+parseFloat(document.getElementById("progtotid"+j).value);
		totcp=totcp+(parseFloat(document.getElementById("proqtyid"+j).value)*parseFloat(document.getElementById("procpid"+j).value));
	}
	document.getElementById("total").value=tot;
	document.getElementById("rtotal").value=Math.ceil(tot);
	document.getElementById("grandtotal").value=parseFloat(document.getElementById("rtotal").value)-parseFloat(document.getElementById("addis").value);
	document.getElementById("amtdue").value=parseFloat(document.getElementById("grandtotal").value)-parseFloat(document.getElementById("amtpaid").value);
	document.getElementById("pft").value=parseFloat(document.getElementById("grandtotal").value)-totcp;
}
function setcustname()  
{    	
	var cuid=document.getElementById("cid").value;
	var url="custname.jsp?id="+cuid; 
	if(window.XMLHttpRequest)
	{  
	request=new XMLHttpRequest();  
	}  
	else if(window.ActiveXObject)
	{  
	request=new ActiveXObject("Microsoft.XMLHTTP");  
	}  
	try
	{  
		//document.getElementById("diag").innerHTML="<font color=red>reached start of try in setcustname</font>";
		request.onreadystatechange=getcustname
		request.open("GET",url,true);  
		request.send();  
	}
	catch(e){alert("Unable to connect to server");}  
}
function getcustname()
{
	if(request.readyState==4)
	{  
	var val=request.responseText;
	document.getElementById("cname").innerHTML=val;
//document.getElementById("diag").innerHTML="<font color=red>reached end of getcustname</font>";
	}
}
function scnr()
{
	document.getElementById("err").focus();
	document.getElementById("msg").innerHTML="<font color=green>Ready to scan items</font>";
}
function scnb()
{
	document.getElementById("msg").innerHTML="Double click anywhere to scan items";
}