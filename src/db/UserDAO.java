package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.regex.Pattern;

import bean.UserBean;

public class UserDAO {
	public static boolean existUserMail(String user_mail) throws Exception{
		String sql = "select * from USER_TABLE where USER_MAIL=?";
		Connection conn = DBConnector.getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, user_mail);
		ResultSet rs = pstmt.executeQuery();
	
		boolean check = rs.next();

		conn.close();

		return check;
	}
	
	public static void addUserInfo(UserBean user_bean) throws Exception{
		String sql = "INSERT INTO USER_TABLE "
				+ "(USER_MAIL, USER_PW, USER_NAME) VALUES(?, ?, ?)";
		Connection conn = DBConnector.getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, user_bean.getUser_mail());
		pstmt.setString(2, user_bean.getUser_pw());
		pstmt.setString(3, user_bean.getUser_name());
		
		pstmt.execute();
		
		conn.close();
	}
	
	// 사용자 정보를 가지고 오는 메서드
	public static UserBean getUserInfo(String user_mail) throws Exception{
		Connection db = DBConnector.getConnection();
		
		String sql = "select USER_NAME from USER_TABLE where USER_MAIL=?";
		
		PreparedStatement pstmt = db.prepareStatement(sql);
		
		pstmt.setString(1, user_mail);
		
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		
		UserBean bean = new UserBean();
		bean.setUser_name(rs.getString("USER_MAIL"));
		bean.setUser_name(rs.getString("USER_NAME"));
		bean.setUser_name(rs.getString("USER_PW"));
		bean.setUser_name(rs.getString("USER_PIC"));
		
		db.close();
		
		return bean;
	}
	
	public static String checkLogin(UserBean user_bean) throws Exception{
		// state == 1 로그인 성공
		// state == 2 메일 존재 x
		// state == 3 패스워드 x
		String state = "2";
		String sql = "select USER_MAIL, USER_PW, USER_NAME, USER_PIC from USER_TABLE "
				+ "where USER_MAIL = ?";
		Connection conn = DBConnector.getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, user_bean.getUser_mail());
		
		ResultSet rs = pstmt.executeQuery();
		
		String user_pw = null;
		String user_name = null;
		String user_pic = null;
		while(rs.next()){
			user_pw = rs.getString("USER_PW");
			user_name = rs.getString("USER_NAME");
			user_pic = rs.getString("USER_PIC");
			
			if(user_pw.equals(user_bean.getUser_pw())){
				state = "1," + user_name + "," + user_pic;
			} else{
				state = "3";
			}
		}
		conn.close();
		
		return state;
	}
	
	public static void updateUserInfo(UserBean bean) throws Exception{
		String sql = "update USER_TABLE "
				   + "set USER_NAME=?, USER_PW=? "
				   + "where USER_MAIL=?";
		
		Connection conn = DBConnector.getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, bean.getUser_name());
		pstmt.setString(2, bean.getUser_pw());
		pstmt.setString(3, bean.getUser_mail());
		
		System.out.println("Dmail : " + bean.getUser_mail());			
		System.out.println("Dname : " + bean.getUser_name());			
		System.out.println("Dpw : " + bean.getUser_pw());	
		
		pstmt.execute();
		
		conn.close();
	}
	// 사용자 프로필 사진 업데이트
	public static void updateUserPic(UserBean bean) throws Exception{
		String sql = "update USER_TABLE "
				+ "set USER_PIC=? "
				+ "where USER_MAIL=?";
		
		Connection conn = DBConnector.getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, bean.getUser_pic());		
		pstmt.setString(2, bean.getUser_mail());		
		
		pstmt.execute();
		conn.close();
	}
}
