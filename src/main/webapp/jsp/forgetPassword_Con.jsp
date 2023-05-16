<%@page import="java.util.Date"%>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.util.*" %>
<%@page import="tw.ebank.model.*"%>
<%@page import="tw.ebank.api.*"%>
<%@page import="javax.servlet.ServletContext" %>
<%@page import="javax.servlet.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	

		//獲取資料庫連接池物件
		ServletContext servletContext = getServletContext();
		ConnectionPool connectionPool = (ConnectionPool) servletContext.getAttribute("connectionPool");
		
		// 從連接池中獲取資料庫連接
		Connection connection = connectionPool.getConnection();
		
		// 使用資料庫連接進行資料庫操作
		String email = request.getParameter("email");
		//String email = "l.victor0325@gmail.com";
		//String sql = "SELECT * FROM custom WHERE Email = ?";
    	try {
			//PreparedStatement pstmt = connection.prepareStatement(sql);
			//pstmt.setString(1,email);
			//ResultSet rs = pstmt.executeQuery();
			if(true) {
				//生成jwt
				String token = JwtUtils.generateToken(email);
				//设置SMTP服务器信息
				final String host = "smtp.gmail.com";
				final String port = "587";
				final String username = "qazwsx870325@gmail.com";
				final String password = "rbqtpculjpnesafe";
				
				//创建Properties对象
				Properties props = new Properties();
				props.put("mail.smtp.host", host);
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.starttls.enable", "true");
				props.put("mail.smtp.port", port);
				
				//创建Session对象
				Session session1 = Session.getInstance(props, new Authenticator() {
				  protected PasswordAuthentication getPasswordAuthentication() {
				    return new PasswordAuthentication(username, password);
				  }
				});
				
				//创建MimeMessage对象
				Message message = new MimeMessage(session1);
				
				//设置发件人
				message.setFrom(new InternetAddress("qazwsx870325@gmail.com"));
				
				//设置收件人
				message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
				
				//设置邮件主题
				message.setSubject("更改您的帳號密碼");
				
				message.setSentDate(new Date());
				
				//设置邮件正文
				message.setText("http://localhost:7070/MavenWeb/PlanA/UserChangePw.jsp?token="+token);
				
				//发送邮件
				Transport.send(message);
				response.getWriter().write("success");
				// 釋放資料庫連接
				connectionPool.releaseConnection(connection);
			}else {
				connectionPool.releaseConnection(connection);
				response.getWriter().write("failed");
			}
		} catch (Exception e) {
			connectionPool.releaseConnection(connection);
			response.getWriter().write("failed");
		}
		
	
%>
