<%@page import="tw.ebank.model.*"%>
<%@page import="tw.ebank.api.*"%>
<%@page import="javax.servlet.ServletContext" %>
<%@page import="javax.servlet.*"%>
<%@page import="java.sql.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 獲取資料庫連接池物件
	ServletContext servletContext = getServletContext();
	ConnectionPool connectionPool = (ConnectionPool) servletContext.getAttribute("connectionPool");
	
	// 使用資料庫連接進行資料庫操作
    String IDNumber = request.getParameter("IDNumber");
    
	boolean isExisted = connectionPool.checkIDNumber(IDNumber);
	if(isExisted){
		response.getWriter().write("帳戶已存在");
	}else{
		response.getWriter().write("帳戶可以使用");
	}
%>