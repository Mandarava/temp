<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>index</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript" src="JS/select.js"></script>
</head>

<body>
<s:form id="myform" action="select" method="post">
	<table border="1" style="width: 70%; table-layout: fixed">
		<colgroup>
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
		</colgroup>

		<tr>
			<td rowspan=3 colspan=7 align="center" valign="top" height=66px>
			検索条件設定</td>
			<td rowspan=3 colspan=7>工号: <input type="text" name="workerID"
				id="workerID" maxlength=8 value="${membercodeInput}" /></td>
			<td rowspan=3 colspan=6 align="center" valign="middle"><img
				src="JSP/1.jpg" style="width: 100px; height: 60px"></td>
		</tr>
		<tr>
		</tr>
		<tr>
		</tr>
		<tr>
			<td rowspan=4 colspan=5 valign="middle" height="88px">&nbsp;<input
				type="radio" name="deptName" id="deptName" value="deptName" checked>部门名<br />
			&nbsp;<input type="radio" name="workerName" id="workerName"
				value="workerName">员工姓名</td>
			<td rowspan=3 colspan=7 valign="middle"><input type="text"
				style="width: 98%" maxlength=40 name="nameInput" id="nameInput"
				value="${nameInput}" /></td>
			<td rowspan=3 colspan=8 align="center" valign="middle">&nbsp;<input
				type="button" name="select" id="select" value="檢索"
				style="height: 100px; height: 30px" onclick="doselect();">
			&nbsp;<input type="button" name="clear" id="clear" value="清除"
				style="height: 80px; height: 30px" onclick="doclear();"></td>
		</tr>
		<tr>
		</tr>
		<tr>
		</tr>
		<tr>
			<td rowspan=1 colspan=15 height="22px"><font color="red"><label
				id="errorInfo">System is running </label></font></td>
		</tr>
	</table>

	<br>
	<table border="1" style="width: 70%; table-layout: fixed">
		<colgroup>
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
			<col style="width: 3.5%" />
		</colgroup>

		<tr align="center">
			<th colspan=8 height="22px">员工信息</th>
			<th rowspan=2 colspan=4>年收</th>
			<th rowspan=2 colspan=3>所属部门<br />
			CODE</th>
			<th rowspan=2 colspan=5>所属部门<br />
			名称</th>
		</tr>
		<tr align="center">
			<th colspan=2 height="22px">工号</th>
			<th colspan=3>姓名</th>
			<th colspan=3>職務レベル</th>
		</tr>

		<c:forEach begin="0" items="${modelList}" var="model">
			<tr align="center">
				<td colspan=2 height="20">${model.membercode}</td>
				<td colspan=3 height="20">${model.name}</td>
				<td colspan=3 height="20">${model.job_level}</td>
				<td align="right" colspan=4 height="20">${model.annual_income}</td>
				<td colspan=3 height="20">${model.deptcode}</td>
				<td align="left" colspan=5 height="20">${model.deptnm}</td>
			</tr>
		</c:forEach>

	</table>
</s:form>
</body>
</html>
