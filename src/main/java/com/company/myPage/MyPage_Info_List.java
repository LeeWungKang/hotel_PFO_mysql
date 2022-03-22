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

import com.company.Vo.BoardVo;
import com.company.Vo.reservationVo;
import com.company.Vo.userVo;
import com.company.common.JDBCconn;

@WebServlet("/MyPage_Info_List")
public class MyPage_Info_List extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();

		String id = (String) session.getAttribute("id"); // 메뉴클릭시 넘겨받은 매개변수(로그인 한 유저 정보)
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
					+ "(select * from HomeBoard where userid=? order by seq desc) A) where rnum between ? and ?";
			pstmt = conn.prepareStatement(sql);
			System.out.println(sql);

			// 페이지에 담기는 게시판이 로그인id와 일치하는 데이터만 페이징처리해서 뿌려준다.
			pstmt.setString(1, id);
			pstmt.setInt(2, page * 10 - 9);
			pstmt.setInt(3, page * 10);

			rs = pstmt.executeQuery();
			ArrayList<BoardVo> boardList = new ArrayList<BoardVo>();
			while (rs.next()) {
				BoardVo vo = new BoardVo();
				vo.setSeq(rs.getInt("seq"));
				vo.setNickname(rs.getString("nickname"));
				vo.setContent(rs.getString("content"));
				vo.setTitle(rs.getString("title"));
				vo.setRegdate(rs.getDate("regdate"));
				vo.setCnt(rs.getInt("cnt"));
				vo.setUserid(rs.getString("userid"));
				boardList.add(vo);
			}
			pstmt.close();
			rs.close();
// 재활용하기 위해 사용한자원을 잠시 닫아준다. totalCount 값은 따로 정해야 다시 정의해야 됨

//특정회원의 룸을 찾는다. 예약테이블의 유저id == 계정테이블에 id가 일치하는 조건에, 예약번호와 == 룸번호가 일치하는 방만 최신순으로.
			sql = "select rs_roomname,R.* from reservation R " 
					+ "left outer join HomeUsers U on "
					+ "R.rs_userid = U.id " 
					+ "left outer join room RM on " 
					+ "R.rs_roomseq = RM.roomseq "
					+ "where rs_userid = ? " + "order by rs_no desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id); // 일치하는 아이디가 존재한다면, '예약 테이블' 리스트에 담아서 뿌려주자.

			rs = pstmt.executeQuery();

			ArrayList<reservationVo> rsvoList = new ArrayList<reservationVo>();
			if (rs.next()) {
				reservationVo rsvo = new reservationVo();
				rsvo.setRs_no(rs.getInt("rs_no"));
				rsvo.setRs_date(rs.getString("rs_date"));
				rsvo.setRs_checkin(rs.getString("rs_date"));
				rsvo.setRs_checkout(rs.getString("rs_checkout"));
				rsvo.setRs_people(rs.getInt("rs_people"));
				rsvo.setRs_roomname(rs.getString("rs_roomname"));
				rsvo.setRs_roomseq(rs.getInt("rs_roomseq"));
				rsvo.setRs_rsuserid(rs.getString("rs_userid"));
				rsvo.setRs_price(rs.getInt("rs_price"));
				rsvoList.add(rsvo);
			}
			pstmt.close();
			rs.close();
			//특정 사용자가 작성한 총 게시물 갯수
			sql = "select count(*) from HomeBoard where userid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			int totalCount = 0;
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
			pstmt.close();
			rs.close();
			
			sql="select * from HomeUsers where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				userVo uservo = new userVo();
				uservo.setId(rs.getString("id"));
				uservo.setPw(rs.getString("pw"));
				uservo.setName(rs.getString("name"));
				uservo.setPhone(rs.getString("phone"));
				uservo.setJoindate(rs.getDate("joindate"));
				uservo.setEmail(rs.getString("email"));
				request.setAttribute("uservo", uservo);
			}
			
			System.out.println(totalCount);

			request.setAttribute("boardList", boardList);
			request.setAttribute("rsvoList", rsvoList);
			request.setAttribute("totalRows", totalCount);

			RequestDispatcher dis = request.getRequestDispatcher("index.jsp?filePath=./user_admin/getMypage");
			dis.forward(request, response);

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCconn.close(rs, pstmt, conn);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
