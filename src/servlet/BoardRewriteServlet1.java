package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.BoardBean;
import db.BoardDAO;

/**
 * Servlet implementation class BoardRewriteServlet1
 */
@WebServlet("/BoardRewriteServlet1")
public class BoardRewriteServlet1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardRewriteServlet1() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String user_mail = (String)session.getAttribute("user_mail");
		int board_idx = Integer.parseInt(request.getParameter("board_idx"));
		try {
			boolean check = BoardDAO.checkBoardUser(user_mail, board_idx);
			if(check == false){
				response.sendRedirect(request.getContextPath() + "/index.jsp");
				return;
			}
			BoardBean board_bean = BoardDAO.getBoardFirstPage(board_idx);
			request.setAttribute("board_bean", board_bean);
			
			RequestDispatcher dis = request.getRequestDispatcher("/board/board_rewrite_1.jsp");
			dis.forward(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
