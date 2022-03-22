package com.company.myPage;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.company.Vo.userVo;
import com.company.common.JDBCconn;

@WebServlet("/Mypage_Modify_Info")
public class Mypage_Modify_Info extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("내정보수정 /// mypage_Modify_Info");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		
		
		String id = (String) session.getAttribute("id");
		String name = (String) session.getAttribute("name");
		if (name == null || id == null) {
			out.print(
				"<script> alert('마이페이지를 이용하시려면 로그인 해주세요'); location.href='index.jsp?filePath=./login_check/Login_main'  </script>");
			out.close();
			return;
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = JDBCconn.getConnection();
			String sql="select * from Homeusers where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			System.out.println(id+"/userid");
			if(rs.next()) {
				userVo uservo = new userVo();
				uservo.setId(rs.getString(1));
				uservo.setPw(rs.getString(2));
				uservo.setName(rs.getString(3));
				uservo.setPhone(rs.getString(4));
				uservo.setJoindate(rs.getDate(5));
				uservo.setEmail(rs.getString(6));
				uservo.setRole(rs.getString(7));
				request.setAttribute("uservo", uservo);
			}
			
			System.out.println(name);
			/* response.sendRedirect("index.jsp?filePath=./user_admin/getMy_modifyInfo"); */
			 RequestDispatcher dis = request.getRequestDispatcher("index.jsp?filePath=./user_admin/getMy_modifyInfo");
			 dis.forward(request, response);
			 

			
			
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCconn.close(rs, pstmt, conn);
		}
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
