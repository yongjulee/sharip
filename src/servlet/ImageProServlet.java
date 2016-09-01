package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class ImageProServlet
 */
@WebServlet("/ImageProServlet")
public class ImageProServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ImageProServlet() {
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
		// String data1 = request.getParameter("data1");
		// 파일이 저장될 물리적인 경로
		// 파일 용량 제한
		ServletContext context = getServletContext();
		String path = context.getRealPath("/upload");
		
		int max = 1024 * 1024 * 3;	// 3MB
		// 저장 파일의 인코딩 방식
		String enc = "utf-8";
		// 중복 파일이 있을 경우 이름 변경 정책을 설정하기 위한
		// 객체를 생성
		DefaultFileRenamePolicy dfr = new DefaultFileRenamePolicy();
		// 업로드 처리
		MultipartRequest mr = new MultipartRequest(request, path, max, enc, dfr);
		// 파라미터 데이터 추출
		String file_name = mr.getFilesystemName("img_file");
		
		RequestDispatcher dis = request.getRequestDispatcher("/board/image_check.jsp?file_name=" + file_name);
		dis.forward(request, response);
	}

}
