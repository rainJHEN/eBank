<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="tw.ebank.model.*"%>
<%@page import="tw.ebank.api.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%	
    
	if(session.getAttribute("member") != null){
		Member member = (Member)session.getAttribute("member");
		// 獲取資料庫連接池物件
		ServletContext servletContext = getServletContext();
		ConnectionPool connectionPool = (ConnectionPool) servletContext.getAttribute("connectionPool");
		
		// 從連接池中獲取資料庫連接
		Connection connection = connectionPool.getConnection();
		
		// 使用資料庫連接進行資料庫操作
		String sql = "SELECT * FROM NTAccount WHERE member ID = ?";
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1,member.getMemberID());
		ResultSet rs = pstmt.executeQuery();
		JSONArray jsArray = new JSONArray();
		if(rs.next()){
			do{
				JSONObject jsobj = new JSONObject();
				jsobj.append("account", rs.getString("NTAccount"));
				jsobj.append("balance", rs.getDouble("balance"));
				jsArray.put(jsobj);
			}while(rs.next());
			session.setAttribute("NTTrade_Json",jsArray.toString());
			connectionPool.releaseConnection(connection);
			response.sendRedirect("/FinalProject/Plan_B/transferMoney.html");
		}else{
			//查無資料導向其他葉面
			connectionPool.releaseConnection(connection);
			response.sendRedirect("/FinalProject/planA0408/UserLogin.html");
		}
	}else{
		response.sendRedirect("/MavenWeb/PlanA/UserLogin.html");
	}
	
%>
