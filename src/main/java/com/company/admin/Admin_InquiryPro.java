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

import com.company.Vo.inquiryVo;
import com.company.common.JDBCconn;

@WebServlet("/Admin_InquiryPro")
public class Admin_InquiryPro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/Admin_InquiryPro");
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
			String sql = "select * from (select rownum rnum,A.* from "
					+ "(select * from inquiry order by b_writedate desc) A) where rnum between ? and ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, page*10-9);
			pstmt.setInt(2, page*10);
			
			rs = pstmt.executeQuery();
			ArrayList<inquiryVo> iqvo = new ArrayList<inquiryVo>();
			while (rs.next()) {
				inquiryVo vo = new inquiryVo();
				vo.setB_no(rs.getInt("b_no"));
				vo.setB_userid(rs.getString("b_userid"));
				vo.setB_title(rs.getString("b_title"));
				vo.setB_content(rs.getString("b_content"));
				vo.setB_writedate(rs.getString("b_writedate"));
				
				iqvo.add(vo);
			}
			pstmt.close();
			rs.close();
			//재활용하기 위해 사용한자원을 잠시 닫아준다. totalCount 값은 따로 정해야 다시 정의해야 됨
			
			sql="select count(*) from inquiry";   //보드의 총 갯수 = 토탈카운트 
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			int totalCount=0;
			if(rs.next()) {
				totalCount = rs.getInt(1);
			}
			System.out.println(totalCount+"명 , 고객의소리 게시물 수");
			request.setAttribute("iqvo", iqvo);
			request.setAttribute("totalRows", totalCount);
			
			RequestDispatcher dis = request.getRequestDispatcher("index.jsp?filePath=./admin/admin_InquiryList");
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
