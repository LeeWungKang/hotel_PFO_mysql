package com.company.inquiry;

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

@WebServlet("/Myinquiry_Delete")
public class Myinquiry_Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
	
		HttpSession session=request.getSession();
		
		String id =(String) session.getAttribute("id");
		String b_no= request.getParameter("b_no");   
		
		System.out.println(b_no+"///"+id+"");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn=JDBCconn.getConnection();
				String sql="delete from inquiry where b_no=? and b_userid=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, b_no);
				pstmt.setString(2, id);
				int cnt = pstmt.executeUpdate();
				
				System.out.println("cnt"+ cnt);
				PrintWriter out = response.getWriter();
				if(cnt !=0) {
					out.print("<script> alert('선택한 글을 삭제 하였습니다.'); location.href='My_Info_List';   </script>");
					out.flush();
					out.close();
					return;
			}
		
		
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}finally {	JDBCconn.close(pstmt, conn);	}
		}
}