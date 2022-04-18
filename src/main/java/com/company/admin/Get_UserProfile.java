package com.company.admin;

import java.io.IOException;
import java.io.PrintWriter;
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

import com.company.Vo.BoardVo;
import com.company.Vo.inquiryVo;
import com.company.Vo.reservationVo;
import com.company.Vo.userVo;
import com.company.common.JDBCconn;

@WebServlet("/Get_UserProfile")
public class Get_UserProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			System.out.println("/Get_UserProfile");
			
			String num= request.getParameter("num");
			
					System.out.println(num +"-??--"  );
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			String id = (String) session.getAttribute("id"); // 메뉴클릭시 넘겨받은 매개변수(로그인 한 유저 정보)
			String role = (String) session.getAttribute("role");
			if (role == null && !role.equals("admin")) {
				out.print(
						"<script> alert('잘못된 접근입니다.'); location.href='index.jsp?filePath=./login_check/Login_main'  </script>");
				out.close();
				return;
			}
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = JDBCconn.getConnection();
				String sql = "select * from HomeUsers where id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, num);
				rs = pstmt.executeQuery();

				if (rs.next()) {
					userVo uservo = new userVo();
					uservo.setId(rs.getString("id"));
					uservo.setPw(rs.getString("pw"));
					uservo.setName(rs.getString("name"));
					uservo.setPhone(rs.getString("phone"));
					uservo.setJoindate(rs.getDate("joindate"));
					uservo.setEmail(rs.getString("email"));
					uservo.setGrade(rs.getString("grade"));
					uservo.setRole(rs.getString("role"));
					request.setAttribute("uservo", uservo);
				}
				pstmt.close();
				rs.close();
				// 사용자의 예약 갯수 
				sql = "select count(*) from reservation where rs_userid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, num);
				rs = pstmt.executeQuery();

				int totalCount = 0;
				if (rs.next()) {
					totalCount = rs.getInt(1);
				}
				System.out.println(totalCount+"= 총 게시물 갯수");
				
				pstmt.close();
				rs.close();
				sql="select * from reservation where rs_userid=? order by rs_no desc limit 0,5";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, num);
				rs = pstmt.executeQuery();
				
				ArrayList<reservationVo> rsvoList = new ArrayList<reservationVo>();     //고객의소리 리스트 뽑기
				while(rs.next()) {
					reservationVo rsvo= new reservationVo();
					rsvo.setRs_no(rs.getInt("rs_no"));
					rsvo.setRs_date(rs.getString("rs_date"));
					rsvo.setRs_checkin(rs.getString("rs_checkin"));
					rsvo.setRs_checkout(rs.getString("rs_checkout"));
					rsvo.setRs_people(rs.getInt("rs_people"));
					rsvo.setRs_roomname(rs.getString("rs_roomname"));
					rsvo.setRs_roomseq(rs.getInt("rs_roomseq"));
					rsvo.setRs_userid(rs.getString("rs_userid"));
					rsvo.setRs_price(rs.getInt("rs_price"));
					rsvo.setRs_state(rs.getString("rs_state"));
					rsvoList.add(rsvo);
				}
				
				request.setAttribute("totalRows", totalCount);
				request.setAttribute("rsvoList", rsvoList);
				RequestDispatcher dis = request.getRequestDispatcher("index.jsp?filePath=./admin/getUser");
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
