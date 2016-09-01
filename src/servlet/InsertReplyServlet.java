package servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.ReplyBean;
import db.ReplyDAO;

/**
 * Servlet implementation class InsertReplyServlet
 */
@WebServlet("/InsertReplyServlet")
public class InsertReplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertReplyServlet() {
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
		String reply_contents = request.getParameter("contents");
		int board_idx = Integer.parseInt(request.getParameter("board_idx"));
		
		// (1) Calendar객체를 얻는다.
		Calendar cal = Calendar.getInstance();
		// (2) 출력 형태를 지정하기 위해 Formatter를 얻는다.
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		// (3) 출력형태에 맞는 문자열을 얻는다.
		String reply_date = sdf1.format(cal.getTime());
		
		ReplyBean reply_bean = new ReplyBean();
		reply_bean.setUser_mail(user_mail);
		reply_bean.setReply_content(reply_contents);
		reply_bean.setBoard_idx(board_idx);
		reply_bean.setReply_date(reply_date);
		
		try {
			int reply_idx = ReplyDAO.insert_reply(reply_bean);
			reply_bean.setReply_idx(reply_idx);
			request.setAttribute("reply_bean", reply_bean);
			RequestDispatcher dis = request.getRequestDispatcher("/board/get_insert_reply.jsp");
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
