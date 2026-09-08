package com.mobility.kyi.project3.dao;

import com.mobility.kyi.project3.dto.BoardDTO;
import com.mobility.kyi.project3.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
    //게시글 등록 void insert(BoardDTO dto)
    //게시글 목록 List<BoardDTO> findAll()
    //게시글 상세보기 BoardDTO findById(long id)
    //게시글 수정 void update(BoardDTO dto)
    //게시글 삭제 void delete(long id)

    //게시글 등록
    public void insert(BoardDTO dto) {
        String sql = "INSERT INTO board(title, content, writer) VALUES (?, ?, ?)";
        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        )
            {
                pstmt.setString(1, dto.getTitle()); //SQL문의 첫 번째 ? 의 값 대입
                pstmt.setString(2, dto.getContent()); //SQL문의 두 번째 ? 의 값 대입
                pstmt.setString(3, dto.getWriter()); //SQL문의 세 번째 ? 의 값 대입

                try {
                    pstmt.executeUpdate(); //INSERT, UPDATE, DELETE 문은 executeUpdate(); 활용
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    //게시글 목록
    public List<BoardDTO> findAll() { //리턴할 타입은 List<BoardDTO>
        String sql = "SELECT * FROM board ORDER BY id DESC"; //내림차순 정렬하여 게시글 목록 반환
        List<BoardDTO> boardList = new ArrayList<>();  //결과를 담아 리턴할 게시글 목록 저장 객체
        try (
                Connection conn = DBUtil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);
        )
        {
            try {
                ResultSet rs = pstmt.executeQuery(); //SELECT 문은 executeQuery(); 활용
                while(rs.next()) {
                    BoardDTO board = new BoardDTO();
                    board.setId(rs.getLong("id")); //"id"는 테이블의 컬럼 이름, setId()는 DTO의 셋터임
                    board.setTitle(rs.getString("title"));
                    board.setContent(rs.getString("content"));
                    board.setWriter(rs.getString("writer"));

                    Timestamp createdAt = rs.getTimestamp("created_at"); //널값 체크하기 위해서 임시 장소에 저장
                    Timestamp updatedAt = rs.getTimestamp("updated_at");

                    if(createdAt!=null) { //널값 체크
                        board.setCreatedAt(createdAt.toLocalDateTime()); //TimeStamp => LocalDateTime
                    }

                    if(updatedAt!=null) { //널값 체크
                        board.setUpdatedAt(updatedAt.toLocalDateTime());
                    }
                    boardList.add(board);
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return boardList;
    }

    //게시글 상세보기
    public BoardDTO findById(long id) {
        String sql = "SELECT * FROM board WHERE id=?"; //내림차순 정렬하여 게시글 목록 반환
        BoardDTO board = new BoardDTO();
        try (
                Connection conn = DBUtil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);
        )
        {
            try {
                pstmt.setLong(1, id);
                ResultSet rs = pstmt.executeQuery(); //SELECT 문은 executeQuery(); 활용
                if(rs.next()) {
                    board.setId(rs.getLong("id")); //"id"는 테이블의 컬럼 이름, setId()는 DTO의 셋터임
                    board.setTitle(rs.getString("title"));
                    board.setContent(rs.getString("content"));
                    board.setWriter(rs.getString("writer"));

                    Timestamp createdAt = rs.getTimestamp("created_at");
                    Timestamp updatedAt = rs.getTimestamp("updated_at");

                    if(createdAt!=null) {
                        board.setCreatedAt(createdAt.toLocalDateTime());
                    }

                    if(updatedAt!=null) {
                        board.setUpdatedAt(updatedAt.toLocalDateTime());
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return board;
    }

    //게시글 수정
    public void update(BoardDTO dto) {
        String sql = "UPDATE board SET title=?, content=? WHERE id=?";
        try (
                Connection conn = DBUtil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);
        )
        {
            pstmt.setString(1, dto.getTitle()); //SQL문의 첫 번째 ? 의 값 대입
            pstmt.setString(2, dto.getContent()); //SQL문의 두 번째 ? 의 값 대입
            pstmt.setLong(3, dto.getId()); //SQL문의 세 번째 ? 의 값 대입

            try {
                pstmt.executeUpdate(); //INSERT, UPDATE, DELETE 문은 executeUpdate(); 활용
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    //게시글 삭제
    public void delete(long id) {
        String sql = "DELETE FROM board WHERE id=?";
        try (
                Connection conn = DBUtil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);
        )
        {
            pstmt.setLong(1, id); //SQL문의 세 번째 ? 의 값 대입

            try {
                pstmt.executeUpdate(); //INSERT, UPDATE, DELETE 문은 executeUpdate(); 활용
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}