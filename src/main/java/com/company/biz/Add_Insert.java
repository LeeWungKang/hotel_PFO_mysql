package com.company.biz;

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
import javax.servlet.http.HttpSession;

import com.company.common.JDBCconn;

@WebServlet("/Add_Insert")
public class Add_Insert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/hrml;charset=utf-8");
		
		HttpSession session = request.getSession();
		String name =(String) session.getAttribute("name");
		if ( name == null) {response.sendRedirect("index.jsp"); return;}
		
		String title = request.getParameter("title");
		String nickname = request.getParameter("nickname");
		String content = request.getParameter("content");
	
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn=JDBCconn.getConnection();   //새로운 글추가 "글쓰기"버튼
			String sql="insert into HomeBoard(seq,title,nickname,content) values((select nvl(max(seq),0)+1 from HomeBoard),?,?,?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, nickname);
			pstmt.setString(3, content);
			
			int cn=pstmt.executeUpdate();
			if(cn != 0)	response.sendRedirect("Get_Board_List_Pro");

			
			
			
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}finally {	JDBCconn.close(pstmt, conn);  }
		}
}
