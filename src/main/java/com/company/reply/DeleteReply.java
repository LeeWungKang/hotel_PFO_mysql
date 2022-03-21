package com.company.reply;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.company.common.JDBCconn;

@WebServlet("/DeleteReply")
public class DeleteReply extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		request.setCharacterEncoding("utf-8");
		System.out.println("/DeleteReply");
		
		HttpSession session = request.getSession();
		String name =(String) session.getAttribute("name");	
		String boardseq = request.getParameter("boardseq");
		String nickname = request.getParameter("nickname");
		String replyseq = request.getParameter("replyseq");
	System.out.println(boardseq+"/"+nickname+"/"+replyseq);
	
	if(!name.equals(nickname)) response.sendRedirect("index.jsp");
	

	Connection conn = null;
	PreparedStatement pstmt = null;
	try {
		conn=JDBCconn.getConnection();
		String sql="delete from reply where replyseq=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, replyseq);
		
		/*
		 * PrintWriter out =response.getWriter();
		 * out.printf("<script> alert('댓글 삭제 완료') </script>"); out.close();
		 */
		 
		int cnt = pstmt.executeUpdate();
		System.out.println(cnt+"cnt 삭제");
		
		if(cnt != 0) 
		response.sendRedirect("Get_Board_Pro?num="+boardseq+"");
		return;
		
		
	} catch (ClassNotFoundException | SQLException e) {
		e.printStackTrace();    
	}finally {
		JDBCconn.close(pstmt, conn);
}}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	}
