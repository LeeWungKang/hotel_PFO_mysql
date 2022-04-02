package com.company.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.company.common.JDBCconn;

@WebServlet("/UserGrade_Update")
public class UserGrade_Update extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	System.out.println("/UserGrade_Update-----");
		
	request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String sendID = request.getParameter("sendID");
		String grade = request.getParameter("grade");

		System.out.println(sendID+"//"+grade);
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn=JDBCconn.getConnection();
				String sql="update HomeUsers set grade=? where id=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, grade);
				pstmt.setString(2, sendID);
				int cnt=pstmt.executeUpdate();
				
				PrintWriter out = response.getWriter();
				if(cnt != 0) {
					out.print(1);
					out.flush();
					return;
				}else {
					cnt = 0;
					out.close();
					return;
				}		
		
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}finally {	JDBCconn.close(pstmt, conn);	}
		}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
