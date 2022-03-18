package com.company.biz;

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
import javax.servlet.http.HttpSession;

import com.company.common.JDBCconn;

@WebServlet("/Update_Board")
public class Update_Board extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name"); // 이페이지에서 시작하는 사람도 있어서 세션 구현.
		if (name == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		
		
		int seq=Integer.parseInt(request.getParameter("seq"));
		String title= request.getParameter("title");
		String nickname = request.getParameter("nickname");
		String content = request.getParameter("content");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = JDBCconn.getConnection();
			// 수정한 날짜 변경 ?
			String sql = "update Homeboard set title=?, nickname=?, content=? where seq=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, nickname);
			pstmt.setString(3, content);
			pstmt.setInt(4, seq);

			int cnt = pstmt.executeUpdate();
			if(cnt !=0) {
				PrintWriter out = response.getWriter();
				out.println("<script> alert('게시물이 수정 되었습니다.'); location.href='Get_Board_List_Pro';  </script>");
				out.flush();
				return;
			}


		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCconn.close(pstmt, conn);
		}
	}
}
