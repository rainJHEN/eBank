<%@page import="java.time.format.*"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.time.*"%>
<%@page import="tw.ebank.model.*"%>
<%@page import="tw.ebank.api.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<%	
	try {
		// 獲取資料庫連接池物件
		ServletContext servletContext = getServletContext();
		ConnectionPool connectionPool = (ConnectionPool) servletContext.getAttribute("connectionPool");
		
		// 從連接池中獲取資料庫連接
		Connection connection = connectionPool.getConnection();
		
		// 使用資料庫連接進行資料庫操作
		request.setCharacterEncoding("UTF-8");
		String outAcc = request.getParameter("outAcc");
		String inAcc  = request.getParameter("inAcc");
		int money = Integer.parseInt(request.getParameter("amount"));
		String password = request.getParameter("password");
		String num = "";
		String other = request.getParameter("other");
		LocalDate currentDate = LocalDate.now();
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
	    DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("yyyy/MM/dd");
	    String dateString = currentDate.format(formatter);
	    String dateString2 = currentDate.format(formatter2);
	    
	    String sql_passwd = "SELECT custom.password FROM custom join NTAccount ON custom.memberID = NTAccount.memberID WHERE NTAccount.NTAccount =?";
	    PreparedStatement pstmt = connection.prepareStatement(sql_passwd);
	    pstmt.setString(1, outAcc);
	    ResultSet rs1 = pstmt.executeQuery();
	    if(rs1.next()){
	    	if(BCrypt.checkpw(password, rs1.getString("password"))){
	    		num = connectionPool.createTransNum();
				CallableStatement cs = connection.prepareCall("{call NTtrade(?,?,?,?,?,?,?)}");
			      cs.setString(1, outAcc);
			      cs.setString(2, inAcc);
			      cs.setInt(3, money);
			      cs.setString(4, num);
			      cs.setString(5, other);
			      cs.registerOutParameter(6, java.sql.Types.FLOAT);
			      cs.registerOutParameter(7, java.sql.Types.INTEGER);
			      cs.execute();
			      int error = cs.getInt(7);
			      float balance = cs.getFloat(6);
			      if(error != 0){
			    	  //轉帳失敗
			    	  connectionPool.releaseConnection(connection);
			    	  response.sendRedirect("/MavenWeb/PlanB/webBrokenSecond.html?error=");
			      }else{
			    	  
				 			NTTrade_model model = new NTTrade_model();
				 			DecimalFormat df = new DecimalFormat("#,###.00");
				 			String balance_str = df.format(balance);
				 		    String amount= df.format(money);
				 			model.setBalance(balance_str);
				 			model.setInAcc(inAcc);
				 			model.setOutAcc(outAcc);
				 			model.setAmount(amount);
				 			model.setOther(other);
				 			model.setDate(dateString2);
				 			session.setAttribute("model", model);
				 			connectionPool.releaseConnection(connection);
				 			response.sendRedirect("/MavenWeb/PlanB/transferMoneyFinish.jsp");
			      }	
			    
	    	}else{
	    		//轉帳失敗
	    		connectionPool.releaseConnection(connection);
		    	response.sendRedirect("/MavenWeb/PlanB/transferBroken.html?x=3");
	    	}
	    }else{
    		//轉帳失敗
    		connectionPool.releaseConnection(connection);
	    	response.sendRedirect("/MavenWeb/PlanB/transferBroken.html?x=2");
    	}
		 } catch (SQLException e) {
	    	//轉帳失敗
	    	response.sendRedirect("/MavenWeb/PlanB/transferBroken.html?x="+e.toString());
	    } 
;	%>
