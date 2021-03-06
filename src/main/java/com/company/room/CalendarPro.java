package com.company.room;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.company.Vo.roomVo;
import com.company.common.JDBCconn;

@WebServlet("/CalendarPro")
public class CalendarPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("/CalendarPro");
		response.setContentType("text/html;charset=utf-8");
		HttpSession session = request.getSession();
		String name =(String) session.getAttribute("name");
		if(name == null ) response.sendRedirect("index.jsp");
		
//같은 날짜에 예약되어 있는 객실이 있다면 다시 날짜 선택하도록 유도하는 서블릿 페이지.
//예약이 가능하다면 다시 예약페이지로 보내주면서 선택한 날짜 뿌려주기.
		// 달력 클릭해서 받아온 날짜 객체.
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		System.out.println(year + month + day + "/1");

		String se_roomname = request.getParameter("roomname"); // 선택한 방
		System.out.println(se_roomname);

		String date = ""; // 달력에서 넘어온 날짜 객체가 yyyy/m/d 이런 형태라 재사용이 불가해서 변환시킴.
		if (month.length() <= 1 && day.length() <= 1) {
			month = "0" + month;
			day = "0" + day;
			date += year;
			date += month;
			date += day;
		} else if (month.length() == 2 && day.length() <= 1) {
			day = "0" + day;
			date += year;
			date += month;
			date += day;
		} else if (month.length() <= 1 && day.length() == 2) {
			month = "0" + month;
			date += year;
			date += month;
			date += day;
		} else {
			date += year;
			date += month;
			date += day;
		}
		System.out.println(year +"ㅡ년"+ month +"ㅡ월"+ day+"ㅡ일");

		PrintWriter out = response.getWriter();
					System.out.println(date + "==date");
		SimpleDateFormat fomatdate= new SimpleDateFormat("yyyyMMdd");   //22020330
		SimpleDateFormat newssf = new SimpleDateFormat("yyyy-MM-dd");    //변환> 2202-03-30
				try {
					Date newForm = fomatdate.parse(date);
					String Fdate = newssf.format(newForm);   //포맷처리한 날짜객체로, 현재 데이타베이스에 조회 떄림
					
					System.out.println(Fdate + "==Fdate");
				
					
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
			conn = JDBCconn.getConnection();
			String sql = "select * from reservation where rs_checkin=? and rs_roomname=?"; // 객실이름이랑 날자가 동일한 데이타가 있는지
																						// 검사해야댐.
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, Fdate); // 달력클릭으로 넘어온 날짜객체
			pstmt.setString(2, se_roomname); // 최초에 선택한 방객체
			rs = pstmt.executeQuery();

			// 로그인이랑 반대개념,로그인=데이타가존재해야지 접속시킴. || 예약은 데이타가 있으면 중복처리

			Date nowDate = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("YYYYMMdd");
			String nowDateF = sf.format(nowDate);
			String date1 = date;
						System.out.println("클릭한 시간" + date1 + " <----/----> 현재시간 : " + nowDateF);
			if (Integer.parseInt(date1) < Integer.parseInt(nowDateF)) {
						System.out.println("==========현재날짜보다 이전 날은 예약 불가");
				out.print(    // alert 창 안에서 줄바꿈  jsp에서는  " \\n "
			" <script> alert('지나간 시간은 돌아갈 수 없습니다.  \\n  (오늘 날짜 이후로 예약해주세요 ^^)');  window.history.back();  </script> ");
				out.close();
				return;
			}
			
			// 동일한 데이타가 존재하면 중복처리
			if (rs.next()) {
						System.out.println("해당 룸은 만석입니다, 현재 날짜 예약불가 (X)");
				out.print("<script> alert('중복된 날짜 입니다. 다른날짜를 선택해 주세요.'); window.history.back();</script>");
				session.setAttribute("overlap", Fdate+","+se_roomname);
				out.close();
				return;

			} else {
						System.out.println("중복된 예약방이 없음, 예약가능 (O)");
				request.setAttribute("se_roomname", se_roomname);
				request.setAttribute("date", date);
				session.setAttribute("conMsg", " 예약가능 (O)");
			}

			pstmt.close();
			rs.close();

			sql = "select * from room where roomname=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, se_roomname);
			rs = pstmt.executeQuery();

			System.out.println(se_roomname + "---------사용자가 선택한 방 이름");
			if (rs.next()) {
				roomVo roomvo = new roomVo();
				roomvo.setRoomseq(rs.getInt("roomseq"));
				roomvo.setRoomname(rs.getString("roomname"));
				roomvo.setRoomsize(rs.getInt("roomsize"));
				roomvo.setPrice(rs.getInt("price"));
				request.setAttribute("roomvo", roomvo);
			}

			System.out.println(date + "-------예약2페이지로 넘어가는 date 객체");
			RequestDispatcher dis = request.getRequestDispatcher("index.jsp?filePath=./room/rservation2");
			dis.forward(request, response);

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} catch (ParseException e1) {
			e1.printStackTrace();
		} finally {
			ResultSet rs = null;
			PreparedStatement pstmt = null;
			Connection conn = null;
			JDBCconn.close(rs, pstmt, conn);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
