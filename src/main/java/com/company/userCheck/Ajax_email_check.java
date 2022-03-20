package com.company.userCheck;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/Ajax_email_check")
public class Ajax_email_check extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int emailCheck = 0;
		
		String sumMail = request.getParameter("sumMail");
		System.out.println(sumMail + "//======= sumMail 확인 ");
		
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = JDBCconn.getConnection();
			String sql = "select * from HomeUsers where email=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sumMail);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				emailCheck = 0; // 중복된 이메일 (x)
			} else {
				emailCheck = 1; // 중복없는 이메일 (o)
			}

			
			PrintWriter out = response.getWriter();
			out.write(emailCheck + "");

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCconn.close(rs, pstmt, conn);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}
}
