package com.company.inquiry;

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

import com.company.Vo.InquiryReVo;
import com.company.Vo.inquiryVo;
import com.company.common.JDBCconn;

@WebServlet("/getUserInquiry")
public class getUserInquiry extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("getUserInquiry --  사용자 Q&A 페이징");
		
		int num=Integer.parseInt(request.getParameter("num"));
		System.out.println(num + "num ?");
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name"); // 이페이지에서 시작하는 사람도 있어서 세션 구현. if(name==null)
		if (name == null)
			response.sendRedirect("index.jsp?filePath=./login_check/Login_main"); // 로그인페이지 화면으로

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = JDBCconn.getConnection(); 
			String sql = "select * from inquiry where b_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			ArrayList<inquiryVo> iqList = new ArrayList<inquiryVo>();
			while (rs.next()) {
				inquiryVo vo = new inquiryVo();
				vo.setB_no(rs.getInt("b_no"));
				vo.setB_userid(rs.getString("b_userid"));
				vo.setB_title(rs.getString("b_title"));
				vo.setB_content(rs.getString("b_content"));
				vo.setB_writedate(rs.getString("b_writedate"));
				iqList.add(vo);
			}
			  pstmt.close();  rs.close();
			  
			  //댓글이 달렸으면 출력하고, 없으면 없다고 출력
			  // 댓글목록을 화면에 넣기위해 위에서 사용한 자원은 잠시 닫아주고 재활용하면서 새로운 sql문 시작
			  // 날짜+ 시간까지 추가하는 sql
			  sql =
			  "select ir_seq, ir_no, ir_role, ir_comments ,date_format(ir_regdate,'%Y-%m-%d %H:%i:%s') as ir_regdate"
					  + " from inquiryReply where ir_seq=? " 
					  + " order by ir_no desc"; 
			  pstmt =  conn.prepareStatement(sql); 
			  pstmt.setInt(1, num); 
			  rs = pstmt.executeQuery();
			  // replyPro에서 넘긴 num값을  (seq넘김) 받아오는 것.
			  
			  ArrayList<InquiryReVo> iqReList = new ArrayList<InquiryReVo>(); 
			  while(rs.next()) { 
				  InquiryReVo iqvo = new InquiryReVo();
			  iqvo.setIr_seq(rs.getInt("ir_seq")); 
			  iqvo.setIr_no(rs.getInt("ir_no"));
			  iqvo.setIr_role(rs.getString("ir_role"));
			  iqvo.setIr_comments(rs.getString("ir_comments"));
			  iqvo.setIr_regdate(rs.getString(5));
			  iqReList.add(iqvo); 
			  }
			  System.out.println(iqReList + " ....................");
			  
			  
			  
			  request.setAttribute("iqReList", iqReList);
			  request.setAttribute("iqList", iqList);
			
			RequestDispatcher dis = request.getRequestDispatcher("index.jsp?filePath=./user/userGetInquiry");
			dis.forward(request, response);

			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCconn.close(rs, pstmt, conn);
		}
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
