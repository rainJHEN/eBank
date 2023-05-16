<%@page import="tw.ebank.model.*"%>
<%@page import="tw.ebank.api.*"%>
<%@page import="javax.servlet.ServletContext" %>
<%@page import="javax.servlet.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	try{
		request.setCharacterEncoding("UTF-8");
		String memberID="" ;
		String nickName ;
		String chineseName ;
		String engName ;
		String IDNumber;
		String password ;
		String Email ;
		String birthday ;
		// 獲取資料庫連接池物件
			
		ServletContext servletContext = getServletContext();
		ConnectionPool connectionPool = (ConnectionPool) servletContext.getAttribute("connectionPool");
			
		// 從連接池中獲取資料庫連接
		Connection conn = connectionPool.getConnection();
		// 使用資料庫連接進行資料庫操作
		
			//生成memberID
			String sql_sel = "select TOP 1 memberID from custom order by memberID DESC";
			Statement stmt = conn.createStatement();
			ResultSet rs1 = stmt.executeQuery(sql_sel);
			if (rs1.next()){
				String m =  rs1.getString("memberID");
				int m_int = Integer.parseInt(m);
				m_int += 1;
				if(m_int >= 1000000000){
					memberID = null;
				}else{
					memberID = ""+ m_int;
					while(memberID.length() < 10){
						memberID = "0"+ memberID;
					}
				}
			}else{
				//填入參數
				memberID = "0000000001";
			}
			IDNumber = request.getParameter("IDNumber");
			password =BCrypt.hashpw(request.getParameter("password"), BCrypt.gensalt());
			chineseName = request.getParameter("chineseName");
			engName = request.getParameter("engName");
			nickName = request.getParameter("nickName");
			Email = request.getParameter("Email");
			birthday = request.getParameter("birthday");
			
			//insert進資料庫
			String sql_ins = "INSERT INTO custom(memberID,nickName,chineseName,engName,IDNumber,password,Email,birthday) VALUES(?,?,?,?,?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql_ins);
			pstmt.setString(1, memberID);
			pstmt.setString(2, nickName);
			pstmt.setString(3, chineseName);
			pstmt.setString(4, engName);
			pstmt.setString(5, IDNumber);
			pstmt.setString(6, password);
			pstmt.setString(7, Email);
			pstmt.setString(8, birthday);
			int row = pstmt.executeUpdate();
			if(row == 0){
				response.getWriter().write("failed");
			}else{
				response.getWriter().write("success");
			}
			connectionPool.releaseConnection(conn);
	}catch(Exception e){
		response.getWriter().write("failed");
	}
	
%>