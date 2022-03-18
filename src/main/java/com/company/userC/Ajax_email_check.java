package com.company.userC;

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
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");

		String email = request.getParameter("email");
		int emailCheck = 0;

		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = JDBCconn.getConnection();

			String sql = "select substr(email,1,instr(email,'@')-1) as email_str from HomeUsers where email=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "email_str");
			rs = pstmt.executeQuery();

			System.out.println("쿼리실행" + email + "@");

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
}
