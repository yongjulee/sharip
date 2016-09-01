package db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnector {
	
	public static Connection getConnection() throws Exception {
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String driver = "oracle.jdbc.OracleDriver";
		String id = "scott";
		String pw = "1234";
		// 드라이버 로딩
		Class.forName(driver);
		// 접속
		// import java.sql
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
	}
}









