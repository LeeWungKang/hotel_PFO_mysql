package com.company.room;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
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

import com.company.common.JDBCconn;

@WebServlet("/Reservation_Ok")
public class Reservation_Ok extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/Reservation_Ok");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
//최종 예약 insert 페이지.
		//rs_no  자동생성 
	    String rs_date =request.getParameter("rs_date");     //"20220317"  날자입력이 안댐  
	    String rs_checkin = request.getParameter("rs_checkin");
	    String rs_checkout = request.getParameter("rs_checkout");
	    int rs_people =Integer.parseInt( request.getParameter("rs_people"));
	    String rs_roomname = request.getParameter("rs_roomname");
	    int rs_roomseq =Integer.parseInt( request.getParameter("rs_roomseq"));
	    String rs_userid = request.getParameter("rs_userid");
	    int rs_price =Integer.parseInt( request.getParameter("rs_price"));
		
		System.out.println(rs_date+"/"+rs_price);
		
		HttpSession session = request.getSession();
		String name =(String) session.getAttribute("name");
		String id =(String) session.getAttribute("id");
		String role =(String) session.getAttribute("role");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = JDBCconn.getConnection();
			String sql = "insert into reservation (rs_no,rs_date,rs_checkin,rs_checkout,rs_people,rs_roomname,rs_roomseq,rs_userid,rs_price) values (seq_reservation.nextval,?,?,?,?,?,?,?,?)";   //객실이름이랑 날자가 동일한 데이타가 있는지 검사해야댐.
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,rs_date);
			pstmt.setString(2, rs_checkin);
			pstmt.setString(3, rs_checkout);
			pstmt.setInt(4, rs_people);
			pstmt.setString(5, rs_roomname);
			pstmt.setInt(6, rs_roomseq);
			pstmt.setString(7, rs_userid);
			pstmt.setInt(8, rs_price);
			int cnt =pstmt.executeUpdate();
			
			PrintWriter out = response.getWriter();
			String msg = "1";
			if(cnt != 0) {
			out.println("<script> alert('예약이 정상적으로 등록 되었습니다.'); location.href='index.jsp';  </script>");
			out.flush();
			
			}else {
			System.out.println(" 예약이 실패 하였습니다. ");
			session.setAttribute("msg",  " 실패 메시지. ");
			out.print("<script> alert('예약이 실패 하였습니다.'); window.history.back();</script>");
			out.close();
			return;
			}
			
			 RequestDispatcher dis = request.getRequestDispatcher("index.jsp");
			 dis.forward(request, response);
			 
	
		
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();    
		}finally {
			JDBCconn.close(rs, pstmt, conn);
	}}
	}
