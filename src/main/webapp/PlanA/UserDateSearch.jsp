<!-- 為00003333和四月交易明細，寫死的 -->
<%@page import="java.text.ParseException"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="java.util.Collections" %>



<!DOCTYPE html>
<html>
	<sql:setDataSource
		driver="com.microsoft.sqlserver.jdbc.SQLServerDriver"
		url="jdbc:sqlserver://127.0.0.1:1433;databaseName=eBank;Encrypt=false;"
		user="sa"
		password="123456"
	/>
		
<%
String loginAccount = "0000000001";
%>


<%!
  SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>

<%
  String startDateString = request.getParameter("startDate");
  String endDateString = request.getParameter("endDate");
  Date startDate = null;
  Date endDate = null;

  //如果有提供日期區間，則解析日期字串成日期物件
  if (startDateString != null && endDateString != null) {
    try {
      startDate = dateFormat.parse(startDateString);
      endDate = dateFormat.parse(endDateString);

      // 日期區間的結束日期需要加上一天，才能取到該日的交易紀錄
      Calendar calendar = Calendar.getInstance();
      calendar.setTime(endDate);
      calendar.add(Calendar.DATE, 1);
      endDate = calendar.getTime();
    } catch (ParseException e) {
      // 解析日期字串失敗，可以在此寫入例外處理的程式碼
      e.printStackTrace();
    }
  }
%>

<%
String orderBy = request.getParameter("orderBy");
String orderByClause = "ORDER BY transTime DESC, transNum DESC";
if ("date2".equals(orderBy)) {
    orderByClause = "ORDER BY transTime ASC, transNum ASC";
}else{
	orderByClause = "ORDER BY transTime DESC, transNum DESC";
}
%>

<sql:query var="tr">
  SELECT 
       transOutNTRecord.transTime as transTime,
       '轉出' as summary,
       transOutNTRecord.NTAccount as ChangeBalanceAccount, 
       transOutNTRecord.transNTAmount as expenses, 
       null as TransferIn, 
       transOutNTRecord.transNTBalance as Balance, 
       transOutNTRecord.transNum as transNum,
       transInNTRecord.NTAccount as transInOutAcc,
       transOutNTRecord.other as other
  FROM transOutNTRecord 
  JOIN transInNTRecord ON transOutNTRecord.transNum = transInNTRecord.transNum
  WHERE transOutNTRecord.NTAccount = '<% out.print(loginAccount); %>' 
  AND transOutNTRecord.transTime BETWEEN '<% out.print(startDateString); %>'  AND '<% out.print(endDateString); %>'
  
  UNION ALL
  
  SELECT 
       transInNTRecord.transTime as transTime,
       '轉入' as summary,
       transInNTRecord.NTAccount as ChangeBalanceAccount, 
       null as expenses, 
       transInNTRecord.transNTAmount as TransferIn, 
       transInNTRecord.transNTBalance as Balance, 
       transInNTRecord.transNum as transNum,
       transOutNTRecord.NTAccount as transInOutAcc,
       transInNTRecord.other as other
  FROM transOutNTRecord 
  JOIN transInNTRecord ON transOutNTRecord.transNum = transInNTRecord.transNum
  WHERE transInNTRecord.NTAccount = '<% out.print(loginAccount); %>'
  AND transOutNTRecord.transTime BETWEEN '<% out.print(startDateString); %>'  AND '<% out.print(endDateString); %>'

  <%= orderByClause %>
</sql:query>


<head>
  <meta charset="UTF-8">
  <title>交易明細</title>
</head>

<body>
  <table class="transaction-table active table table-striped table-hover">
    <tr>
      <th>日期</th>
      <th>摘要</th>
      <th>支出</th>
      <th>存入</th>
      <th>結餘</th>
      <th>轉出入帳號</th>
      <th>備註</th>
    </tr>
    <c:forEach items="${tr.rows}" var="t">
      <tr>
        <td>${t.transTime}</td>
        <td>${t.summary}</td>
        <td>${t.expenses}</td>
        <td>${t.TransferIn}</td>
        <td>${t.Balance}</td>
        <td>${t.transInOutAcc}</td>
        <td>${t.other}</td>
      </tr>
    </c:forEach>
  </table>
</body>


</html>