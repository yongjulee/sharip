package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.UserBean;
import db.UserDAO;

/**
 * Servlet implementation class CheckLoginServlet
 */
@WebServlet("/CheckLoginServlet")
public class CheckLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		UserBean user_bean = new UserBean();
		user_bean.setUser_mail(request.getParameter("user_mail"));
		user_bean.setUser_pw(request.getParameter("user_pw"));
		
		try{
			String login_state = UserDAO.checkLogin(user_bean);
			String sub[] = login_state.split(",");
			request.setAttribute("login_state", sub[0]);
			if(sub[0].equals("1")){
				HttpSession session = request.getSession();
				session.setAttribute("user_mail", user_bean.getUser_mail());
				session.setAttribute("user_name", sub[1]);
				if(sub[2].equals("null")) session.setAttribute("user_pic", "myInfo.gif");
				else session.setAttribute("user_pic", sub[2]);
			}
			
			String check_login_page = "/user/check_login.jsp";
			RequestDispatcher dis = request.getRequestDispatcher(check_login_page);
			dis.forward(request, response);
		} catch(Exception e){
			e.printStackTrace();
		}
	}
}
