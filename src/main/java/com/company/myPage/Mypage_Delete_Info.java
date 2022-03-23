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

@WebServlet("/Mypage_Delete_Info")
public class Mypage_Delete_Info extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/Mypage_Delete_Info --- 내정보 삭제");
		
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		
		HttpSession session=request.getSession();
		String name=(String) session.getAttribute("name"); 
		if(name==null) {response.sendRedirect("index.jsp");
		return;	} 
		 
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
				conn=JDBCconn.getConnection();
				String sql="delete from HomeUsers where id=? and pw=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, pw);
				int cnt=pstmt.executeUpdate();
				
				PrintWriter out = response.getWriter();
				if(cnt !=0) {           //회원정보가 일치하면 회원탈퇴 완료 (o)
					session.invalidate();   //세션 파괴  부모창(팝업)닫고 원하는 경로로 이동
					out.println("<script> alert('입력 정보와 일치한 \\n 회원정보가 삭제 되었습니다.');opener.document.location.href='index.jsp';\r\n"
							+ "  self.close(); </script>");
					out.flush();
					return;
				}else {                //회원정보가 불일치 할때 다시 돌아가기.
					session.setAttribute("deleteErrMsg", "회원 정보가 일치하지 않습니다.");
					out.println("<script> alert('입력정보가 올바르지 않습니다.');opener.document.location.reload(); \r\n"
							+ "history.back(); </script>");
					out.close();
				}
		
		
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}finally {	JDBCconn.close(pstmt, conn);	}
		}
}
	
