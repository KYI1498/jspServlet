package com.mobility.kyi.project3.controller;

import com.mobility.kyi.project3.dao.MemberDAO;
import com.mobility.kyi.project3.dto.MemberDTO;
import com.mobility.kyi.project3.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/member/*")
public class MemberController extends HttpServlet {

    private MemberDAO memberDAO;

    @Override
    public void init() {

        memberDAO = new MemberDAO();
    }


    // =========================================================
    // GET
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String path =
                request.getPathInfo();

        if (path == null) {
            path = "/";
        }


        // 회원가입
        if (path.equals("/join")) {

            request.getRequestDispatcher(
                    "/WEB-INF/views/member/join.jsp"
            ).forward(request, response);

            return;
        }


        // 로그인
        if (path.equals("/login")) {

            request.getRequestDispatcher(
                    "/WEB-INF/views/member/login.jsp"
            ).forward(request, response);

            return;
        }


        // 로그아웃
        if (path.equals("/logout")) {

            logout(request, response);

            return;
        }


        // 마이페이지
        if (path.equals("/mypage")) {

            mypage(request, response);

            return;
        }


        // 회원정보 수정 화면
        if (path.equals("/edit")) {

            editForm(request, response);

            return;
        }


        // 관리자 회원 목록
        if (path.equals("/list")) {

            if (!isAdmin(request, response)) {
                return;
            }

            memberList(request, response);

            return;
        }


        // 관리자 회원 상세
        if (path.equals("/detail")) {

            if (!isAdmin(request, response)) {
                return;
            }

            memberDetail(request, response);

            return;
        }


        // 관리자 회원 수정
        if (path.equals("/admin/edit")) {

            if (!isAdmin(request, response)) {
                return;
            }

            adminEditForm(request, response);

            return;
        }


        response.sendError(
                HttpServletResponse.SC_NOT_FOUND
        );
    }


    // =========================================================
    // POST
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String path =
                request.getPathInfo();

        if (path == null) {
            path = "/";
        }


        // 회원가입
        if (path.equals("/join")) {

            join(request, response);

            return;
        }


        // 로그인
        if (path.equals("/login")) {

            login(request, response);

            return;
        }


        // 일반회원 정보수정
        if (path.equals("/edit")) {

            edit(request, response);

            return;
        }


        // 회원탈퇴
        if (path.equals("/delete")) {

            delete(request, response);

            return;
        }


        // 관리자 정보수정
        if (path.equals("/admin/edit")) {

            if (!isAdmin(request, response)) {
                return;
            }

            adminEdit(request, response);

            return;
        }


        // 관리자 강퇴
        if (path.equals("/admin/delete")) {

            if (!isAdmin(request, response)) {
                return;
            }

            adminDelete(request, response);

            return;
        }


        response.sendError(
                HttpServletResponse.SC_NOT_FOUND
        );
    }


    // =========================================================
    // 회원가입
    // =========================================================

    private void join(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, ServletException {

        String userid =
                request.getParameter("userid");

        String password =
                request.getParameter("password");

        String name =
                request.getParameter("name");

        String tel =
                request.getParameter("tel");

        String email =
                request.getParameter("email");

        String agree =
                request.getParameter("agree");


        if (!"Y".equals(agree)) {

            request.setAttribute(
                    "error",
                    "회원 약관에 동의해야 합니다."
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/member/join.jsp"
            ).forward(request, response);

            return;
        }


        if (userid == null ||
                userid.isBlank() ||
                password == null ||
                password.isBlank() ||
                name == null ||
                name.isBlank()) {

            request.setAttribute(
                    "error",
                    "필수 입력값을 확인해주세요."
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/member/join.jsp"
            ).forward(request, response);

            return;
        }


        if (memberDAO.existsByUserid(userid)) {

            request.setAttribute(
                    "error",
                    "이미 사용 중인 아이디입니다."
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/member/join.jsp"
            ).forward(request, response);

            return;
        }


        MemberDTO member = new MemberDTO();

        member.setUserid(userid);

        // 비밀번호 해시
        member.setPassword(
                PasswordUtil.hash(password)
        );

        member.setName(name);
        member.setTel(tel);
        member.setEmail(email);


        boolean result =
                memberDAO.insert(member);


        if (result) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/member/login"
            );

        } else {

            request.setAttribute(
                    "error",
                    "회원가입에 실패했습니다."
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/member/join.jsp"
            ).forward(request, response);
        }
    }


    // =========================================================
    // 로그인
    // =========================================================

    private void login(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, ServletException {

        String userid =
                request.getParameter("userid");

        String password =
                request.getParameter("password");


        MemberDTO member =
                memberDAO.findByUserid(userid);


        if (member == null ||
                !"ACTIVE".equals(member.getStatus()) ||
                !PasswordUtil.verify(
                        password,
                        member.getPassword())) {

            request.setAttribute(
                    "error",
                    "아이디 또는 비밀번호가 올바르지 않습니다."
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/member/login.jsp"
            ).forward(request, response);

            return;
        }


        HttpSession session =
                request.getSession();

        session.setAttribute(
                "loginMember",
                member
        );

        session.setAttribute(
                "loginUserId",
                member.getUserid()
        );

        session.setAttribute(
                "loginRole",
                member.getRole()
        );


        response.sendRedirect(
                request.getContextPath()
                        + "/list"
        );
    }


    // =========================================================
    // 로그아웃
    // =========================================================

    private void logout(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session =
                request.getSession(false);

        if (session != null) {
            session.invalidate();
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/"
        );
    }


    // =========================================================
    // 마이페이지
    // =========================================================

    private void mypage(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        MemberDTO loginMember =
                getLoginMember(request);

        if (loginMember == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/member/login"
            );

            return;
        }


        MemberDTO member =
                memberDAO.findById(
                        loginMember.getId()
                );


        request.setAttribute(
                "member",
                member
        );

        request.getRequestDispatcher(
                "/WEB-INF/views/member/mypage.jsp"
        ).forward(request, response);
    }


    // =========================================================
    // 회원정보 수정 화면
    // =========================================================

    private void editForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        MemberDTO loginMember =
                getLoginMember(request);

        if (loginMember == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/member/login"
            );

            return;
        }


        MemberDTO member =
                memberDAO.findById(
                        loginMember.getId()
                );


        request.setAttribute(
                "member",
                member
        );

        request.getRequestDispatcher(
                "/WEB-INF/views/member/edit.jsp"
        ).forward(request, response);
    }


    // =========================================================
    // 회원정보 수정
    // =========================================================

    private void edit(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        MemberDTO loginMember =
                getLoginMember(request);

        if (loginMember == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/member/login"
            );

            return;
        }


        String name =
                request.getParameter("name");

        String tel =
                request.getParameter("tel");

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");


        MemberDTO member = new MemberDTO();

        member.setId(loginMember.getId());
        member.setName(name);
        member.setTel(tel);
        member.setEmail(email);


        memberDAO.update(member);


        // 비밀번호 입력 시 비밀번호도 변경
        if (password != null &&
                !password.isBlank()) {

            memberDAO.updatePassword(
                    loginMember.getId(),
                    PasswordUtil.hash(password)
            );
        }


        response.sendRedirect(
                request.getContextPath()
                        + "/member/mypage"
        );
    }


    // =========================================================
    // 회원탈퇴
    // =========================================================

    private void delete(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        MemberDTO loginMember =
                getLoginMember(request);

        if (loginMember == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/member/login"
            );

            return;
        }


        memberDAO.delete(
                loginMember.getId()
        );


        HttpSession session =
                request.getSession(false);

        if (session != null) {
            session.invalidate();
        }


        response.sendRedirect(
                request.getContextPath()
                        + "/"
        );
    }


    // =========================================================
    // 관리자 회원목록
    // =========================================================

    private void memberList(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<MemberDTO> memberList =
                memberDAO.findAll();


        request.setAttribute(
                "memberList",
                memberList
        );


        request.getRequestDispatcher(
                "/WEB-INF/views/member/list.jsp"
        ).forward(request, response);
    }


    // =========================================================
    // 관리자 회원 상세
    // =========================================================

    private void memberDetail(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String id =
                request.getParameter("id");


        if (id == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/member/list"
            );

            return;
        }


        MemberDTO member =
                memberDAO.findById(
                        Long.parseLong(id)
                );


        request.setAttribute(
                "member",
                member
        );


        request.getRequestDispatcher(
                "/WEB-INF/views/member/detail.jsp"
        ).forward(request, response);
    }


    // =========================================================
    // 관리자 회원 수정 화면
    // =========================================================

    private void adminEditForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String id =
                request.getParameter("id");


        if (id == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/member/list"
            );

            return;
        }


        MemberDTO member =
                memberDAO.findById(
                        Long.parseLong(id)
                );


        request.setAttribute(
                "member",
                member
        );


        request.getRequestDispatcher(
                "/WEB-INF/views/member/edit.jsp"
        ).forward(request, response);
    }


    // =========================================================
    // 관리자 회원정보 수정
    // =========================================================

    private void adminEdit(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        Long id =
                Long.parseLong(
                        request.getParameter("id")
                );


        MemberDTO member =
                memberDAO.findById(id);


        if (member == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/member/list"
            );

            return;
        }


        member.setName(
                request.getParameter("name")
        );

        member.setTel(
                request.getParameter("tel")
        );

        member.setEmail(
                request.getParameter("email")
        );

        member.setRole(
                request.getParameter("role")
        );

        member.setStatus(
                request.getParameter("status")
        );


        memberDAO.adminUpdate(member);


        response.sendRedirect(
                request.getContextPath()
                        + "/member/detail?id="
                        + id
        );
    }


    // =========================================================
    // 관리자 강퇴
    // =========================================================

    private void adminDelete(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        Long id =
                Long.parseLong(
                        request.getParameter("id")
                );


        MemberDTO target =
                memberDAO.findById(id);


        // 관리자 자신을 삭제하지 못하도록 방어
        MemberDTO loginMember =
                getLoginMember(request);


        if (loginMember != null &&
                loginMember.getId().equals(id)) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/member/list"
            );

            return;
        }


        if (target != null &&
                "ADMIN".equals(target.getRole())) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/member/list"
            );

            return;
        }


        memberDAO.delete(id);


        response.sendRedirect(
                request.getContextPath()
                        + "/member/list"
        );
    }


    // =========================================================
    // 로그인 회원 가져오기
    // =========================================================

    private MemberDTO getLoginMember(
            HttpServletRequest request) {

        HttpSession session =
                request.getSession(false);

        if (session == null) {
            return null;
        }

        return (MemberDTO)
                session.getAttribute(
                        "loginMember"
                );
    }


    // =========================================================
    // 관리자 여부 확인
    // =========================================================

    private boolean isAdmin(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        MemberDTO member =
                getLoginMember(request);


        if (member == null ||
                !"ADMIN".equals(member.getRole())) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "관리자만 접근할 수 있습니다."
            );

            return false;
        }

        return true;
    }
}