package db;

import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import bean.ReplyBean;

public class ReplyDAO {
	public static int insert_reply(ReplyBean reply_bean) throws Exception{
		Connection conn = DBConnector.getConnection();

		String sql = "insert into reply_table (REPLY_IDX, USER_MAIL, BOARD_IDX, REPLY_CONTENT, REPLY_DATE) "
					+"values (REPLY_TABLE_SEQ.nextval, ?, ?, ?, to_date(?, 'yyyy-MM-dd HH24:mi:ss'))";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, reply_bean.getUser_mail());
		pstmt.setInt(2, reply_bean.getBoard_idx());
		pstmt.setString(3, reply_bean.getReply_content());
		pstmt.setString(4, reply_bean.getReply_date());
		
		pstmt.execute();

		sql = "select MAX(REPLY_IDX) from REPLY_TABLE";
		Statement stmt = conn.createStatement();
		ResultSet rs2 = stmt.executeQuery(sql);
		rs2.next();
		int max = rs2.getInt(1);

		conn.close();
		
		return max;
	}
	
	public static ArrayList<ReplyBean> getBoardReply(int board_idx) throws Exception{
		Connection conn = DBConnector.getConnection();

		String sql = "select r.REPLY_IDX, r.USER_MAIL, r.REPLY_CONTENT, to_char(r.REPLY_DATE, 'yyyy-mm-dd HH24:mi:ss') REPLY_DATE, "
					+"u.USER_NAME, u.USER_PIC from REPLY_TABLE r, USER_TABLE u where r.USER_MAIL = u.USER_MAIL and r.BOARD_IDX = ? ORDER BY REPLY_IDX";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, board_idx);
		ResultSet rs = pstmt.executeQuery();
		
		ArrayList<ReplyBean> reply_list = new ArrayList<ReplyBean>();
		while(rs.next()){
			ReplyBean reply_bean = new ReplyBean();
			reply_bean.setReply_idx(rs.getInt("REPLY_IDX"));
			reply_bean.setUser_mail(rs.getString("USER_MAIL"));
			String contents = URLEncoder.encode(rs.getString("REPLY_CONTENT"), "utf-8");
			reply_bean.setReply_content(contents);
			reply_bean.setReply_date(rs.getString("REPLY_DATE"));
			reply_bean.setUser_name(rs.getString("USER_NAME"));
			String user_pic = rs.getString("USER_PIC");
			if(user_pic == null) user_pic = "myInfo.gif";
			reply_bean.setUser_pic(user_pic);
			reply_list.add(reply_bean);
		}
		conn.close();
		
		return reply_list;
	}
	
	public static void deleteReply(int reply_idx, String user_mail) throws Exception{
		Connection conn = DBConnector.getConnection();

		String sql = "delete from REPLY_TABLE where REPLY_IDX = ? and USER_MAIL = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, reply_idx);
		pstmt.setString(2, user_mail);
		
		pstmt.execute();

		conn.close();
	}
}