package servlet;

import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import bean.UserBean;
import db.UserDAO;


/**
 * Servlet implementation class UserInfoServlet
 */
@WebServlet("/UserInfoModifyServlet")
public class UserInfoModifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserInfoModifyServlet() {
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
		// 파라미터 추출
		String user_name = request.getParameter("user_name");
		String user_pw = request.getParameter("user_pw");
		HttpSession session = request.getSession();
		String user_mail = (String)session.getAttribute("user_mail");

		
		UserBean user_bean = new UserBean();
		user_bean.setUser_mail(user_mail);
		user_bean.setUser_name(user_name);
		user_bean.setUser_pw(user_pw);

		
		// 사용자 정보 수정 페이지로 이동
		String site = "user/mypage_userinfo_modify.jsp";
		if(user_bean.getUser_mail().length() > 50){
			response.sendRedirect(site);
			return;
		}
		// 이메일 무결성 검사
		Pattern reg_mail = Pattern.compile("^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{2,5}$");
		boolean match_mail = reg_mail.matcher(user_bean.getUser_mail()).matches();
		if(match_mail == false){
			response.sendRedirect(site);
			return;
		}
		// 이름 무결성 검사
		if(user_bean.getUser_name().getBytes().length > 50){
			response.sendRedirect(site);
			return;
		}
		// 비번 무결성 검사
		if(user_bean.getUser_pw().length() < 6 && user_bean.getUser_pw().length() > 100){
			response.sendRedirect(site);
			return;
		}
		Pattern reg_name = Pattern.compile("^[a-z|A-Z|가-힣][a-z|A-Z|가-힣| ]*[a-z|A-Z|가-힣]$");
		boolean match_name = reg_name.matcher(user_bean.getUser_name()).matches();
		if(match_name == false){
			response.sendRedirect(site);
			return;
		}
		try{
			UserDAO.updateUserInfo(user_bean);
			session.setAttribute("user_name", user_name);
			response.sendRedirect(site);
		}catch(Exception e){
			e.printStackTrace();
		}			
	}

}
