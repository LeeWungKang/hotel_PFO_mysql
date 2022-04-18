package com.company.board;

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

import com.company.Vo.BoardVo;
import com.company.common.JDBCconn;

@WebServlet("/SearchPro")
public class SearchPro extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	System.out.println("(서블릿) 검색1 시작");
	
	int page; 
	if( request.getParameter("page")== null) page = 1;
	else page = Integer.parseInt(request.getParameter("page"));
	
	HttpSession session = request.getSession();
	String name =(String) session.getAttribute("name");
	String role =(String) session.getAttribute("role");
	if(name == null) {response.sendRedirect("index.jsp");  return; 	}
	
	
	String select_type = request.getParameter("select_type");
	String search_keyword = request.getParameter("search_keyword");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try {
		conn = JDBCconn.getConnection();
		pstmt = search(conn,select_type,search_keyword,page);
		rs = pstmt.executeQuery();
		
		ArrayList<BoardVo> list = new ArrayList<BoardVo>();
		while(rs.next()) {
			BoardVo vo = new BoardVo();
			vo.setSeq(rs.getInt("seq"));
			vo.setNickname(rs.getString("nickname"));
			vo.setContent(rs.getString("content"));
			vo.setTitle(rs.getString("title")); 
			vo.setRegdate(rs.getDate("regdate"));
			vo.setCnt(rs.getInt("cnt")); 
			list.add(vo);
		}
		pstmt.close();
		rs.close();
//재활용하기 위해 데이타받아놓고 잠시 닫아준다.
//추가 sql 문 ( 검색한 결과만 내려주기 위해 )		
		
		
	
		String sql ="select count(*) from HomeBoard where "+select_type+" like concat('%', ?, '%') ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, search_keyword);
		
		rs=pstmt.executeQuery();
		
		int totalRows = 0;
		if (rs.next()) totalRows = rs.getInt(1);

		request.setAttribute("search_keyword", search_keyword);
		request.setAttribute("select_type", select_type);
		request.setAttribute("totalRows", totalRows);
		request.setAttribute("list", list);
		
		System.out.println(search_keyword+""+select_type);
		RequestDispatcher dis = request.getRequestDispatcher("index.jsp?filePath=./boardJSP/getSearchList");
		dis.forward(request, response);
		
		
		
	}catch(ClassNotFoundException | SQLException e) {
		e.printStackTrace();
	}finally {
		JDBCconn.close(rs, pstmt, conn);
	}
	}
	
	
	private PreparedStatement search(Connection conn, String select_type, String search_keyword, int page) throws SQLException {
		PreparedStatement pstmt = null;

		final String SEARCHING_SQL = "select * from HomeBoard where " +select_type+ " like concat('%', ?, '%') order by seq desc limit ?,?";

		pstmt = conn.prepareStatement(SEARCHING_SQL);
		pstmt.setString(1, search_keyword);
		pstmt.setInt(2, page * 0);
		pstmt.setInt(3, page * 10);

		return pstmt;
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
