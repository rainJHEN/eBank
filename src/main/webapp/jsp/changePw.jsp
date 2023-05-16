<%@page import="tw.ebank.model.*"%>
<%@page import="tw.ebank.api.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
	// 獲取資料庫連接池物件
		try{
			ServletContext servletContext = getServletContext();
			ConnectionPool connectionPool = (ConnectionPool) servletContext.getAttribute("connectionPool");
				
			// 從連接池中獲取資料庫連接
			Connection connection = connectionPool.getConnection();
				
			// 使用資料庫連接進行資料庫操作
			String sql = "UPDATE custom SET password = ?  WHERE email=?";
			String email = request.getParameter("email");
			String pswd =BCrypt.hashpw(request.getParameter("password"), BCrypt.gensalt()) ;
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setString(1,pswd);
			pstmt.setString(2, email);
			int up = pstmt.executeUpdate();
			if(up == 1 ){
				response.getWriter().write("success");
			}else{
				response.getWriter().write("failed");
			}	
			// 釋放資料庫連接
			connectionPool.releaseConnection(connection);
		
		}catch(Exception e){
			response.getWriter().write("failed");
		}
		
	
	%>