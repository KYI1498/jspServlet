package com.mobility.kyi.project2.dao;

import com.mobility.kyi.project2.dto.MemberDTO;
import com.mobility.kyi.project2.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MemberDAO {

    // =========================================================
    // 회원가입
    // =========================================================

    public boolean insert(MemberDTO member) {

        String sql =
                "INSERT INTO member " +
                        "(userid, password, name, tel, email, role, status) " +
                        "VALUES (?, ?, ?, ?, ?, 'MEMBER', 'ACTIVE')";

        try (
                Connection conn = DBUtil.getConnection();
                PreparedStatement pstmt =
                        conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, member.getUserid());
            pstmt.setString(2, member.getPassword());
            pstmt.setString(3, member.getName());
            pstmt.setString(4, member.getTel());
            pstmt.setString(5, member.getEmail());

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // 회원 전체 조회
    // =========================================================

    public List<MemberDTO> findAll() {

        List<MemberDTO> list = new ArrayList<>();

        String sql =
                "SELECT id, userid, password, name, tel, email, " +
                        "role, status " +
                        "FROM member " +
                        "ORDER BY id DESC";

        try (
                Connection conn = DBUtil.getConnection();
                PreparedStatement pstmt =
                        conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery()
        ) {

            while (rs.next()) {

                list.add(mapMember(rs));
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return list;
    }


    // =========================================================
    // 회원 ID 조회
    // =========================================================

    public MemberDTO findById(Long id) {

        String sql =
                "SELECT id, userid, password, name, tel, email, " +
                        "role, status " +
                        "FROM member " +
                        "WHERE id = ?";

        try (
                Connection conn = DBUtil.getConnection();
                PreparedStatement pstmt =
                        conn.prepareStatement(sql)
        ) {

            pstmt.setLong(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    return mapMember(rs);
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // userid 조회
    // =========================================================

    public MemberDTO findByUserid(String userid) {

        String sql =
                "SELECT id, userid, password, name, tel, email, " +
                        "role, status " +
                        "FROM member " +
                        "WHERE userid = ?";

        try (
                Connection conn = DBUtil.getConnection();
                PreparedStatement pstmt =
                        conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, userid);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    return mapMember(rs);
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // 회원 ID 중복 검사
    // =========================================================

    public boolean existsByUserid(String userid) {

        String sql =
                "SELECT COUNT(*) FROM member WHERE userid = ?";

        try (
                Connection conn = DBUtil.getConnection();
                PreparedStatement pstmt =
                        conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, userid);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // 일반회원 정보 수정
    // =========================================================

    public boolean update(MemberDTO member) {

        String sql =
                "UPDATE member " +
                        "SET name = ?, tel = ?, email = ?, " +
                        "updated_at = CURRENT_TIMESTAMP " +
                        "WHERE id = ?";

        try (
                Connection conn = DBUtil.getConnection();
                PreparedStatement pstmt =
                        conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, member.getName());
            pstmt.setString(2, member.getTel());
            pstmt.setString(3, member.getEmail());
            pstmt.setLong(4, member.getId());

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // 비밀번호 수정
    // =========================================================

    public boolean updatePassword(
            Long id,
            String password) {

        String sql =
                "UPDATE member " +
                        "SET password = ?, " +
                        "updated_at = CURRENT_TIMESTAMP " +
                        "WHERE id = ?";

        try (
                Connection conn = DBUtil.getConnection();
                PreparedStatement pstmt =
                        conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, password);
            pstmt.setLong(2, id);

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // 관리자 회원정보 수정
    // =========================================================

    public boolean adminUpdate(MemberDTO member) {

        String sql =
                "UPDATE member " +
                        "SET name = ?, tel = ?, email = ?, " +
                        "role = ?, status = ?, " +
                        "updated_at = CURRENT_TIMESTAMP " +
                        "WHERE id = ?";

        try (
                Connection conn = DBUtil.getConnection();
                PreparedStatement pstmt =
                        conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, member.getName());
            pstmt.setString(2, member.getTel());
            pstmt.setString(3, member.getEmail());
            pstmt.setString(4, member.getRole());
            pstmt.setString(5, member.getStatus());
            pstmt.setLong(6, member.getId());

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // 회원탈퇴 / 관리자 강퇴
    // =========================================================

    public boolean delete(Long id) {

        String sql =
                "DELETE FROM member WHERE id = ?";

        try (
                Connection conn = DBUtil.getConnection();
                PreparedStatement pstmt =
                        conn.prepareStatement(sql)
        ) {

            pstmt.setLong(1, id);

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // ResultSet → DTO
    // =========================================================

    private MemberDTO mapMember(ResultSet rs)
            throws SQLException {

        MemberDTO member = new MemberDTO();

        member.setId(rs.getLong("id"));
        member.setUserid(rs.getString("userid"));
        member.setPassword(rs.getString("password"));
        member.setName(rs.getString("name"));
        member.setTel(rs.getString("tel"));
        member.setEmail(rs.getString("email"));
        member.setRole(rs.getString("role"));
        member.setStatus(rs.getString("status"));

        return member;
    }
}