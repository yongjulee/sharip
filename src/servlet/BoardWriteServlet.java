package servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.BoardBean;
import db.BoardDAO;

/**
 * Servlet implementation class BoardWriteServlet
 */
@WebServlet("/BoardWriteServlet")
public class BoardWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardWriteServlet() {
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
		String title = request.getParameter("title");
		String continent = request.getParameter("continent");
		String travel = request.getParameter("travel");
		String content = request.getParameter("content");
		String[] img_src = request.getParameterValues("img_src");
		String lat = request.getParameter("lat");
		String lng = request.getParameter("lng");
		String loc = request.getParameter("loc");
		String air = request.getParameter("board_air");
		String dom = request.getParameter("board_dom");
		String bag = request.getParameter("board_bag");
		String att = request.getParameter("board_att");
		String etc = request.getParameter("board_etc");
		
		HttpSession session = request.getSession();
		String user_mail = (String)session.getAttribute("user_mail");
		
		BoardBean board_bean = new BoardBean();
		board_bean.setBoard_title(title);
		board_bean.setBoard_content(content);
		for(int i=0; i<img_src.length; i++){
			switch (i){
			case 0 : board_bean.setBoard_img1(img_src[i]);
			case 1 : board_bean.setBoard_img2(img_src[i]);
			case 2 : board_bean.setBoard_img3(img_src[i]);
			case 3 : board_bean.setBoard_img4(img_src[i]);
			case 4 : board_bean.setBoard_img5(img_src[i]);
			case 5 : board_bean.setBoard_img6(img_src[i]);
			case 6 : board_bean.setBoard_img7(img_src[i]);
			case 7 : board_bean.setBoard_img8(img_src[i]);
			case 8 : board_bean.setBoard_img9(img_src[i]);
			case 9 : board_bean.setBoard_img10(img_src[i]);
			}
		}
		board_bean.setBoard_lat(lat);
		board_bean.setBoard_lng(lng);
		board_bean.setBoard_loc(loc);
		board_bean.setBoard_air(air);
		board_bean.setBoard_dom(dom);
		board_bean.setBoard_bag(bag);
		board_bean.setBoard_att(att);
		board_bean.setBoard_etc(etc);
		board_bean.setUser_mail(user_mail);

		// (1) Calendar객체를 얻는다.
		Calendar cal = Calendar.getInstance();
		// (2) 출력 형태를 지정하기 위해 Formatter를 얻는다.
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
		// (3) 출력형태에 맞는 문자열을 얻는다.
		String datetime1 = sdf1.format(cal.getTime());
		board_bean.setBoard_date(datetime1);
		
		try {
			int board_idx = BoardDAO.addBoardInfo(board_bean, continent, travel);
			String complete_site = request.getContextPath() + "/read.do?board_idx=" + board_idx;
			response.sendRedirect(complete_site);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
