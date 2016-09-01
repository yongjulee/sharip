package db;

import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import bean.BoardBean;

public class BoardDAO {
	public static int addBoardInfo(BoardBean board_bean, String continent, String travel) throws Exception{
		Connection conn = DBConnector.getConnection();
		// 대륙 테이블에서 대륙 인덱스 쿼리
		String query_continent_idx = "select CONTINENT_IDX from CONTINENT_TABLE where CONTINENT_NAME = ?";
		PreparedStatement pstmt = conn.prepareStatement(query_continent_idx);
		pstmt.setString(1, continent);
		ResultSet rs = pstmt.executeQuery();
		int continent_idx = 0;
		if(rs.next()){
			continent_idx = rs.getInt("CONTINENT_IDX");
		}
		// 여행 테이블에서 여행 인텍스 쿼리
		String query_travel_idx = "select TRAVEL_IDX from TRAVEL_TABLE where TRAVEL_NAME = ?";
		PreparedStatement pstmt2 = conn.prepareStatement(query_travel_idx);
		pstmt2.setString(1, travel);
		ResultSet rs2 = pstmt2.executeQuery();
		int travel_idx = 0;
		if(rs2.next()){
			travel_idx = rs2.getInt("TRAVEL_IDX");
		}

		String sql = "insert into BOARD_TABLE (BOARD_IDX, USER_MAIL, TRAVEL_IDX, CONTINENT_IDX, BOARD_TITLE, "
				+ "BOARD_DATE, BOARD_IMG1, BOARD_IMG2, BOARD_IMG3, BOARD_CONTENT, BOARD_LAT, BOARD_LNG, "
				+ "BOARD_LOC, BOARD_AIR, BOARD_DOM, BOARD_BAG, BOARD_ATT, BOARD_ETC, "
				+ "BOARD_IMG4, BOARD_IMG5, BOARD_IMG6, BOARD_IMG7, BOARD_IMG8, BOARD_IMG9, BOARD_IMG10";
		sql += ") values (BOARD_TABLE_SEQ.nextval,?,?,?,?,to_date(?, 'yyyy-mm-dd'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

		System.out.println("date : " + board_bean.getBoard_date());
		PreparedStatement pstmt3 = conn.prepareStatement(sql);
		pstmt3.setString(1, board_bean.getUser_mail());
		pstmt3.setInt(2, travel_idx);
		pstmt3.setInt(3, continent_idx);
		pstmt3.setString(4, board_bean.getBoard_title());
		pstmt3.setString(5, board_bean.getBoard_date());
		pstmt3.setString(6, board_bean.getBoard_img1());
		pstmt3.setString(7, board_bean.getBoard_img2());
		pstmt3.setString(8, board_bean.getBoard_img3());
		pstmt3.setString(9, board_bean.getBoard_content());
		pstmt3.setString(10, board_bean.getBoard_lat());
		pstmt3.setString(11, board_bean.getBoard_lng());
		pstmt3.setString(12, board_bean.getBoard_loc());
		pstmt3.setString(13, board_bean.getBoard_air());
		pstmt3.setString(14, board_bean.getBoard_dom());
		pstmt3.setString(15, board_bean.getBoard_bag());
		pstmt3.setString(16, board_bean.getBoard_att());
		pstmt3.setString(17, board_bean.getBoard_etc());
		
		pstmt3.setString(18, board_bean.getBoard_img4());
		pstmt3.setString(19, board_bean.getBoard_img5());
		pstmt3.setString(20, board_bean.getBoard_img6());
		pstmt3.setString(21, board_bean.getBoard_img7());
		pstmt3.setString(22, board_bean.getBoard_img8());
		pstmt3.setString(23, board_bean.getBoard_img9());
		pstmt3.setString(24, board_bean.getBoard_img10());
		
		pstmt3.execute();

		sql = "select MAX(BOARD_IDX) from BOARD_TABLE";
		Statement stmt = conn.createStatement();
		ResultSet rs3 = stmt.executeQuery(sql);
		rs3.next();
		int max = rs3.getInt(1);
		
		conn.close();
		
		return max;
	}
	
	public static BoardBean getBoardInfo(int board_idx) throws Exception{
		String sql = "select b.BOARD_IDX, b.USER_MAIL, b.TRAVEL_IDX, b.CONTINENT_IDX, b.BOARD_TITLE, "
				+ "to_char(b.BOARD_DATE, 'yyyy-mm-dd') BOARD_DATE, b.BOARD_IMG1, b.BOARD_IMG2, b.BOARD_IMG3, "
				+ "b.BOARD_IMG4, b.BOARD_IMG5, b.BOARD_IMG6, b.BOARD_IMG7, b.BOARD_IMG8, b.BOARD_IMG9, "
				+ "b.BOARD_IMG10, b.BOARD_CONTENT, b.BOARD_LAT, b.BOARD_LNG, b.BOARD_LOC, b.BOARD_AIR, "
				+ "b.BOARD_DOM, b.BOARD_BAG, b.BOARD_ATT, b.BOARD_ETC, u.USER_NAME, u.USER_PIC "
				+ "from BOARD_TABLE b, USER_TABLE u "
				+ "where b.USER_MAIL=u.USER_MAIL and b.BOARD_IDX = ?";
		
		Connection conn = DBConnector.getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, board_idx);
		ResultSet rs = pstmt.executeQuery();
		BoardBean board_bean = new BoardBean();
		
		if(rs.next()){
			board_bean.setBoard_title(rs.getString("BOARD_TITLE"));
			board_bean.setUser_mail(rs.getString("USER_MAIL"));
			board_bean.setUser_name(rs.getString("USER_NAME"));
			board_bean.setUser_pic(rs.getString("USER_PIC"));
			board_bean.setTravel_idx(rs.getInt("TRAVEL_IDX"));
			board_bean.setContinent_idx(rs.getInt("CONTINENT_IDX"));
			board_bean.setBoard_date(rs.getString("BOARD_DATE"));
			board_bean.setBoard_img1(rs.getString("BOARD_IMG1"));
			board_bean.setBoard_img2(rs.getString("BOARD_IMG2"));
			board_bean.setBoard_img3(rs.getString("BOARD_IMG3"));
			board_bean.setBoard_img4(rs.getString("BOARD_IMG4"));
			board_bean.setBoard_img5(rs.getString("BOARD_IMG5"));
			board_bean.setBoard_img6(rs.getString("BOARD_IMG6"));
			board_bean.setBoard_img7(rs.getString("BOARD_IMG7"));
			board_bean.setBoard_img8(rs.getString("BOARD_IMG8"));
			board_bean.setBoard_img9(rs.getString("BOARD_IMG9"));
			board_bean.setBoard_img10(rs.getString("BOARD_IMG10"));
			board_bean.setBoard_content(rs.getString("BOARD_CONTENT"));
			board_bean.setBoard_lat(rs.getString("BOARD_LAT"));
			board_bean.setBoard_lng(rs.getString("BOARD_LNG"));
			board_bean.setBoard_loc(rs.getString("BOARD_LOC"));
			board_bean.setBoard_air(rs.getString("BOARD_AIR"));
			board_bean.setBoard_dom(rs.getString("BOARD_DOM"));
			board_bean.setBoard_bag(rs.getString("BOARD_BAG"));
			board_bean.setBoard_att(rs.getString("BOARD_ATT"));
			board_bean.setBoard_etc(rs.getString("BOARD_ETC"));
		}
		conn.close();
		
		return board_bean;
	}
	
	public static boolean checkBoardUser(String user_mail, int board_idx) throws Exception{
		String sql = "select USER_MAIL from BOARD_TABLE where BOARD_IDX = ?";
		
		Connection conn = DBConnector.getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, board_idx);
		ResultSet rs = pstmt.executeQuery();
		boolean check = false;
		if(rs.next()){
			if(user_mail.equals(rs.getString("USER_MAIL"))) check = true;
		}
		conn.close();
		return check;
	}

	public static BoardBean getBoardFirstPage(int board_idx) throws Exception{
		String sql = "select b.BOARD_TITLE, t.TRAVEL_NAME, c.CONTINENT_NAME, b.BOARD_CONTENT "
					+ "from BOARD_TABLE b, TRAVEL_TABLE t, CONTINENT_TABLE c "
					+ "where BOARD_IDX = ? and b.TRAVEL_IDX = t.TRAVEL_IDX and b.CONTINENT_IDX = c.CONTINENT_IDX";
		
		Connection conn = DBConnector.getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, board_idx);
		
		ResultSet rs = pstmt.executeQuery();
		BoardBean board_bean = new BoardBean();
		if(rs.next()){
			board_bean.setBoard_title(URLEncoder.encode(rs.getString("BOARD_TITLE"), "utf-8"));
			board_bean.setTravel_name(rs.getString("TRAVEL_NAME"));
			board_bean.setContinent_name(rs.getString("CONTINENT_NAME"));
			board_bean.setBoard_content(URLEncoder.encode(rs.getString("BOARD_CONTENT"), "utf-8"));
		}
		conn.close();
		
		return board_bean;
	}
	
	public static BoardBean getBoardSecondPage(int board_idx) throws Exception{
		String sql = "select BOARD_IMG1, BOARD_IMG2, BOARD_IMG3, BOARD_IMG4, BOARD_IMG5, "
					+ "BOARD_IMG6, BOARD_IMG7, BOARD_IMG8, BOARD_IMG9, BOARD_IMG10 "
					+ "from BOARD_TABLE where BOARD_IDX = ?";
	
		Connection conn = DBConnector.getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, board_idx);
		
		ResultSet rs = pstmt.executeQuery();
		BoardBean board_bean = new BoardBean();
		if(rs.next()){
			board_bean.setBoard_img1(rs.getString("BOARD_IMG1"));
			board_bean.setBoard_img2(rs.getString("BOARD_IMG2"));
			board_bean.setBoard_img3(rs.getString("BOARD_IMG3"));
			board_bean.setBoard_img4(rs.getString("BOARD_IMG4"));
			board_bean.setBoard_img5(rs.getString("BOARD_IMG5"));
			board_bean.setBoard_img6(rs.getString("BOARD_IMG6"));
			board_bean.setBoard_img7(rs.getString("BOARD_IMG7"));
			board_bean.setBoard_img8(rs.getString("BOARD_IMG8"));
			board_bean.setBoard_img9(rs.getString("BOARD_IMG9"));
			board_bean.setBoard_img10(rs.getString("BOARD_IMG10"));
		}
		conn.close();
		
		return board_bean;
	}
	
	public static BoardBean getBoardThirdPage(int board_idx) throws Exception{
		String sql = "select BOARD_LAT, BOARD_LNG, BOARD_LOC "
				+ "from BOARD_TABLE where BOARD_IDX = ?";
	
		Connection conn = DBConnector.getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, board_idx);
		
		ResultSet rs = pstmt.executeQuery();
		BoardBean board_bean = new BoardBean();
		if(rs.next()){
			board_bean.setBoard_lat(rs.getString("BOARD_LAT"));
			board_bean.setBoard_lng(rs.getString("BOARD_LNG"));
			board_bean.setBoard_loc(rs.getString("BOARD_LOC"));
		}
		conn.close();
		
		return board_bean;
	}
	
	public static BoardBean getBoardFourthPage(int board_idx) throws Exception{
		String sql = "select BOARD_AIR, BOARD_DOM, BOARD_BAG, BOARD_ATT, BOARD_ETC "
				+ "from BOARD_TABLE where BOARD_IDX = ?";
	
		Connection conn = DBConnector.getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, board_idx);
		
		ResultSet rs = pstmt.executeQuery();
		BoardBean board_bean = new BoardBean();
		if(rs.next()){
			String board_air = rs.getString("BOARD_AIR");
			if (rs.wasNull()) board_air = "";
			String board_dom = rs.getString("BOARD_DOM");
			if (rs.wasNull()) board_dom = "";
			String board_bag = rs.getString("BOARD_BAG");
			if (rs.wasNull()) board_bag = "";
			String board_att = rs.getString("BOARD_ATT");
			if (rs.wasNull()) board_att = "";
			String board_etc = rs.getString("BOARD_ETC");
			if (rs.wasNull()) board_etc = "";
			
			board_bean.setBoard_air(board_air);
			board_bean.setBoard_dom(board_dom);
			board_bean.setBoard_bag(board_bag);
			board_bean.setBoard_att(board_att);
			board_bean.setBoard_etc(board_etc);
		}
		conn.close();
				
		return board_bean;
	}
	
	
	public static int getContinentIdx(String continent_name) throws Exception{
		Connection conn = DBConnector.getConnection();
		String sql = "select CONTINENT_IDX from CONTINENT_TABLE where CONTINENT_NAME = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, continent_name);
		ResultSet rs = pstmt.executeQuery();
		int continent_idx = 0;
		if(rs.next()){
			continent_idx = rs.getInt("CONTINENT_IDX");
		}
		return continent_idx;
	}
	
	public static int getTravelIdx(String travel_name) throws Exception{
		Connection conn = DBConnector.getConnection();
		String sql = "select TRAVEL_IDX from TRAVEL_TABLE where TRAVEL_NAME = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, travel_name);
		ResultSet rs = pstmt.executeQuery();
		int travel_idx = 0;
		if(rs.next()){
			travel_idx = rs.getInt("TRAVEL_IDX");
		}
		return travel_idx;
	}
	
	public static void updateBoardFirstPage(BoardBean board_bean) throws Exception{
		Connection conn = DBConnector.getConnection();
		
		int continent_idx = getContinentIdx(board_bean.getContinent_name());
		int travel_idx = getTravelIdx(board_bean.getTravel_name());
		
		String sql = "update BOARD_TABLE set BOARD_TITLE = ?, CONTINENT_IDX = ?, TRAVEL_IDX = ?, BOARD_CONTENT = ? where BOARD_IDX = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, board_bean.getBoard_title());
		pstmt.setInt(2, continent_idx);
		pstmt.setInt(3, travel_idx);
		pstmt.setString(4, board_bean.getBoard_content());
		pstmt.setInt(5, board_bean.getBoard_idx());
		
		pstmt.execute();

		conn.close();
	}
	
	public static void updateBoardSecondPage(BoardBean board_bean) throws Exception{
		Connection conn = DBConnector.getConnection();
		
		String sql = "update BOARD_TABLE set BOARD_IMG1 = ?, BOARD_IMG2 = ?, BOARD_IMG3 = ?, BOARD_IMG4 = ?, "
					+"BOARD_IMG5 = ?, BOARD_IMG6 = ?, BOARD_IMG7 = ?, BOARD_IMG8 = ?, BOARD_IMG9 = ?, BOARD_IMG10 = ? "
					+"where BOARD_IDX = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, board_bean.getBoard_img1());
		pstmt.setString(2, board_bean.getBoard_img2());
		pstmt.setString(3, board_bean.getBoard_img3());
		pstmt.setString(4, board_bean.getBoard_img4());
		pstmt.setString(5, board_bean.getBoard_img5());
		pstmt.setString(6, board_bean.getBoard_img6());
		pstmt.setString(7, board_bean.getBoard_img7());
		pstmt.setString(8, board_bean.getBoard_img8());
		pstmt.setString(9, board_bean.getBoard_img9());
		pstmt.setString(10, board_bean.getBoard_img10());
		pstmt.setInt(11, board_bean.getBoard_idx());
		
		pstmt.execute();

		conn.close();
	}
	
	public static void updateBoardThirdPage(BoardBean board_bean) throws Exception{
		Connection conn = DBConnector.getConnection();
		
		String sql = "update BOARD_TABLE set BOARD_LAT = ?, BOARD_LNG = ?, BOARD_LOC = ? where BOARD_IDX = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, board_bean.getBoard_lat());
		pstmt.setString(2, board_bean.getBoard_lng());
		pstmt.setString(3, board_bean.getBoard_loc());
		pstmt.setInt(4, board_bean.getBoard_idx());
		
		pstmt.execute();

		conn.close();
	}
	
	public static void updateBoardFourthPage(BoardBean board_bean) throws Exception{
		Connection conn = DBConnector.getConnection();
		
		String sql = "update BOARD_TABLE set BOARD_AIR = ?, BOARD_DOM = ?, BOARD_BAG = ? , "
				+ "BOARD_ATT = ? , BOARD_ETC = ? where BOARD_IDX = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, board_bean.getBoard_air());
		pstmt.setString(2, board_bean.getBoard_dom());
		pstmt.setString(3, board_bean.getBoard_bag());
		pstmt.setString(4, board_bean.getBoard_att());
		pstmt.setString(5, board_bean.getBoard_etc());
		pstmt.setInt(6, board_bean.getBoard_idx());
		
		pstmt.execute();

		conn.close();
	}
	
	public static ArrayList<BoardBean> boardMain(String continent, String travel) throws Exception{
		Connection conn = DBConnector.getConnection();
		
		int continent_idx = getContinentIdx(continent);
		int travel_idx = getTravelIdx(travel);

		String sql = "select b.BOARD_IDX, b.USER_MAIL, b.BOARD_TITLE, b.BOARD_IMG1, b.BOARD_LOC, u.USER_PIC, u.USER_NAME "
					+ "from BOARD_TABLE b, USER_TABLE u "
					+ "where b.USER_MAIL=u.USER_MAIL and b.TRAVEL_IDX = ? and b.CONTINENT_IDX = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, travel_idx);
		pstmt.setInt(2, continent_idx);
		ResultSet rs = pstmt.executeQuery();

		ArrayList<BoardBean> list = new ArrayList<BoardBean>();
		
		while(rs.next()){				
			BoardBean bean = new BoardBean();
			bean.setBoard_idx(rs.getInt("BOARD_IDX"));
			bean.setUser_mail(rs.getString("USER_MAIL"));
			bean.setUser_name(rs.getString("USER_NAME"));
			bean.setUser_pic(rs.getString("USER_PIC"));
			bean.setBoard_title(rs.getString("BOARD_TITLE"));
			bean.setBoard_img1(rs.getString("BOARD_IMG1"));
			bean.setContinent_name(continent);
			bean.setTravel_name(travel);
			bean.setBoard_loc(rs.getString("BOARD_LOC"));
			
			list.add(bean);
		}
		conn.close();
			
		return list;
	}
	
	// 글 목록 데이터를 가져오는 메서드
	public static ArrayList<BoardBean> get_board_my_info(int page_num, String user_mail) throws Exception {
		Connection conn = DBConnector.getConnection();
		
		String sql = "select * from "
				   + "(select ROWNUM as rnum, a1.* from "
				   + "(select b.BOARD_IDX, b.BOARD_TITLE, u.USER_MAIL "
				   + "from USER_TABLE u, BOARD_TABLE b "
				   + "where u.USER_MAIL = b.USER_MAIL order by b.BOARD_IDX desc) a1) a2 "
				   + "where (a2.rnum >= ? and a2.rnum <= ?) and USER_MAIL = ?";
		int min = 1 + ((page_num - 1) * 10);
		int max = min + 9;
		
		PreparedStatement pstmt 
					= conn.prepareStatement(sql);
		pstmt.setInt(1, min);
		pstmt.setInt(2, max);
		pstmt.setString(3, user_mail);
		
		ResultSet rs = pstmt.executeQuery();
		// 데이터를 추출해서 담는다.
		ArrayList<BoardBean> list
						= new ArrayList<BoardBean>();
		while(rs.next()){
			// 데이터 추출
			int board_idx = rs.getInt("BOARD_IDX");
			String board_subject = rs.getString("BOARD_TITLE");
			String board_writer_name = rs.getString("USER_MAIL");
			// 데이터를 담는다.
			BoardBean bean = new BoardBean();
			bean.setBoard_idx(board_idx);
			bean.setBoard_title(board_subject);
			bean.setUser_mail(board_writer_name);
			// 리스트에 담는다.
			list.add(bean);
		}
		
		conn.close();
		
		return list;
	}
	// 전체 페이지의 개수를 구한다.
	public static int getPageCnt() throws Exception{
		Connection conn = DBConnector.getConnection();
		
		String sql = "select COUNT(*) from BOARD_TABLE";
		
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		rs.next();
		
		int cnt = rs.getInt(1);
		int page_cnt = cnt / 10;
		if(cnt % 10 > 0){
			page_cnt++;
		}
		
		conn.close();
		
		return page_cnt;
	}
	// 게시글의 개수를 구한다
	public static int getBoardCnt() throws Exception{
		Connection conn = DBConnector.getConnection();
		
		String sql = "select COUNT(*) from BOARD_TABLE";
		
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		rs.next();
		
		int cnt = rs.getInt(1);
		
		cnt++;
		
		conn.close();
		
		return cnt;
	}
	
	/*
	public static ArrayList<BoardBean> queryContinentTravel() throws Exception{
		Connection conn = DBConnector.getConnection();
		
		String sql = "select b.BOARD_IDX, u.USER_MAIL, b.BOARD_TITLE, to_char(BOARD_DATE, 'yyyy-mm-dd), BOARD_IMG1";
		String sql = "update BOARD_TABLE set BOARD_AIR = ?, BOARD_DOM = ?, BOARD_BAG = ? , "
				+ "BOARD_ATT = ? , BOARD_ETC = ? where BOARD_IDX = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, board_bean.getBoard_air());
		pstmt.setString(2, board_bean.getBoard_dom());
		pstmt.setString(3, board_bean.getBoard_bag());
		pstmt.setString(4, board_bean.getBoard_att());
		pstmt.setString(5, board_bean.getBoard_etc());
		pstmt.setInt(6, board_bean.getBoard_idx());
		
		pstmt.execute();

		conn.close();
	}
	*/

}










