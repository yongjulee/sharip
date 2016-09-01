package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.BoardBean;
import db.BoardDAO;

/**
 * Servlet implementation class BoardRewriteCompleteServlet
 */
@WebServlet("/BoardRewriteCompleteServlet")
public class BoardRewriteCompleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardRewriteCompleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int page_num = Integer.parseInt(request.getParameter("page"));
		int board_idx = Integer.parseInt(request.getParameter("board_idx"));
		
		BoardBean board_bean = new BoardBean();
		board_bean.setBoard_idx(board_idx);
		if(page_num == 1){ // 첫번째 페이지 수정
			String board_title = request.getParameter("board_title");
			String continent = request.getParameter("continent");
			String travel = request.getParameter("travel");
			String board_content = request.getParameter("board_content");
			board_bean.setBoard_title(board_title);
			board_bean.setContinent_name(continent);
			board_bean.setTravel_name(travel);
			board_bean.setBoard_content(board_content);
			try {
				BoardDAO.updateBoardFirstPage(board_bean);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(page_num == 2){ // 두번째 페이지 수정
			String[] img_src = request.getParameterValues("img_src");
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
			try {
				BoardDAO.updateBoardSecondPage(board_bean);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(page_num == 3){ // 세번째 페이지 수정
			String board_lat = request.getParameter("board_lat");
			String board_lng = request.getParameter("board_lng");
			String board_loc = request.getParameter("board_loc");
			board_bean.setBoard_lat(board_lat);
			board_bean.setBoard_lng(board_lng);
			board_bean.setBoard_loc(board_loc);
			try {
				BoardDAO.updateBoardThirdPage(board_bean);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(page_num == 4){ // 네번째 페이지 수정
			String board_air = request.getParameter("board_air");
			String board_dom = request.getParameter("board_dom");
			String board_bag = request.getParameter("board_bag");
			String board_att = request.getParameter("board_att");
			String board_etc = request.getParameter("board_etc");
			board_bean.setBoard_air(board_air);
			board_bean.setBoard_dom(board_dom);
			board_bean.setBoard_bag(board_bag);
			board_bean.setBoard_att(board_att);
			board_bean.setBoard_etc(board_etc);
			
			try {
				BoardDAO.updateBoardFourthPage(board_bean);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else{
			response.sendRedirect(request.getContextPath() + "/index.jsp");
			return;
		}
		
		response.sendRedirect(request.getContextPath() + "/read.do?board_idx=" + board_idx);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
