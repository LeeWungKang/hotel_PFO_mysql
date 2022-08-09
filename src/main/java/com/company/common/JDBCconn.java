package com.company.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JDBCconn {
	public static Connection getConnection() throws ClassNotFoundException, SQLException {

		/*
		 * Class.forName("oracle.jdbc.driver.OracleDriver"); String url
		 * ="jdbc:oracle:thin:@localhost:1521:xe"; Connection conn =
		 * DriverManager.getConnection(url, "system", "1234"); return conn;
		 */
		
		/* mysql localhost:3307 */
		  
		
		  Class.forName("com.mysql.jdbc.Driver"); 
		  String url="jdbc:mysql://localhost/kjdndrkd"; 
		  Connection conn = DriverManager.getConnection(url,"kjdndrkd","cjdtks3232!!");
		  System.out.println("카페24 외부서버 연동 완료"); 
		  return conn; 
		  }

		 
		/*
		 * Class.forName("com.mysql.jdbc.Driver"); String
		 * url="jdbc:mysql://kjdndrkd.cafe24.com/kjdndrkd"; Connection conn =
		 * DriverManager.getConnection(url,"kjdndrkd","cjdtks3232!!");
		 * System.out.println("카페24 DB 연동 완료"); return conn; }
		 */
		
		
	
	
		// mysql  DB로 접속, 
		
		/*
		 * Class.forName("com.mysql.jdbc.Driver"); String url
		 * ="jdbc:mysql://localhost:3306/test1"; Connection conn =
		 * DriverManager.getConnection(url,"root","0000"); 
		 * return conn; 
		 *   System.out.println("MYSQL DB 연동 완료");
		 * 
		 * }
		 */
	

	public static void close(ResultSet rs, PreparedStatement pstmt, Connection conn) {

		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public static void close(PreparedStatement pstmt, Connection conn) {

		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
