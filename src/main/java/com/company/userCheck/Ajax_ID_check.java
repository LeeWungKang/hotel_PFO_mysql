package com.company.userCheck;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.company.common.JDBCconn;

@WebServlet("/Ajax_ID_check")
public class Ajax_ID_check extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id");
		int msg=0;
		
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn=JDBCconn.getConnection();

			String sql="select * from HomeUsers where id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			System.out.println("쿼리실행"+id);
			
			if(rs.next()) {
				msg=0;    //중복된아이디 (x)
			}else {
				msg=1;    //중복없는 아이디 (o)
			}
			
			PrintWriter out = response.getWriter();
			out.write(msg+"");
			
			
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();    
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCconn.close(rs, pstmt, conn);
	}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}}