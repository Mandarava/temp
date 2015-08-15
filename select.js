function doselect() {
	var myform = document.getElementById("myform");
	var workerId = document.getElementById("workerID").value;
	var nameInput = document.getElementById("nameInput").value;
	if(nameInput.trim().length != 0 ) {	//如果名称有输入优先判断
		isNameInput(nameInput);
		return;
	}
	isWorkerIdInput(workerId,nameInput);
}


function doclear() {
	var myform = document.getElementById("myform");
	myform.action = "Clear";
	myform.submit();
}


function isWorkerIdInput(workerId,nameInput) {
	if(workerId.length != 0) {		//当[工号]输入框中的有输入的时候
		var trimedWorkerId = workerId.trim(); //trim 处理
		if(trimedWorkerId.length == 0) {	//位数为0的话，直接处理isWorkerIdInput
			isNameInput(nameInput);
		}else if(trimedWorkerId.length < 8) { //位数不足8位的时候在MSG区域报消息、处理终止
			document.getElementById("errorInfo").innerText = "位数不足8位";
		}else if(trimedWorkerId.length == 8) {
			document.getElementById("errorInfo").innerText = "System is running";
			//alert("显示数据");		
			myform.action = "Select";
			myform.submit();
		}
	}else {			//当[工号]输入框中的没输入的时候
		isNameInput(nameInput);	
	}
}

function isNameInput(nameInput) {	//当[名称]输入框中有输入的时候
	if(nameInput.length != 0) {
		var trimedNameInput = nameInput.trim();//TRIM处理
		if(trimedNameInput.length == 0) {	//位数为0的话，直接处理noInput
			noInput();
		}else {
			document.getElementById("errorInfo").innerText = "System is running";
			alert("显示数据");
			myform.action = "Select";
			myform.submit();
		}
	}else {		//当名称输入框中也没有输入的时候
		noInput();
	}
}

function noInput() {
		document.getElementById("errorInfo").innerText = "请输入！";
}


var deptNameRadioState = 1;
 function deptNameRadioClick(){	
	if (deptNameRadioState == 1){
		document.getElementById('deptName').checked = false;
		deptNameRadioState = 0;
	}else{
		document.getElementById('deptName').checked = true;
		deptNameRadioState = 1;
	}        
}

var workerNameRadioState = 0;
 function workerNameRadioClick(){	
	if (workerNameRadioState == 1){
		document.getElementById('workerName').checked = false;
		workerNameRadioState = 0;
	}else{
		document.getElementById('workerName').checked = true;
		workerNameRadioState = 1;
	}        
}

//html 1：3：3 to be finished
//onclick="workerNameRadioClick();"
//onclick="deptNameRadioClick();"
//数字小数点
//名称不能清空