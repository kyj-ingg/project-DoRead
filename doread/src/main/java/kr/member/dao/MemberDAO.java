package kr.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import kr.member.vo.MemberVO;
import kr.util.DBUtil;

public class MemberDAO {
	private static MemberDAO instance = new MemberDAO();
	
	public static MemberDAO getInstance() {
		return instance;
	}
	private MemberDAO() {}
	
	//회원가입(등록)
	public void insertMember(MemberVO member)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		ResultSet rs = null;
		String sql = null;
		int num = 0;
		try {
			conn = DBUtil.getConnection();
			
			conn.setAutoCommit(false);
			
			//회원번호 생성
			sql = "SELECT member_seq.nextval FROM dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt(1);
			}
			
			sql = "INSERT INTO member (mem_num, mem_id) VALUES (?,?)";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, num);
			pstmt2.setString(2, member.getMem_id());
			pstmt2.executeUpdate();
			
			sql = "INSERT INTO member_detail (mem_num, mem_name, mem_pw, mem_phone, mem_email, mem_zipcode, mem_address1, mem_address2, book_category, book_category2, book_category3) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt3 = conn.prepareStatement(sql);
			
			pstmt3.setInt(1, num);
			pstmt3.setString(2, member.getMem_name());
			pstmt3.setString(3, member.getMem_pw());
			pstmt3.setString(4, member.getMem_phone());
			pstmt3.setString(5, member.getMem_email());
			pstmt3.setString(6, member.getMem_zipcode());
			pstmt3.setString(7, member.getMem_address1());
			pstmt3.setString(8, member.getMem_address2());
			if (member.getBook_category() != null) {
	            pstmt3.setInt(9, member.getBook_category());
			}else{
		        pstmt3.setNull(9, java.sql.Types.INTEGER);
		    }
			if(member.getBook_category2()!=null) {
	            pstmt3.setInt(10, member.getBook_category2());
			}else {
				pstmt3.setNull(10, java.sql.Types.INTEGER);
			}
			if(member.getBook_category3()!=null) {
	            pstmt3.setInt(11, member.getBook_category3());
			}else {
				pstmt3.setNull(11, java.sql.Types.INTEGER);
			}
			
			pstmt3.executeUpdate();
			conn.commit();
			
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt3, null);
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(rs, pstmt, conn);
		}
	}
	//아이디중복체크, 로그인
	public MemberVO checkMember(String id)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberVO member = null;
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT * FROM member LEFT OUTER JOIN member_detail USING(mem_num) WHERE mem_id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new MemberVO();
				member.setMem_num(rs.getInt("mem_num"));
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_auth(rs.getInt("mem_auth"));
				member.setMem_pw(rs.getString("mem_pw"));
				member.setMem_email(rs.getString("mem_email"));
				member.setMem_phone(rs.getString("mem_phone"));
				member.setMem_photo(rs.getString("mem_photo"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return member;
	}
	//아이디찾기
	public MemberVO findMemberID(String name, String email)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO member = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
		
			sql = "SELECT * FROM member LEFT OUTER JOIN member_detail USING(mem_num) WHERE mem_name=? AND mem_email=?";
				
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new MemberVO();
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_num(rs.getInt("mem_num"));
			}
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return member;
	}
	
	//이메일 중복체크
	public MemberVO checkEmail(String email)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberVO member = null;
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT * FROM member LEFT OUTER JOIN member_detail USING(mem_num) WHERE mem_email=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new MemberVO();
				member.setMem_num(rs.getInt("mem_num"));
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_auth(rs.getInt("mem_auth"));
				member.setMem_pw(rs.getString("mem_pw"));
				member.setMem_email(rs.getString("mem_email"));
				member.setMem_phone(rs.getString("mem_phone"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return member;
	}
	
	//전화번호 중복체크
	public MemberVO checkPhone(String phone)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberVO member = null;
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT * FROM member LEFT OUTER JOIN member_detail USING(mem_num) WHERE mem_phone=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, phone);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new MemberVO();
				member.setMem_num(rs.getInt("mem_num"));
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_auth(rs.getInt("mem_auth"));
				member.setMem_pw(rs.getString("mem_pw"));
				member.setMem_email(rs.getString("mem_email"));
				member.setMem_phone(rs.getString("mem_phone"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return member;
	}
	
	//비밀번호찾기-비밀번호 재설정
	public void resetPW(String passwd, int mem_num)throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			
			sql = "UPDATE member_detail SET mem_pw=? WHERE mem_num=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, passwd);
			pstmt.setInt(2, mem_num);
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//회원상세정보
	public MemberVO getMember(int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO member = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT * FROM member JOIN member_detail USING(mem_num) WHERE mem_num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new MemberVO();
				member.setMem_num(rs.getInt("mem_num"));
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_auth(rs.getInt("mem_auth"));
				member.setMem_name(rs.getString("mem_name"));
				member.setMem_phone(rs.getString("mem_phone"));
				member.setMem_email(rs.getString("mem_email"));
				member.setMem_zipcode(rs.getString("mem_zipcode"));
				member.setMem_address1(rs.getString("mem_address1"));
				member.setMem_address2(rs.getString("mem_address2"));
				member.setMem_photo(rs.getString("mem_photo"));
				member.setMem_rdate(rs.getDate("mem_rdate"));
				member.setMem_mdate(rs.getDate("mem_mdate"));
				Integer bookCategory = rs.getInt("book_category");
				if (rs.wasNull()) {
				    member.setBook_category(null); 
				} else {
				    member.setBook_category(bookCategory);
				}
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return member;
	}
	//회원정보수정
	public void updateMember(MemberVO member)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			
			sql = "UPDATE member_detail SET mem_name=?, mem_phone=?, mem_email=?, mem_zipcode=?, mem_address1=?, mem_address2=?, mem_mdate=SYSDATE WHERE mem_num=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMem_name());
			pstmt.setString(2, member.getMem_phone());
			pstmt.setString(3, member.getMem_email());
			pstmt.setString(4, member.getMem_zipcode());
			pstmt.setString(5, member.getMem_address1());
			pstmt.setString(6, member.getMem_address2());
			pstmt.setInt(7, member.getMem_num());
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//비밀번호 변경
	public void updatePassword(String passwd, int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			
			sql = "UPDATE member_detail SET mem_passwd=? WHERE mem_num=?";
			
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, passwd);
			pstmt.setInt(2, mem_num);
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//프로필 사진 수정
	public void updateMyPhoto(String mem_photo,int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "UPDATE member_detail SET mem_photo=? WHERE mem_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(1, mem_photo);
			pstmt.setInt(2, mem_num);
			//SQL문 실행
			pstmt.executeUpdate();			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//관심도서 카테고리 수정
	public void updateCategory(MemberVO member) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE member_detail SET book_category=?, book_category2=?, book_category3=? WHERE mem_num=?";
			
			pstmt = conn.prepareStatement(sql);
			if (member.getBook_category() != null) {
	            pstmt.setInt(1, member.getBook_category());
			}else{
		        pstmt.setNull(1, java.sql.Types.INTEGER);
		    }
			if(member.getBook_category2()!=null) {
	            pstmt.setInt(2, member.getBook_category2());
			}else {
				pstmt.setNull(2, java.sql.Types.INTEGER);
			}
			if(member.getBook_category3()!=null) {
	            pstmt.setInt(3, member.getBook_category3());
			}else {
				pstmt.setNull(3, java.sql.Types.INTEGER);
			}
			
			pstmt.setInt(4, member.getMem_num());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//회원 탈퇴(삭제)
	public void deleteMember(int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		PreparedStatement pstmt4 = null;
		PreparedStatement pstmt5 = null;
		PreparedStatement pstmt6 = null;
		PreparedStatement pstmt7 = null;
		PreparedStatement pstmt8 = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			
			conn.setAutoCommit(false);
			
			sql = "UPDATE member SET mem_auth=0 WHERE mem_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			pstmt.executeUpdate();
			
			sql = "DELETE FROM point WHERE mem_num=?";
			pstmt3 = conn.prepareStatement(sql);
			pstmt3.setInt(1, mem_num);
			pstmt3.executeUpdate();
			
			sql = "DELETE FROM qna WHERE mem_num=?";
			pstmt4 = conn.prepareStatement(sql);
			pstmt4.setInt(1, mem_num);
			pstmt4.executeUpdate();
			sql = "DELETE from used_comm_report where uc_num in (select uc_num FROM ub_comment WHERE u_num in (select u_num FROM usedbookboard WHERE mem_num=?))";
			pstmt7 = conn.prepareStatement(sql);
			pstmt7.setInt(1, mem_num);
			pstmt7.executeUpdate();
			sql = "DELETE FROM ub_comment WHERE u_num in (select u_num FROM usedbookboard WHERE mem_num=?)";
			pstmt6 = conn.prepareStatement(sql);
			pstmt6.setInt(1, mem_num);
			pstmt6.executeUpdate();
			sql = "DELETE used_report where u_num in (select u_num FROM usedbookboard WHERE mem_num=?)";
			pstmt8 = conn.prepareStatement(sql);
			pstmt8.setInt(1, mem_num);
			pstmt8.executeUpdate();
			sql = "DELETE FROM usedbookboard WHERE mem_num=?";
			pstmt5 = conn.prepareStatement(sql);
			pstmt5.setInt(1, mem_num);
			pstmt5.executeUpdate();
			
			sql = "DELETE FROM member_detail WHERE mem_num=?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, mem_num);
			pstmt2.executeUpdate();
			
			conn.commit();
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt8, null);
			DBUtil.executeClose(null, pstmt7, null);
			DBUtil.executeClose(null, pstmt6, null);
			DBUtil.executeClose(null, pstmt5, null);
			DBUtil.executeClose(null, pstmt4, null);
			DBUtil.executeClose(null, pstmt3, null);
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//관리자
	//회원수, 회원목록&검색목록, 회원등급수정/
}
