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
import com.company.Vo.replyVo;
import com.company.common.JDBCconn;

@WebServlet("/Get_Board_Pro")
public class Get_Board_Pro extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/Get_Board_Pro");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		  HttpSession session=request.getSession(); 
		  String name=(String) session.getAttribute("name"); //이페이지에서 시작하는 사람도 있어서 세션 구현. if(name==null)
		  String role=(String) session.getAttribute("role");
		  int num=Integer.parseInt(request.getParameter("num"));
		
		  if(name ==null)
		  response.sendRedirect("index.jsp?filePath=./login_check/Login_main"); //로그인페이지 화면으로
		 
		  System.out.println(name+""+role);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn=JDBCconn.getConnection();    //조회수 증가 sql
			String sql="update HomeBoard set cnt=(select cnt+1 from HomeBoard where seq =?) where seq =? ";  
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();
			pstmt.close();
			System.out.println(num+"1");
			
			sql= "select * from HomeBoard where seq=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			System.out.println(num+"2");
			
			if(rs.next()) {
				BoardVo vo = new BoardVo();
				vo.setSeq(rs.getInt("seq"));
				vo.setNickname(rs.getString("nickname"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setRegdate(rs.getDate("regdate"));
				vo.setCnt(rs.getInt("cnt"));
				vo.setUserid(rs.getString("userid"));
				request.setAttribute("vo", vo);
			}
			pstmt.close();
			rs.close();
			//댓글목록을 화면에 넣기위해 위에서 사용한 자원은 잠시 닫아주고 재활용하면서 새로운 sql문 시작
			//날짜+ 시간까지 추가하는 sql
			sql="select boardseq,replyseq,nickname,comments,to_char(regdate,'YYYY-MM-DD HH24:MI:SS') from reply where boardseq=? order by replyseq desc";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);   //replyPro에서 넘긴 num값을 (seq넘김) 받아오는 것.
			
			rs=pstmt.executeQuery();
			
			
			ArrayList<replyVo> reply = new ArrayList<replyVo>();
			while(rs.next()) {
				replyVo replyvo = new replyVo();
				replyvo.setBoardseq(rs.getInt("boardseq"));
				replyvo.setReplyseq(rs.getInt("replyseq"));
				replyvo.setComments(rs.getString("comments"));
				replyvo.setNickname(rs.getString("nickname"));
				replyvo.setRegdate(rs.getString(5));
				reply.add(replyvo);
			}
			request.setAttribute("reply", reply);
			
			
			RequestDispatcher dis = request.getRequestDispatcher("index.jsp?filePath=./boardJSP/getBoard");
			dis.forward(request, response);
			
			
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();    
			}finally {
				JDBCconn.close(rs, pstmt, conn);
		}}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
