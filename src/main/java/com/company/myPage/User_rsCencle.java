package com.company.myPage;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.company.common.JDBCconn;

@WebServlet("/User_rsCencle")
public class User_rsCencle extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/User_rsCencle");
		response.setContentType("text/html;charset=utf-8");
	
		String state = request.getParameter("state");
		String delNo = request.getParameter("delNo");       //클릭한 예약번호
		String delDate = request.getParameter("delDate");   // 예약한 체크인 날짜
	
		
		PrintWriter out = response.getWriter();
		//날짜데이터 생성
		Date nowDate = new Date();
		System.out.println(nowDate);
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String ndate = sf.format(nowDate);                     //오늘 날짜 
	
					System.out.println("예약번호="+delNo+"/체크인=="+delDate+"/ 오늘날자=="+ndate+"상태state==="+state );
		

					//다시 데이트객체로 변환한 두 날짜를 계산하고, 그 리턴값으로 long type초기화
		Date delDate2 = null;
		Date nDate2 = null;
	//   String Type을 Date Type으로 캐스팅하면서 생기는 예외로 인해 여기서 예외처리
		try {    
			delDate2 = sf.parse(delDate);
			nDate2 = sf.parse(ndate);
		long diffdate = delDate2.getTime() - nDate2.getTime();     // '체크인' ( 빼기 ) '오늘'
		long diffday =  diffdate / (24*60*60*1000); 

		
		diffday = Math.abs(diffday);
					System.out.println("두 날짜의 날짜 차이 : " + diffday );   
		// 날짜차이를 day로 최종 받음.
		
		
		if(diffday < 3) {     // 날짜차이가 3일 미만이면 취소 불가능 .
			out.println("<script> alert('이 예약은 취소가 불가능합니다.');  history.back();       </script>  ");
			out.flush();
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
			conn = JDBCconn.getConnection();
			// 수정한 날짜 변경 ?
			
			/*
			 * String sql= "update reservation set rs_state=? where rs_no=?";
			 * pstmt=conn.prepareStatement(sql); pstmt.setString(1, state); //예약취소로 변경.
			 * pstmt.setString(2, delNo);
			 */
			
			 String sql = "delete from reservation where rs_no=?"; 
			 pstmt =	 conn.prepareStatement(sql); 
			 pstmt.setString(1, delNo);
			 
			int cnt = pstmt.executeUpdate();
			if(cnt !=0) {
				out.println("<script> alert('해당 예약이 취소 되었습니다.'); location.href='MyRs_List';  </script>");
				out.flush();
				return;
			}


			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} catch (ParseException e1) {
			e1.printStackTrace();
		} finally {
			PreparedStatement pstmt = null;
			Connection conn = null;
			JDBCconn.close(pstmt, conn);
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
