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

@WebServlet("/Mypage_Delete_Check")
public class Mypage_Delete_Check extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
	
		HttpSession session=request.getSession();
		
		String name=(String) session.getAttribute("name"); 
		if(name==null) {response.sendRedirect("index.jsp");
		return;	} 
		 
		String chcBox[]= request.getParameterValues("chcBox");   //체크박스 배열로 받아와서 클릭한 벨류만 값 삭제
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn=JDBCconn.getConnection();
			
			int cnt=0;
			for(int i=0; i<chcBox.length; i++) {
				String sql="delete from HomeBoard where seq=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1,Integer.parseInt(chcBox[i]));
				pstmt.executeUpdate();
				cnt++;
				
				PrintWriter out = response.getWriter();
				if(cnt !=0) {
					out.print( 1 +  "");
					out.flush();
					return;
				}else {
					cnt = 0 ;
					out.close();
				}
			}
		
		
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}finally {	JDBCconn.close(pstmt, conn);	}
		}
}
