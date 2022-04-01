package com.company.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Arrays;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.company.common.JDBCconn;

@WebServlet("/adminDeleteChecked")
public class adminDeleteChecked extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
	
		String chcBox[]= request.getParameterValues("chcBox");   //체크박스 배열로 받아와서 클릭한 벨류만 값 삭제
		
						System.out.println(Arrays.toString(chcBox)+"toString" );
						System.out.println(Arrays.deepToString(chcBox) + "deep" );
						System.out.println(chcBox+" 받아온 값. ");
						
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn=JDBCconn.getConnection();
			
			int cnt=0;
			for(int i=0; i<chcBox.length; i++) {
				String sql="delete from HomeUsers where id=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1,(chcBox[i]));
				pstmt.executeUpdate();
				cnt++;
				
				PrintWriter out = response.getWriter();
				if(cnt != 0) {
					out.print( "<script> alert('회원 삭제 완료 '); location.href='Admin_UserInfoPro';  </script> "  );
					out.flush();
					
					/*
					 * RequestDispatcher dis = request.getRequestDispatcher("Admin_UserInfoPro");
					 * dis.forward(request, response);
					 */
					
					/*
					 * response.sendRedirect("Admin_UserInfoPro");
					 */
					return;
				}
			}
		
		
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}finally {	JDBCconn.close(pstmt, conn);	}
		}
	}
