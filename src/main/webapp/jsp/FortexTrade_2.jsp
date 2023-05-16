<%@page import="java.math.BigDecimal"%>
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
		String outAcc = request.getParameter("outAcc");
		String inAcc  = request.getParameter("inAcc");
		String outMoney = request.getParameter("amount");
		String exchange = request.getParameter("exchange");
		String inMoney = new BigDecimal(outMoney).multiply(new BigDecimal(exchange)).toString();
		String password = request.getParameter("password");
		String outCurr = request.getParameter("outCurr");
		String inCurr = request.getParameter("inCurr");
		
		String num = "";
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
				CallableStatement cs = connection.prepareCall("{call fortexTrade(?,?,?,?,?,?,?,?,?,?)}");
			      cs.setString(1, outAcc);
			      cs.setString(2, outCurr);
			      cs.setString(3, inAcc);
			      cs.setString(4, inCurr);
			      cs.setFloat(5, Float.parseFloat(outMoney));
			      cs.setFloat(6, Float.parseFloat(inMoney));
			      cs.setString(7, num);
			      cs.setString(8, null);
			      cs.registerOutParameter(9, java.sql.Types.FLOAT);
			      cs.registerOutParameter(10, java.sql.Types.INTEGER);
			      cs.execute();
			      float balance = cs.getFloat(9);
			      int error = cs.getInt(10);
			      out.print(error);
			      if(error != 0){
			    	  //轉帳失敗
			    	  connectionPool.releaseConnection(connection);
			    	  response.sendRedirect("/MavenWeb/PlanB/webBrokenSecond.html?error=");
			      }else{
				 			FortexTrade_model model = new FortexTrade_model();
				 			DecimalFormat df = new DecimalFormat("#,###.00");
				 			String balance_str = df.format(balance);
				 		    String amount= df.format(outMoney);
				 			model.setBalance(balance_str);
				 			model.setInAcc(inAcc);
				 			model.setOutAcc(outAcc);
				 			model.setAmount(amount);
				 			session.setAttribute("FortexTrade_model", model);
				 			connectionPool.releaseConnection(connection);
				 			response.sendRedirect("/MavenWeb/PlanB/fortexTradingFinish.jsp");
			      }	
			    
	    	}else{
	    		//轉帳失敗
	    		connectionPool.releaseConnection(connection);
		    	response.sendRedirect("/MavenWeb/PlanB/transferBroken.html?x=1");
	    	}
	    }else{
    		//轉帳失敗
    		connectionPool.releaseConnection(connection);
	    	response.sendRedirect("/MavenWeb/PlanB/transferBroken.html?x=2");
    	}
		 } catch (SQLException e) {
	    	//轉帳失敗
	    	//response.sendRedirect("/MavenWeb/PlanB/transferBroken.html?x="+e.toString());
	    	out.print(e.toString());
	    } 
;	%>
