package user;

import java.sql.*;

public class UserDAO {

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public UserDAO() {
        try {
            String dbURL = "jdbc:vertica://192.168.40.119:5433/ent";
            String dbID = "vertica";
            String dbPassword = "vertica!";
            Class.forName("com.vertica.jdbc.Driver");  // Vertica 드라이버 클래스
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int login(String userid, String userpw) {
        String SQL = "SELECT userpw FROM public.gtg_users WHERE userid = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userid);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                if (rs.getString(1).equals(userpw)) {
                    return 1; // 로그인 성공
                } else {
                    return 0; // 비밀번호 불일치
                }
            }
            return -1; // 아이디 없음
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 리소스 정리
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        }
        return -2; // DB 오류
    }
}
