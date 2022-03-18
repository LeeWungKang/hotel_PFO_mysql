package com.company.room;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.company.Vo.roomVo;
import com.company.common.JDBCconn;

@WebServlet("/RoomInfo")
public class RoomInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	System.out.println("/RoomInfo");
	response.setContentType("text/html;charset=utf-8");
// 헤더-네비영역에서, Room클릭시 처음으로 보여지는 화면인데, '스탠다드룸'를 첫 페이지로, 스탠다드 디비 객체담아서 쏴서 먼저 보여줌.
	
		HttpSession session= request.getSession();
		String name =(String) session.getAttribute("name");
		String id =(String) session.getAttribute("id");
		int roomseq =Integer.parseInt(request.getParameter("roomseq")); 
		
		System.out.println(roomseq+"");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = JDBCconn.getConnection();
			String sql = "select * from room where roomseq=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, roomseq);
			rs = pstmt.executeQuery();
			
			System.out.println(roomseq+"");
			while (rs.next()) {
				roomVo roomvo = new roomVo();
				roomvo.setRoomseq(rs.getInt("roomseq"));
				roomvo.setRoomname(rs.getString("roomname"));
				roomvo.setRoomsize(rs.getInt("roomsize"));
				roomvo.setPrice(rs.getInt("price"));
				request.setAttribute("roomvo", roomvo);
			}
//룸seq번호가, jsp페이지의 끝번호랑 일치하고, 그걸 매개로 전달하여 페이지 이동시키면서 각각의seq 객체만 쏴주기.
			RequestDispatcher dis = request.getRequestDispatcher("index.jsp?filePath=./room/room"+roomseq);
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
