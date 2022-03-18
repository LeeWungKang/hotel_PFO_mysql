package com.company.reply;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
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

@WebServlet("/ReplyPro")
public class ReplyPro extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	request.setCharacterEncoding("utf-8");
	
	String comments= request.getParameter("comments");
	int seq=Integer.parseInt(request.getParameter("seq"));
	String nickname= request.getParameter("nickname");
	
	
	HttpSession session=request.getSession();
	String name =(String) session.getAttribute("name");
	PrintWriter out = response.getWriter();
	if(name==null) {
			out.print("<script> alert('댓글을 이용하시려면 로그인 해주세요'); location.href='index.jsp?filePath=./login_check/Login_main'  </script>");
			out.close();
			return;
	}
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try {
		conn=JDBCconn.getConnection();
		String sql="insert into reply (boardseq,replyseq,nickname,comments) values (?,(select nvl(max(replyseq),0)+1 from reply),?,?)";
		pstmt=conn.prepareStatement(sql);
		
		pstmt.setInt(1, seq);
		pstmt.setString(2, nickname);
		pstmt.setString(3, comments);
		
		int cnt=pstmt.executeUpdate();
		if(cnt != 0)response.sendRedirect("Get_Board_Pro?num="+seq);
	//jsp로 바로 전송하면 boardVo값이 널값처리되버려서, 보드리스트가 들어있는 서블릿으로 조건에 맞는 seq값을 함께 요청하여 댓글을 
	//댓글을 입력하고자하는 페이지에 출력하게 한다
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();    
		}finally {
			JDBCconn.close(rs, pstmt, conn);
	}}
}