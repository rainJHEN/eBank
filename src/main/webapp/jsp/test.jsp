<%@page import="java.util.Enumeration"%>
<%@page import="tw.ebank.model.*"%>
<%@page import="tw.ebank.api.*"%>
<%@page import="javax.servlet.ServletContext" %>
<%@page import="javax.servlet.*"%>
<%@page import="io.jsonwebtoken.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<%
		// 獲取資料庫連接池物件
		ServletContext servletContext = getServletContext();
		ConnectionPool connectionPool = (ConnectionPool) servletContext.getAttribute("connectionPool");
		
		// 從連接池中獲取資料庫連接
		Connection connection = connectionPool.getConnection();
		
		// 使用資料庫連接進行資料庫操作
		
		out.print(connectionPool.createTransNum());
		
		
		// 釋放資料庫連接
		connectionPool.releaseConnection(connection);
		//response.sendRedirect("/FinalProject/Plan_B/index.html");
	%>
