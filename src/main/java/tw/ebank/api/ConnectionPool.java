package tw.ebank.api;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.*;
import java.time.format.*;
import java.util.ArrayList;
import java.util.List;

import org.eclipse.jdt.internal.compiler.codegen.IntegerCache;

public class ConnectionPool {
	
    private String jdbcDriver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private String jdbcUrl = "jdbc:sqlserver://localhost:1433;databaseName=eBank;encrypt=false";
    private String jdbcUsername = "kiki";
    private String jdbcPassword = "kiki312090";
    private int initialPoolSize = 5;
    private List<Connection> pool;
    private boolean isClosed = false;
    public ConnectionPool() {
        pool = new ArrayList();
        for (int i = 0; i < initialPoolSize; i++) {
            pool.add(createConnection());
        }
        
    }
    public synchronized boolean checkIDNumber(String IDNumber) {
    	boolean isExisted = true;
    	Connection conn = getConnection();
    	String sql = "SELECT * FROM custom WHERE IDNumber = ?";
    	try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,IDNumber);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				releaseConnection(conn);
				isExisted = true;
			}else {
				releaseConnection(conn);
				isExisted = false;
			}
		} catch (SQLException e) {
			releaseConnection(conn);
			isExisted = true;
		}
    	return isExisted;
    }
    public synchronized String createTransNum() throws Exception{
    	Connection conn = getConnection();
    	String transNum = "";
    	String sql_1 = "select TOP 1 transnum from transOutNTRecord order by transnum DESC";
    	String sql_2 = "select TOP 1 transnum from transOutJPYRecord order by transnum DESC";
    	String sql_3 = "select TOP 1 transnum from transOutUSDRecord order by transnum DESC";
    	String sql_4 = "select TOP 1 transnum from transOutEURRecord order by transnum DESC";
    	
		Statement stmt1 =  conn.createStatement();
		Statement stmt2 =  conn.createStatement();
		Statement stmt3 =  conn.createStatement();
		Statement stmt4 =  conn.createStatement();
		ResultSet rs_1 = stmt1.executeQuery(sql_1);
		ResultSet rs_2 = stmt2.executeQuery(sql_2);
		ResultSet rs_3 = stmt3.executeQuery(sql_3);
		ResultSet rs_4 = stmt4.executeQuery(sql_4);
		LocalDate currentDate = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		String dateString = currentDate.format(formatter);
		
		long t1 = (rs_1.next())?Long.parseLong(rs_1.getString("transnum")):0;
		long t2 = (rs_2.next())?Long.parseLong(rs_2.getString("transnum")):0;
		long t3 = (rs_3.next())?Long.parseLong(rs_3.getString("transnum")):0;
		long t4 = (rs_4.next())?Long.parseLong(rs_4.getString("transnum")):0;
		if(t1==t2 && t2==t3 && t3==t4 && t4==0) {
			transNum = dateString+"0001";
		}else {
			String t_max = Math.max(Math.max(t1, t2), Math.max(t3, t4))+"";
			if(t_max.substring(0,8).equals(dateString)){
				t_max= t_max.substring(t_max.length() - 4);
				int num_int = Integer.parseInt(t_max);
				num_int += 1;
				if(num_int >= 10000){
					throw new Exception("編號出超範圍");
				}else{
					transNum = ""+ num_int;
					while(transNum.length() < 4){
						transNum = "0"+ transNum;
					}
					transNum = dateString + transNum;
				}
			}else {
				transNum = dateString+"0001";
			}
		}
		releaseConnection(conn);
    	return transNum;
    }
    public synchronized Connection getConnection() {
        if (pool.isEmpty()) {
            pool.add(createConnection());
        }
        return pool.remove(0);
    }

    public synchronized void releaseConnection(Connection connection) {
        pool.add(connection);
    }
    
    public synchronized void destroy(){
    	 if (isClosed) {
             return;
         }
    	 isClosed = true;
    	 for (Connection conn : pool) {
             try {
                 conn.close();
             } catch (SQLException e) {
                 // 處理異常
             }
         }
    	 pool.clear();
    }
    private Connection createConnection() {
        try {
            Class.forName(jdbcDriver);
            return DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);
        } catch (Exception e) {
            throw new RuntimeException("Error creating connection", e);
        }
    }
}
