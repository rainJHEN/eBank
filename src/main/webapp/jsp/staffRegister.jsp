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
		String memberID ="";
		String nickName ;
		String chineseName ;
		String engName ;
		String IDNumber;
		String password ;
		String Email ;
		String birthday ;
		String[] account; 
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
				//memberID超過數字
				connectionPool.releaseConnection(conn);
				out.print("m_int");
				//response.sendRedirect("/FinalProject/Plan_B/index.html");
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
			account = request.getParameterValues("account_type");
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
			if(row == 1){
				for(String x : account){
					if(x == "ApplyTWAccount"){
						String sql_insNT = "INSERT INTO NTAccount(NTAccount,memberID,balance) VALUES(?,?,?)";
						PreparedStatement pstmtNT = conn.prepareStatement(sql_insNT);
						pstmtNT.setString(1, memberID);
						pstmtNT.setString(2, memberID);
						pstmtNT.setDouble(3,1000.0);
						int rowNT = pstmtNT.executeUpdate();
					}else if(x == "ApplyFEAccount"){
						String sql_insJPY = "INSERT INTO JPYAccount(JPYAccount,memberID,balance) VALUES(?,?,?)";
						PreparedStatement pstmtJPY = conn.prepareStatement(sql_insJPY);
						pstmtJPY.setString(1, memberID);
						pstmtJPY.setString(2, memberID);
						pstmtJPY.setDouble(3,1000.0);
						int rowJPY = pstmtJPY.executeUpdate();
						
						String sql_insEUR = "INSERT INTO EURAccount(EURAccount,memberID,balance) VALUES(?,?,?)";
						PreparedStatement pstmtEUR = conn.prepareStatement(sql_insJPY);
						pstmtEUR.setString(1, memberID);
						pstmtEUR.setString(2, memberID);
						pstmtEUR.setDouble(3,1000.0);
						int rowEUR = pstmtEUR.executeUpdate();
						
						String sql_insUSD = "INSERT INTO USDAccount(USDAccount,memberID,balance) VALUES(?,?,?)";
						PreparedStatement pstmtUSD = conn.prepareStatement(sql_insUSD);
						pstmtUSD.setString(1, memberID);
						pstmtUSD.setString(2, memberID);
						pstmtUSD.setDouble(3,1000.0);
						int rowUSD = pstmtUSD.executeUpdate();
					}
				}
				response.getWriter().write("success");
			}else{
				response.getWriter().write("failed");
			}
			connectionPool.releaseConnection(conn);
	}catch(Exception e){
		response.getWriter().write("failed");
	}
	
%>