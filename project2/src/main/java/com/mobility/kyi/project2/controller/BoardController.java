package com.mobility.kyi.project2.controller;

import com.mobility.kyi.project2.dao.BoardDAO;
import com.mobility.kyi.project2.dto.BoardDTO;
import com.mobility.kyi.project2.dto.MemberDTO;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.mobility.kyi.project2.dto.MemberDTO;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/") //요청 주소 앞에 /project2
public class BoardController extends HttpServlet {
    private BoardDAO boardDAO;

    @Override
    public void init(ServletConfig config) throws ServletException {
        boardDAO = new BoardDAO();
    }

    //GET 요청 => doGet
    //<a href="localhost:8080/project2/">글 목록</a>
    //<a href="localhost:8080/project2/list">글 목록</a>
    //<a href="localhost:8080/project2/write">빈 글 등록폼</a>
    //<a href="localhost:8080/project2/detail?id=2">2번글 상세보기</a>
    //<a href="localhost:8080/project2/edit?id=2">2번 글 수정</a>
    //<a href="localhost:8080/project2/delete?id=2">2번글 삭제</a>
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if(path == null || "/".equals(path)) {
            list(req, resp);
        }

        switch (path) {
            case "/":
            case "/list":
                list(req, resp);
                break;
            case "/detail":
                detail(req, resp);
                break;
            case "/write":
                writeForm(req, resp);
                break;
            case "/edit":
                editForm(req, resp);
                break;
            case "/delete":
                delete(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<BoardDTO> boardList = boardDAO.findAll();
        req.setAttribute("boardList", boardList); //list.jsp => "boardList"
        //Dispatcher(배달부)
        req.getRequestDispatcher("/WEB-INF/views/board/list.jsp").forward(req, resp);
    }

    private void detail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long id = getId(req);
        BoardDTO board = boardDAO.findById(id);
        req.setAttribute("board", board); //detail.jsp => "board"
        //Dispatcher(배달부)
        req.getRequestDispatcher("/WEB-INF/views/board/detail.jsp").forward(req, resp);
    }

    private void editForm(
            HttpServletRequest req,
            HttpServletResponse resp
    ) throws ServletException, IOException {

        long id =
                getId(req);

        // 기존 게시글 조회
        BoardDTO board =
                boardDAO.findById(id);


        // 수정 권한 검사
        if (!canModify(req, board)) {

            resp.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "해당 게시글을 수정할 권한이 없습니다."
            );

            return;
        }


        // JSP에 기존 게시글 전달
        req.setAttribute(
                "board",
                board
        );


        // 수정 화면으로 이동
        req.getRequestDispatcher(
                "/WEB-INF/views/board/edit.jsp"
        ).forward(
                req,
                resp
        );
    }

    private void writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/board/write.jsp").forward(req, resp);
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        long id = getId(req);
        boardDAO.delete(id);
        resp.sendRedirect(req.getContextPath()+"/list");
    }

    private long getId(HttpServletRequest req) {
        String isParameter = req.getParameter("id");
        if(isParameter == null || isParameter.isBlank()) {
            throw new IllegalArgumentException("id 파라미터가 없습니다.");
        }

        try {
            return Long.parseLong(isParameter);
        } catch (NumberFormatException e) {
            throw new RuntimeException("id가 올바르지 않습니다.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        switch (path) {
            case "/write":
                write(req, resp);
                break;
            case "/edit":
                edit(req, resp);
                break;
            case "/delete":
                delete(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    /*
<form method="post" action="${pageContext.request.contextPath}/project2/write">

    <input type="text" name="title">

    <textarea name="content"></textarea>

    <input type="text" name="writer">

    <button type="submit">등록</button>

</form>

    */

    private void write(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session =
                req.getSession(false);

        if (session == null) {

            resp.sendRedirect(
                    req.getContextPath()
                            + "/member/login"
            );

            return;
        }


        MemberDTO loginMember =
                (MemberDTO)
                        session.getAttribute(
                                "loginMember"
                        );


        if (loginMember == null) {

            resp.sendRedirect(
                    req.getContextPath()
                            + "/member/login"
            );

            return;
        }


        //localhost:8080/project2/write?title=...&content=....&writer=admin
        /*
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        String writer = req.getParameter("writer");

        BoardDTO dto = new BoardDTO();
        dto.setTitle(title);
        dto.setContent(content);
        dto.setWriter(writer);
        */
        BoardDTO dto = new BoardDTO();
        dto.setTitle(req.getParameter("title"));
        dto.setContent(req.getParameter("content"));
        // 핵심
        dto.setWriter(
                loginMember.getUserid()
        );


        boardDAO.insert(dto);


        resp.sendRedirect(
                req.getContextPath()
                        + "/list"
        );
    }


    private void edit(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        //localhost:8080/project2/write?title=...&content=....
        BoardDTO dto = new BoardDTO();
        Long id = Long.parseLong(req.getParameter("id"));
        dto.setId(id);
        dto.setTitle(req.getParameter("title"));
        dto.setContent(req.getParameter("content"));
        boardDAO.update(dto);
        resp.sendRedirect(req.getContextPath()+"/list");
    }
    private boolean canModify(
            HttpServletRequest req,
            BoardDTO board
    ) {

        HttpSession session =
                req.getSession(false);

        if (session == null) {
            return false;
        }

        MemberDTO loginMember =
                (MemberDTO)
                        session.getAttribute(
                                "loginMember"
                        );

        if (loginMember == null) {
            return false;
        }

        // 관리자는 모든 글 수정/삭제 가능
        if ("ADMIN".equals(
                loginMember.getRole()
        )) {
            return true;
        }

        // 일반회원은 자기 글만 가능
        return loginMember.getUserid()
                .equals(board.getWriter());
    }

}