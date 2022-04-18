package com.company.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JDBCconn {
	public static Connection getConnection() throws ClassNotFoundException, SQLException {

		/*
		 * 오라클 Class.forName("oracle.jdbc.driver.OracleDriver"); String url =
		 * "jdbc:oracle:thin:@localhost:1521:xe"; Connection conn =
		 * DriverManager.getConnection(url, "system", "1234"); return conn;
		 */

		/* 카페24디비로 연동. */

		
		
		  Class.forName("com.mysql.jdbc.Driver"); String url
		  ="jdbc:mysql://umj7-029.cafe24.com/thuman"; Connection conn =
		  DriverManager.getConnection(url,"thuman","human123!");
		  System.out.println(" 카페24 디비로 연동 "); return conn;
		 

			
			/*
			 * Class.forName("com.mysql.jdbc.Driver"); String url =
			 * "jdbc:mysql://localhost/thuman"; Connection conn =
			 * DriverManager.getConnection(url, "thuman", "human123!"); return conn;
			 */
			 

	}

	/*
	 * mysql localhost:3307, 카페에 올릴떄는 url에 로컬호스트 입력.
	 * 
	 * Class.forName("com.mysql.jdbc.Driver"); String
	 * url="jdbc:mysql://localhost/thuman"; conn =
	 * DriverManager.getConnection(url,"thuman","human123!");
	 * System.out.println("카페24 DB 연동 완료");
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
