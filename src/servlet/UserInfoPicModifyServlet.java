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
 * Servlet implementation class UserInfoPicModifyServlet
 */
@WebServlet("/UserInfoPicModifyServlet")
public class UserInfoPicModifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserInfoPicModifyServlet() {
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
		// 파일이 업로드 될 실제 경로를 파악한다
		ServletContext context = getServletContext();
		String path = context.getRealPath("/upload");
		// 파일 용량
		int max = 1024 * 1024 * 100;
		// 인코딩 타입
		String enc = "utf-8";
		// 파일 업로드 처리
		DefaultFileRenamePolicy dfr = new DefaultFileRenamePolicy();
		MultipartRequest mr = new MultipartRequest(request, path, max, enc, dfr);
		HttpSession session = request.getSession();
		String user_mail = (String)session.getAttribute("user_mail");
		String user_pic = mr.getFilesystemName("user_pic");
		
		UserBean user_bean = new UserBean();
		user_bean.setUser_mail(user_mail);
		user_bean.setUser_pic(user_pic);

		// 사용자 정보 수정 페이지로 이동
		String site = "user/mypage_userinfo_modify.jsp";
		
		try{
			UserDAO.updateUserPic(user_bean);
			session.setAttribute("user_pic", user_pic);
			response.sendRedirect(site);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}