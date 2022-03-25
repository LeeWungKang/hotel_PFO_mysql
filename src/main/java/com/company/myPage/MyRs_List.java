package com.company.myPage;

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

import com.company.Vo.reservationVo;
import com.company.common.JDBCconn;

@WebServlet("/MyRs_List")
public class MyRs_List extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/MyRs_List----나의 예약정보 조회 ");
	
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

		int page;
		if (request.getParameter("page") == null)
			page = 1; 		// 페이지는 기본값 1로 설정
		else
			page = Integer.parseInt(request.getParameter("page"));

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = JDBCconn.getConnection();
			String sql = "select * from (select rownum as rnum,A.* from "
					+ "(select rs_no,to_char(rs_date,'YYYY-MM-DD HH24:MI:SS') as rs_date,"
					+ "rs_checkin,rs_checkout,rs_people,rs_roomname,rs_roomseq,rs_userid,rs_price "
					+ "from reservation where rs_userid=? "
					+ "order by rs_no desc) A) where rnum between ? and ?";
			pstmt = conn.prepareStatement(sql);

			// 페이지에 담기는 예약정보가 세션 id와 일치하는 데이터만 페이징처리해서 뿌려준다.
			pstmt.setString(1, id);
			pstmt.setInt(2, page * 5- 4);
			pstmt.setInt(3, page * 5);
			//예약테이블이 존재하면 담아준다.
			rs = pstmt.executeQuery();
			ArrayList<reservationVo> rsList = new ArrayList<reservationVo>();
			while (rs.next()) {
				reservationVo rsvo = new reservationVo();
				rsvo.setRs_no(rs.getInt("rs_no"));
				rsvo.setRs_date(rs.getString("rs_date"));
				rsvo.setRs_checkin(rs.getString("rs_checkin"));
				rsvo.setRs_checkout(rs.getString("rs_checkout"));
				rsvo.setRs_people(rs.getInt("rs_people"));
				rsvo.setRs_roomname(rs.getString("rs_roomname"));
				rsvo.setRs_roomseq(rs.getInt("rs_roomseq"));
				rsvo.setRs_userid(rs.getString("rs_userid"));
				rsvo.setRs_price(rs.getInt("rs_price"));
				rsList.add(rsvo);
			}
			pstmt.close();
			rs.close();
// 재활용하기 위해 사용한자원을 잠시 닫아준다. totalCount 값은 따로 정해야 다시 정의해야 됨

			//특정 사용자가 작성한 총 게시물 갯수
			sql = "select count(*) from reservation where rs_userid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			int totalCount = 0;
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
						
			System.out.println(totalCount+"---예약테이블 갯수");

			request.setAttribute("rsList", rsList);
			request.setAttribute("totalCount", totalCount);

			RequestDispatcher dis = request.getRequestDispatcher("index.jsp?filePath=./user/getMy_ReservationList");
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
