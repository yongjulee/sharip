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
import bean.UserBean;

/**
 * Servlet implementation class ControllerServlet
 */
@WebServlet("*.do")
public class ControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControllerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// 1. 요청할 때 사용한 서블릿 이름을 추출
		// 파라미터 한글 처리
		request.setCharacterEncoding("utf-8");
		// 세션 검사 여부를 확인할 변수
		boolean isCheckSession = false;
		// 요청 서블릿 이름을 추출
		String url = request.getRequestURI();
		// /를 기준으로 잘라낸다.
		String [] sub = url.split("/");
		url = sub[sub.length - 1];
		// ;JESSIONID 값이 붙을 수도 있기 때문에...
		sub = url.split(";");
		url = sub[0];
		// 2. 서블릿 이름으로 분기해서 실제로 이동될
		//    페이지 이름 셋팅
		String site = "서블릿이름 확인하세요";
		// 서블릿 이름으로 분기
		if(url.equals("CheckMail.do")){
			site = "CheckMailServlet";
		} else if(url.equals("join_sharip.do")){
			site = "user/add_user.jsp";
		} else if(url.equals("my_page.do")){
			site = "MypageServlet";
			isCheckSession = true;
		} else if(url.equals("add_user.do")){
			site = "AddUserServlet";
		} else if(url.equals("check_login.do")){
			site = "CheckLoginServlet";
		} else if(url.equals("logout.do")){
			site = "LogoutServlet";
		} else if(url.equals("image_pro.do")){
			site = "ImageProServlet";
		} else if(url.equals("userinfo_modify.do")){
			site = "UserInfoModifyServlet";
		} else if(url.equals("write1.do")){
			site = "board/board_write_1.jsp";
			isCheckSession = true;
		} else if(url.equals("write2.do")){
			site = "board/board_write_2.jsp";
			isCheckSession = true;
		} else if(url.equals("write3.do")){
			site = "board/board_write_3.jsp";
			isCheckSession = true;
		} else if(url.equals("write4.do")){
			site = "board/board_write_4.jsp";
			isCheckSession = true;
		} else if(url.equals("board_write.do")){
			site = "BoardWriteServlet";
			isCheckSession = true;
		} else if(url.equals("read.do")){
			site = "BoardReadServlet";
		} else if(url.equals("rewrite1.do")){
			site = "BoardRewriteServlet1";
			isCheckSession = true;
		} else if(url.equals("rewrite2.do")){
			site = "BoardRewriteServlet2";
			isCheckSession = true;
		} else if(url.equals("rewrite3.do")){
			site = "BoardRewriteServlet3";
			isCheckSession = true;
		} else if(url.equals("rewrite4.do")){
			site = "BoardRewriteServlet4";
			isCheckSession = true;
		} else if(url.equals("rewrite_complete.do")){
			site = "BoardRewriteCompleteServlet";
			isCheckSession = true;
		} else if(url.equals("board_main.do")){
			site = "BoardMainServlet";
		} else if(url.equals("userinfo_pic_modify.do")){
			site = "UserInfoPicModifyServlet";
			isCheckSession = true;
		} else if(url.equals("insert_reply.do")){
			site = "InsertReplyServlet";
			isCheckSession = true;
		} else if(url.equals("delete_reply.do")){
			site = "DeleteReplyServlet";
			isCheckSession = true;
		}

		// 3. 필요하다면 로그인여부 검사
		if(isCheckSession == true){
			// 세션에 저장되어 있는 사용자 정보 객체를
			// 추출
			HttpSession session = request.getSession();
			String user_mail = (String)session.getAttribute("user_mail");
			// 로그인 여부값 확인
			if(user_mail == null){
				site = "index.jsp";
				response.sendRedirect(site);
				return;
			}
		}

		// 4. 페이지 이동
		RequestDispatcher dis = request.getRequestDispatcher(site);
		dis.forward(request, response);
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
