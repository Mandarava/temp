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




在HTML练习基础上在按钮“检索”上面，增加下面功能
1、当[工号]输入框中的有输入的时候
1-1、TRIM处理
1-2、位数为0的话，直接处理2
1-3、位数不足8位的时候在MSG区域报消息、处理终止
2、当[名称]输入框中有输入的时候
2-1、TRIM处理
2-2、位数为0的话，直接处理3
3、当[工号]输入框、[名称]输入框同时为空的时候，要求输入，报MSG、处理终止
4、递交后台，检索ACTION，向一览返回结果。（此处不用真检索，JAVA直接返回假数据就可以）

在HTML练习基础上在按钮“CLEAR”上面，增加下面功能
1、递交后台，清除ACTION，向画面返回结果。（一览清空，检索条件部清空，ＲＡＤＩＯ部，第一个选项选中）
★目的，同一个FORM递交不同的ACTION
