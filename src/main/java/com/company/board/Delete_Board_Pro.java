package com.company.board;

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

@WebServlet("/Delete_Board_Pro")
public class Delete_Board_Pro extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		HttpSession session=request.getSession();
		String name=(String) session.getAttribute("name");   //이페이지에서 시작하는 사람도 있어서 세션 구현.
		if(name==null) {response.sendRedirect("index.jsp");
		return;	} //get으로 뿌려줄떄는, 로그인세션 
		
		int num=Integer.parseInt(request.getParameter("num")); 
		
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn=JDBCconn.getConnection();
			String sql="delete from HomeBoard where seq=? ";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);

			int cnt = pstmt.executeUpdate();
			if(cnt !=0) {
				PrintWriter out = response.getWriter();
				out.println("<script> alert('선택한 게시물이 삭제 되었습니다.'); location.href='Get_Board_List_Pro';  </script>");
				out.flush();
				return;
			}
			
			
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();    
			}finally {
				JDBCconn.close(pstmt, conn);
		}}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
