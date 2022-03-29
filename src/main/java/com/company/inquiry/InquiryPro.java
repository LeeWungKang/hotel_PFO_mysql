package com.company.inquiry;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.company.common.JDBCconn;

@WebServlet("/InquiryPro")
public class InquiryPro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/InquiryPro");
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String b_userid= request.getParameter("b_userid");
		String b_title = request.getParameter("b_title");
		String b_content = request.getParameter("b_content");
		
		System.out.println(b_userid +" /"+b_title+" /"+b_content);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = JDBCconn.getConnection();
			String sql = "insert into inquiry (b_no, b_userid, b_title, b_content, b_writedate) values ( (select nvl(max(b_no),0)+1 from inquiry),? ,? ,?, sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b_userid);
			pstmt.setString(2, b_title);
			pstmt.setString(3, b_content);

			int cnt = pstmt.executeUpdate();
			
			if(cnt != 0) {
				response.sendRedirect("index.jsp");
			}


		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCconn.close(pstmt, conn);
		}
	}
}
