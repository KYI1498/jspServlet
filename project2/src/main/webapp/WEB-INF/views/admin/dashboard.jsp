<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>관리자 대시보드 - KYI Mobility</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>

<body>

<!-- ============================== -->
<!-- 공통 상단 메뉴 -->
<!-- ============================== -->

<jsp:include page="/WEB-INF/views/common/header.jsp" />


<!-- ============================== -->
<!-- 관리자 대시보드 -->
<!-- ============================== -->

<div class="container py-5">

    <!-- 페이지 제목 -->

    <div class="d-flex justify-content-between
                align-items-center mb-4">

        <div>
            <h2 class="fw-bold mb-1">
                관리자 대시보드
            </h2>

            <p class="text-muted mb-0">
                KYI Mobility 시스템 관리자 화면
            </p>
        </div>

        <div>

            <span class="badge bg-danger fs-6">
                ADMIN
            </span>

        </div>

    </div>


    <!-- 관리자 정보 -->

    <div class="card shadow-sm mb-4">

        <div class="card-header fw-bold">
            관리자 정보
        </div>

        <div class="card-body">

            <div class="row">

                <div class="col-md-4 mb-3">

                    <div class="text-muted small">
                        아이디
                    </div>

                    <div class="fw-bold">
                        ${loginMember.userid}
                    </div>

                </div>


                <div class="col-md-4 mb-3">

                    <div class="text-muted small">
                        이름
                    </div>

                    <div class="fw-bold">
                        ${loginMember.name}
                    </div>

                </div>


                <div class="col-md-4 mb-3">

                    <div class="text-muted small">
                        권한
                    </div>

                    <div class="fw-bold">
                        ${loginMember.role}
                    </div>

                </div>

            </div>

        </div>

    </div>


    <!-- 관리자 메뉴 -->

    <div class="row g-4">

        <!-- 회원관리 -->

        <div class="col-md-4">

            <div class="card h-100 shadow-sm">

                <div class="card-body">

                    <div class="mb-3">

                        <span class="fs-1">
                            👥
                        </span>

                    </div>

                    <h5 class="card-title fw-bold">
                        회원관리
                    </h5>

                    <p class="card-text text-muted">
                        회원 목록 조회, 회원정보 수정,
                        회원 강퇴 등의 기능을 관리합니다.
                    </p>

                    <a href="${pageContext.request.contextPath}/member/list"
                       class="btn btn-primary">

                        회원관리

                    </a>

                </div>

            </div>

        </div>

        <!-- 시스템관리 -->

        <div class="col-md-4">

            <div class="card h-100 shadow-sm">

                <div class="card-body">

                    <div class="mb-3">

                        <span class="fs-1">
                            ⚙️
                        </span>

                    </div>

                    <h5 class="card-title fw-bold">
                        시스템관리
                    </h5>

                    <p class="card-text text-muted">
                        사용자, 권한, 메뉴, 공통코드,
                        시스템 로그 등을 관리합니다.
                    </p>

                    <a href="#"
                       class="btn btn-outline-primary">

                        시스템관리

                    </a>

                </div>

            </div>

        </div>

        <!-- 상품 관리 -->
        <div class="col-md-4 mb-4">
            <div class="card h-100 shadow-sm">

                <div class="card-body">

                    <div style="font-size: 32px;">
                        📦
                    </div>

                    <h5 class="card-title mt-3">
                        상품관리
                    </h5>

                    <p class="card-text text-muted">
                        상품 등록, 조회, 수정, 삭제 및 재고를 관리합니다.
                    </p>

                    <a href="${pageContext.request.contextPath}/product/list"
                       class="btn btn-outline-primary">

                        상품관리

                    </a>

                </div>

            </div>

        </div>

    </div>

</div>


<!-- Bootstrap JS -->

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>