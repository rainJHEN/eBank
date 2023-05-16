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
			String sql = "SELECT * FROM custom WHERE IDNumber=?";
			String acc = request.getParameter("IDNumber");
			String pswd = request.getParameter("password");
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setString(1,acc);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()){
				if(BCrypt.checkpw(pswd, rs.getString("password"))){
					Member member = new Member();
					member.setMemberID(rs.getString("memberID"));
					member.setName(rs.getString("chineseName"));
					session.setAttribute("eBank_member", member);
					response.getWriter().write("success");
				}else{
					response.getWriter().write("failed");
				}
			}else{
				response.getWriter().write("failed");
			}
				
				
			// 釋放資料庫連接
			connectionPool.releaseConnection(connection);
		
		}catch(Exception e){
			response.getWriter().write("failed");
		}
		
	
	%>