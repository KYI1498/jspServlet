        package com.mobility.kyi.project3.controller;

import com.mobility.kyi.project3.dto.MemberDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        /*
         * 로그인 여부 확인
         */
        if (session == null) {
            response.sendRedirect(
                    request.getContextPath() + "/member/login"
            );
            return;
        }

        /*
         * 로그인 회원 정보 확인
         */
        MemberDTO loginMember =
                (MemberDTO) session.getAttribute("loginMember");

        if (loginMember == null) {
            response.sendRedirect(
                    request.getContextPath() + "/member/login"
            );
            return;
        }

        /*
         * 관리자 권한 확인
         */
        if (!"ADMIN".equals(loginMember.getRole())) {
            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "관리자만 접근할 수 있습니다."
            );
            return;
        }

        /*
         * 관리자 대시보드 화면
         */
        request.setAttribute("loginMember", loginMember);

        request.getRequestDispatcher(
                "/WEB-INF/views/admin/dashboard.jsp"
        ).forward(request, response);
    }
}
