package servlet;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.UserBean;
import db.UserDAO;

/**
 * Servlet implementation class AddUserServlet
 */
@WebServlet("/AddUserServlet")
public class AddUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddUserServlet() {
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
		String user_mail = request.getParameter("user_mail");
		String user_pw = request.getParameter("user_pw");
		String user_name = request.getParameter("user_name");
	
		UserBean user_bean = new UserBean();
		user_bean.setUser_mail(user_mail);
		user_bean.setUser_pw(user_pw);
		user_bean.setUser_name(user_name);

		String add_user_site = request.getContextPath() + "/add_user.do";
		if(user_bean.getUser_mail().length() > 50){
			response.sendRedirect(add_user_site);
			return;
		}
		// 이메일 무결성 검사
		Pattern reg_mail = Pattern.compile("^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{2,5}$");
		boolean match_mail = reg_mail.matcher(user_bean.getUser_mail()).matches();
		if(match_mail == false){
			response.sendRedirect(add_user_site);
			return;
		}
		
		// 비번 무결성 검사
		if(user_bean.getUser_pw().length() < 6 && user_bean.getUser_pw().length() > 100){
			response.sendRedirect(add_user_site);
			return;
		}
		
		// 이름 무결성 검사
		if(user_bean.getUser_name().getBytes().length > 50){
			response.sendRedirect(add_user_site);
			return;
		}
		Pattern reg_name = Pattern.compile("^[a-z|A-Z|가-힣][a-z|A-Z|가-힣| ]*[a-z|A-Z|가-힣]$");
		boolean match_name = reg_name.matcher(user_bean.getUser_name()).matches();
		if(match_name == false){
			response.sendRedirect(add_user_site);
			return;
		}

		try{
			// 메일 중복 체크
			boolean exist_mail = UserDAO.existUserMail(user_mail);
			if(exist_mail == true){
				response.sendRedirect(add_user_site);
				return;
			}
			
			UserDAO.addUserInfo(user_bean);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		String complete_site = request.getContextPath() + "/index.jsp";
		response.sendRedirect(complete_site);
	}

}
