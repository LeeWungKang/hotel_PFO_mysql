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
import javax.servlet.http.HttpSession;

import com.company.common.JDBCconn;

@WebServlet("/AdminCommentDelete")
public class AdminCommentDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("AdminCommentDelete --  관리자 댓글 삭제 ");
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
	
		HttpSession session=request.getSession();
		String name=(String) session.getAttribute("name"); 
		if(name==null) {response.sendRedirect("index.jsp");
		return;	} 
		 
		int ir_seq =Integer.parseInt(request.getParameter("ir_seq"));
		int ir_no =Integer.parseInt( request.getParameter("ir_no"));
		
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
				conn=JDBCconn.getConnection();
				String sql="delete from inquiryReply where ir_no=? and ir_seq=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, ir_no);
				pstmt.setInt(2, ir_seq);
				int cnt= pstmt.executeUpdate();
				
				PrintWriter out=response.getWriter();
				if(cnt!=0) {
					out.print("<script> alert('삭제 완료'); location.href='admin_GetInquiryDetail?num="+ir_seq+" ' </script>");
					out.flush();
				}
				
				
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}finally {	JDBCconn.close(pstmt, conn);	}
		}
		
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
