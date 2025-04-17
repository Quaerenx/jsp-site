package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public BbsDAO() {
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
	
    public String getDate() { 
    	String SQL = "select sysdate()";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);
    		rs = pstmt.executeQuery();
    		if (rs.next()) {
    			return rs.getString(1);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return ""; // db 오류
    }
    
    public int getNext() { 
    	String SQL = "select bbsid from bbs order by bbsid desc";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);
    		rs = pstmt.executeQuery();
    		if (rs.next()) {
    			return rs.getInt(1) + 1;
    		}
    		return 1; // 통틀어 첫 글인경우 
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return -1; // db 오류
    }
    
    public int write(String bbsTitle, String userid, String bbsContent) {
    	String SQL = "insert into bbs values ( ? , ? , ? , ? , ? , ? )";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);
    		pstmt.setInt(1, getNext());
    		pstmt.setString(2, bbsTitle);
    		pstmt.setString(3, userid);
    		pstmt.setString(4, getDate());
    		pstmt.setString(5, bbsContent);
    		pstmt.setInt(6, 1);
    		return pstmt.executeUpdate();
    		//rs = pstmt.executeQuery();
    		//return pstmt.executeUpdate();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return -1; // db 오류
    }
    public ArrayList<Bbs> getList(int pageNumber) { 
    	String SQL = "select * from bbs where  bbsid < ? and bbsAvailable = 1 order by bbsid limit 10";
    	ArrayList<Bbs> list = new ArrayList<Bbs>();
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);
    		pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10);
    		rs = pstmt.executeQuery();
    		while (rs.next()) {
    			Bbs bbs = new Bbs();
    			bbs.setBbsID(rs.getInt(1));
    			bbs.setBbsTitle(rs.getString(2));
    			bbs.setUserID(rs.getString(3));
    			bbs.setBbsDate(rs.getString(4));
    			bbs.setBbsContent(rs.getString(5));
    			bbs.setBbsAvailable(rs.getInt(6));
    			list.add(bbs);
    		} 
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return list; //반환
    }
    public boolean nextPage(int pageNumber) {
    	String SQL = "select * from bbs where  bbsid < ? and bbsAvailable = 1";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(SQL);
    		pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10);
    		rs = pstmt.executeQuery();
    		if (rs.next()) {
    			return true;
    		} 
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return false;
    }
    
    public Bbs getBbs(int bbsID) {
	String SQL = "select * from bbs where  bbsid = ?";
	try {
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setInt(1,bbsID);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			Bbs bbs = new Bbs();
			bbs.setBbsID(rs.getInt(1));
			bbs.setBbsTitle(rs.getString(2));
			bbs.setUserID(rs.getString(3));
			bbs.setBbsDate(rs.getString(4));
			bbs.setBbsContent(rs.getString(5));
			bbs.setBbsAvailable(rs.getInt(6));
			return bbs;
		} 
	} catch (Exception e) {
		e.printStackTrace();
	}
	return null;
    }
    
    public int update(int bbsid, String bbsTitle, String bbsContent) {
	    	String SQL = "UPDATE BBS SET bbsTitle = ? , bbsContent = ? where bbsID = ? ";
	    	try {
	    		PreparedStatement pstmt = conn.prepareStatement(SQL);
	    		pstmt.setString(1, bbsTitle);
	    		pstmt.setString(2, bbsContent);
	    		pstmt.setInt(3, bbsid);
	    		return pstmt.executeUpdate();
	    	} catch (Exception e) {
	    		e.printStackTrace();
    	}
    	return -1; // db 오류
    }
	    public int delete(int bbsID) {
	    	String SQL = "UPDATE BBS SET bbsAvailable = 0 where bbsID = ? ";
	    	try {
	    		PreparedStatement pstmt = conn.prepareStatement(SQL);
	    		pstmt.setInt(1, bbsID);
	    		return pstmt.executeUpdate();
	    	} catch (Exception e) {
	    		e.printStackTrace();
		}
    	return -1; // db 오류
    }
}	



