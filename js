function doselect() {
	var myform = document.getElementById("myform");
	var workerId = document.getElementById("workerID").value;
	var nameInput = document.getElementById("nameInput").value;

	if (workerId.length != 0) {// 当[工号]输入框中的有输入的时候
		var trimedWorkerId = workerId.trim();// trim 处理
		if (trimedWorkerId.length == 0) {
			if (nameInput.length != 0) {
				var trimedNameInput = nameInput.trim(); // trim处理
				if (trimedNameInput.length == 0) {
					document.getElementById("errorInfo").innerText = "请输入！";
				} else {
					myform.action = "Select";
					myform.submit();
				}
			} else {
				document.getElementById("errorInfo").innerText = "请输入！";
			}
		} else if (trimedWorkerId.length < 8) {
			document.getElementById("errorInfo").innerText = "位数不足8位";
		} else {
			myform.action = "Select";
			myform.submit();
		}
	} else { // 当[工号]输入框中的没输入的时候
		if (nameInput.length != 0) {
			var trimedNameInput = nameInput.trim(); // trim处理
			if (trimedNameInput.length == 0) {
				document.getElementById("errorInfo").innerText = "请输入！";
			} else {
				myform.action = "Select";
				myform.submit();
			}
		} else {
			document.getElementById("errorInfo").innerText = "请输入！";
		}
	}

}

function doclear() {
	var myform = document.getElementById("myform");
	myform.action = "Clear";
	myform.submit();
}



左边button
下面输入玩不能清空
年收 小数点
