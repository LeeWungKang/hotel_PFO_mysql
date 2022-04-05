package com.company.admin;

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

@WebServlet("/AdminCommentWrite")
public class AdminCommentWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
		
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	System.out.println("AdminCommentWrite --- 고객의소리 답변추가");
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	
	
		int ir_seq =Integer.parseInt(request.getParameter("ir_seq"));
		String ir_comments = request.getParameter("ir_comments");
		
		HttpSession session=request.getSession();
		String name =(String) session.getAttribute("name");
		PrintWriter out = response.getWriter();
		if(name==null) {
				out.print("<script> alert('로그인 해주세요'); location.href='index.jsp?filePath=./login_check/Login_main'  </script>");
				out.close();
				return;
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn=JDBCconn.getConnection();
			String sql="insert into inquiryReply (ir_seq, ir_no, ir_comments) values (?,  (select nvl(max(ir_no),0)+1 from inquiryReply) ,?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, ir_seq);
			pstmt.setString(2, ir_comments);
			
			int cnt=pstmt.executeUpdate();
			if(cnt != 0)
				session.setAttribute("inquiry", "문의하신글의 답변이 달렸습니다.");
				response.sendRedirect("admin_GetInquiryDetail?num="+ir_seq);
			//num값에 댓글데이타를 담아서, 다시 첫화면 list쏴주는 서블릿으로 num으로 보내준다.
			
			
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();    
			}finally {
				JDBCconn.close(rs, pstmt, conn);
		}
	}
}