package com.company.userCheck;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.company.common.JDBCconn;
@WebServlet("/Insert_Signup")
public class Insert_Signup extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Insert_Signup");
	
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw1");
	String name = request.getParameter("name");
	String phone_value = request.getParameter("phone_value");
	String tel_1 = request.getParameter("tel_1");
	String tel_2 = request.getParameter("tel_2");
	String email = request.getParameter("email");
	String email02 = request.getParameter("email02");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	try {
		conn=JDBCconn.getConnection();

		String sql="insert into HomeUsers(id,pw,name,phone,email) values(?,?,?,?,?)";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		pstmt.setString(3, name);
		pstmt.setString(4, phone_value+"-"+tel_1+"-"+tel_2);
		pstmt.setString(5, email +"@"+ email02);
		
		
		int cnt = pstmt.executeUpdate();
		PrintWriter out = response.getWriter();
		out.print("<script> alert('회원가입 완료 했습니다.먼저 로그인 해주세요.') </script>");    // 얼럿 안먹힘.
		response.sendRedirect("index.jsp");
		out.close();
		
		
	} catch (ClassNotFoundException | SQLException e) {
		e.printStackTrace();    
	}finally {
		JDBCconn.close( pstmt, conn);
}}}