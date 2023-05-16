<%@page import="tw.ebank.model.*"%>
<%@page import="tw.ebank.api.*"%>
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
		String sql = "SELECT * FROM staff WHERE employeeID=?";
		String empID = request.getParameter("empID");
		String pswd = request.getParameter("password");
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1,empID);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()){
			if(BCrypt.checkpw(pswd, rs.getString("password"))){
				Staff_model staff = new Staff_model();
				staff.setEmpID(rs.getString("employeeID"));
				staff.setName(rs.getString("name"));
				session.setAttribute("eBank_staff", staff);
				response.getWriter().write("success");
			}else{
				response.getWriter().write("failed");
			}
		}else{
			response.getWriter().write("failed");
		}
			
			
		// 釋放資料庫連接
		connectionPool.releaseConnection(connection);
	
	
	%>