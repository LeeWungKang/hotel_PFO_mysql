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

import com.company.Vo.reservationVo;
import com.company.Vo.userVo;
import com.company.common.JDBCconn;

@WebServlet("/Admin_reservationPro")
public class Admin_reservationPro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/Admin_reservationPro  //  관리자- 예약데이타 호출");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
			int page; 
		if(request.getParameter("page")== null)
			page =1;
		else
			page= Integer.parseInt(request.getParameter("page"));
		
		HttpSession session=request.getSession();
		 PrintWriter out = response.getWriter();

		String name=(String)session.getAttribute("name");
		String role = (String)session.getAttribute("role");
		if(name==null && !role.equals("admin")) {
			out.print("<script> alert('관리페이지를 이용하시려면 관리자로 로그인 해주세요'); location.href='index.jsp?filePath=./login_check/Login_main'  </script>");
			out.close();
			return;
		}
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = JDBCconn.getConnection();
			String sql = "select * from reservation order by rs_no desc limit ?,?";
			pstmt = conn.prepareStatement(sql);
			
			//각 페이지에 담기는 rownum값을 정의해준다. 
			pstmt.setInt(1, page*10-9);
			pstmt.setInt(2, page*10);
			
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
				rsvo.setRs_state(rs.getString("rs_state"));
				
				rsList.add(rsvo);
			}
			pstmt.close();
			rs.close();
			sql="select count(*) from reservation";   //총 갯수 = 토탈카운트 
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			int totalCount=0;
			if(rs.next()) {
				totalCount = rs.getInt(1);
			}
			
			pstmt.close();
			rs.close();
			sql="select count(*) as ACount, sum(rs_price) as APrice from reservation where rs_roomname ='스탠다드'";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			int ACount = 0;
			int APrice = 0;
			if(rs.next()) {
				ACount = rs.getInt("ACount");
				APrice = rs.getInt("APrice");
			}
			pstmt.close();
			rs.close();
			sql="select count(*) as BCount,sum(rs_price) as BPrice from reservation where rs_roomname ='디럭스'";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			int BCount = 0;
			int BPrice = 0;
			if(rs.next()) {
				BCount = rs.getInt(1);
				BPrice = rs.getInt(2);
			}
			pstmt.close();
			rs.close();
			sql="select count(*) as CCount,sum(rs_price) as CPrice from reservation where rs_roomname ='스위트'";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			int CCount = 0;
			int CPrice = 0;
			if(rs.next()) {
				CCount = rs.getInt(1);
				CPrice = rs.getInt(2);
			}
			pstmt.close();
			rs.close();
			sql="select count(*) as DCount,sum(rs_Price) as DPrice from reservation where rs_roomname ='로얄'";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			int DCount = 0;
			int DPrice = 0;
			if(rs.next()) {
				DCount = rs.getInt(1);
				DPrice = rs.getInt(2);
			}
			pstmt.close();
			rs.close();
			
			
			//가장 잘 나가는방 sql 
			sql="select max(mc) as maxCount,"
					+ " rs_roomname as maxRoom "
					+ " from (select rs_roomname, count(*) as mc from "
					+ " reservation group by rs_roomname) as maxRoom";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			int maxCount = 0;
			String maxRoom = "";
			if(rs.next()) {
				maxCount = rs.getInt(1);
				maxRoom = rs.getString(2);
			}
			pstmt.close();
			rs.close();
			
			
			
			// 월별 매출 sql 반복문으로~
			int[] month = new int[13];
			for( int j=0;    j<=12;    j++ ) {
				sql="SELECT date_format(rs_date, '%m'),"
						+ " sum(rs_price) as APrice"
						+ " FROM reservation"
						+ " where  date_format(rs_date, '%m') ="+j
						+ " GROUP BY  date_format(rs_date, '%m') order by 1";
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				 if(rs.next()) { 
					 
					 month[j]= rs.getInt("APrice"); 
					 
					 System.out.println(rs.getInt(1) + "월-  rs.next");
					 
					 System.out.println(month[1] + "시작"); 
					 System.out.println(month[2]);
					 System.out.println(month[3]);
					 System.out.println(month[4]);
					 System.out.println(month[5]+">> -----------");
					 System.out.println(month[6]);
					 System.out.println(month[7]);
					 System.out.println(month[8]);
					 System.out.println(month[9]);
					 System.out.println(month[10]+" >> 10월시작-----------");
					 System.out.println(month[11]);
					 System.out.println(month[12]);
				 }
				
				pstmt.close();
				rs.close();	
			}
			System.out.println(month +" >>>>반복벗어난 month");
			
			
			
			request.setAttribute("maxCount", maxCount);
			request.setAttribute("maxRoom", maxRoom);
			
			request.setAttribute("month", month);
			
			request.setAttribute("ACount", ACount);
			request.setAttribute("APrice", APrice);
			
			request.setAttribute("BCount", BCount);
			request.setAttribute("BPrice", BPrice);
			
			request.setAttribute("CCount", CCount);
			request.setAttribute("CPrice", CPrice);

			request.setAttribute("DCount", DCount);
			request.setAttribute("DPrice", DPrice);
			
			request.setAttribute("rsList", rsList);
			request.setAttribute("totalRows", totalCount);
			
			RequestDispatcher dis = request.getRequestDispatcher("index.jsp?filePath=./admin/admin_reservationList");
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
