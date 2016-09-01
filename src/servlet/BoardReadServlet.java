package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.BoardBean;
import bean.ReplyBean;
import db.BoardDAO;
import db.ReplyDAO;

/**
 * Servlet implementation class BoardReadServlet
 */
@WebServlet("/BoardReadServlet")
public class BoardReadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardReadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try{
			// 파라미터 데이터 추출
			String board_idx_str = request.getParameter("board_idx");
			int board_idx = Integer.parseInt(board_idx_str);
			// 데이터 베이스에서 데이터를 가지고 온다.
			BoardBean bean = BoardDAO.getBoardInfo(board_idx);
			ArrayList<ReplyBean> reply_list = ReplyDAO.getBoardReply(board_idx);

			request.setAttribute("board_bean", bean);
			request.setAttribute("reply_list", reply_list);

			// 이동한다.
			String site = "board/board_read.jsp";
			RequestDispatcher dis = request.getRequestDispatcher(site);
			dis.forward(request, response);

		}catch(Exception e){
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