package com.company.userC;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.company.common.JDBCconn;

@WebServlet("/LoginPro")
public class LoginPro extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/LoginPro");
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String cookeyId = request.getParameter("cookeyId");  //쿠키에저장될 체크박스 벨류
	
	System.out.println(cookeyId+"cookeyId");
	Cookie cookie = new Cookie("cookid", id);
	
	if(cookeyId != null) {    //체크박스 체크되어있을떄.
		response.addCookie(cookie);
	} else {
		cookie.setMaxAge(0);    //쿠키유효시간설정. (-1:시간제한없이 유지. 0:유효시간0초. 180:3분..)
		response.addCookie(cookie);
	}
	
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try {
		conn=JDBCconn.getConnection();
		String sql="select * from HomeUsers where id=? and pw=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		
		rs=pstmt.executeQuery();
		HttpSession session=request.getSession();
		if(rs.next()) {
			System.out.println("로그인 성공");
			session.setAttribute("id",rs.getString("id"));
			session.setAttribute("name",rs.getString("name"));
			session.setAttribute("role",rs.getString("role"));
			response.sendRedirect("./index.jsp");
			return;
		}else {
			System.out.println("로그인 실패");
			session.setAttribute("errMsg", "로그인 정보가 올바르지 않습니다.");
			response.sendRedirect("index.jsp?filePath=./login_check/Login_main");
		}
		
		
		
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();    
		}finally {
			JDBCconn.close(rs, pstmt, conn);
	}}}