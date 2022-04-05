package com.company.myPage;

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
import javax.servlet.http.HttpSession;

import com.company.common.JDBCconn;

@WebServlet("/UserInfo_Update")
public class UserInfo_Update extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("내정보 수정sql 페이지");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name"); // 이페이지에서 시작하는 사람도 있어서 세션 구현.
		if (name == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		
		String id= request.getParameter("id");
		String pw = request.getParameter("pw");
		String name1 = request.getParameter("name");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		
		System.out.println(id+"/"+ pw +"/"+ name1 +"/"+ phone +"/"+ email);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = JDBCconn.getConnection();
			// 아이디값이 일치하면 수정된 객채로 셋팅
			String sql = "update HomeUsers set pw=?, name=?, phone=?, email=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pw);
			pstmt.setString(2, name1);
			pstmt.setString(3, phone);
			pstmt.setString(4, email);
			pstmt.setString(5, id);

			int cnt = pstmt.executeUpdate();
			if(cnt !=0) {
				PrintWriter out = response.getWriter();
				out.println("<script> alert('개인정보가 수정 되었습니다.'); location.href='My_Info_List';  </script>");
				out.flush();
			}


			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCconn.close(pstmt, conn);
		}
	}
}