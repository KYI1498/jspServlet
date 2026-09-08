<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">

        <!-- 로고 / 메인 -->
        <a class="navbar-brand fw-bold"
           href="${pageContext.request.contextPath}/">
            KYI Mobility
        </a>

        <!-- 모바일 메뉴 버튼 -->
        <button class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#mainNavbar"
                aria-controls="mainNavbar"
                aria-expanded="false"
                aria-label="메뉴 열기">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="mainNavbar">

            <!-- 메인 메뉴 -->
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <!-- 홈 -->
                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/">
                        홈
                    </a>
                </li>

                <!-- 게시판 -->
                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/list">
                        게시판
                    </a>
                </li>
                <!-- 상품 : 로그인한 일반회원 + 관리자 -->
                    <c:if test="${not empty sessionScope.loginMember}">
                        <li class="nav-item">
                            <a class="nav-link"
                               href="${pageContext.request.contextPath}/product/list">
                                상품
                            </a>
                        </li>
                    </c:if>
                <!-- 관리자 메뉴 -->
                <c:if test="${sessionScope.loginMember.role == 'ADMIN'}">

                    <!-- 관리자 대시보드 -->
                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/admin/dashboard">
                            관리자 대시보드
                        </a>
                    </li>

                    <!-- 회원관리 -->
                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/member/list">
                            회원관리
                        </a>
                    </li>

                </c:if>

            </ul>

            <!-- 오른쪽 상단 메뉴 -->
            <div class="d-flex align-items-center gap-2">

                <!-- 로그인하지 않은 경우 -->
                <c:if test="${empty sessionScope.loginMember}">

                    <a href="${pageContext.request.contextPath}/member/login"
                       class="btn btn-outline-light btn-sm">
                        로그인
                    </a>

                    <a href="${pageContext.request.contextPath}/member/join"
                       class="btn btn-primary btn-sm">
                        회원가입
                    </a>

                </c:if>

                <!-- 로그인한 경우 -->
                <c:if test="${not empty sessionScope.loginMember}">

                    <!-- 사용자 이름 -->
                    <span class="text-white me-2">
                        ${sessionScope.loginMember.name}님
                    </span>

                    <!-- 관리자에게만 표시 -->
                    <c:if test="${sessionScope.loginMember.role == 'ADMIN'}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard"
                           class="btn btn-warning btn-sm">
                            대시보드
                        </a>
                    </c:if>

                    <!-- 마이페이지 -->
                    <a href="${pageContext.request.contextPath}/member/mypage"
                       class="btn btn-outline-light btn-sm">
                        마이페이지
                    </a>

                    <!-- 로그아웃 -->
                    <a href="${pageContext.request.contextPath}/member/logout"
                       class="btn btn-danger btn-sm">
                        로그아웃
                    </a>

                </c:if>

            </div>

        </div>
    </div>
</nav>

