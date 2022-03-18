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

@WebServlet("/RsRoomInput")
public class RsRoomInput extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		System.out.println("/RsRoomInput");
		response.setContentType("text/html;charset=utf-8");
		
			HttpSession session= request.getSession();
			String name =(String) session.getAttribute("name");
			String id =(String) session.getAttribute("id");
			int roomseq =Integer.parseInt(request.getParameter("roomseq")); 
			
			System.out.println(roomseq+"예약하러가기 버튼1 ok");
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = JDBCconn.getConnection();
				String sql = "select * from room where roomseq=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, roomseq);
				rs = pstmt.executeQuery();
				
				System.out.println(roomseq+"예약하러가기 버튼2 ok");
				
				if (rs.next()) {
					roomVo roomvo = new roomVo();
					roomvo.setRoomseq(rs.getInt("roomseq"));
					roomvo.setRoomname(rs.getString("roomname"));
					roomvo.setRoomsize(rs.getInt("roomsize"));
					roomvo.setPrice(rs.getInt("price"));
					session.setAttribute("roomname",rs.getString("roomname"));
					request.setAttribute("roomvo", roomvo);

				}
				
				RequestDispatcher dis = request.getRequestDispatcher("index.jsp?filePath=./room/rservation");
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
