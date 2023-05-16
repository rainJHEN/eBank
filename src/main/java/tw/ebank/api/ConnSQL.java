package tw.ebank.api;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class ConnSQL {
	
	public static Connection connect() throws Exception{
		String driver ="com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String SQL_url = "jdbc:sqlserver://localhost:1433;databaseName=ebank;encrypt=false";
		Properties prop = new Properties();
		prop.setProperty("user", "sa");
		prop.setProperty("password", "123456");
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(SQL_url,prop);
		return conn;
	}
	
}
