<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>

<html lang="ko">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Project2</title>

<!-- Bootstrap 5 -->
<link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

</head>

<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- =========================================================
     메인 콘텐츠
========================================================= -->

<div class="container py-5">

<div class="text-center">


    <h1 class="fw-bold mb-3">

        SAT Mobility 홈페이지 구현

    </h1>


    <p class="text-muted mb-4">

        MBC 아카데미 컴퓨터 교육 수강생 김영인

    </p>


    <!-- 게시글 목록 -->

    <a
            href="${pageContext.request.contextPath}/list"
            class="btn btn-primary">

        게시글 목록

    </a>


    <!-- =====================================================
         로그인 전
    ====================================================== -->

    <c:if
            test="${empty sessionScope.loginMember}">

        <div class="mt-4">

            <p class="text-muted">

                GIT Mobility 서비스를 이용하려면 로그인해주세요.

            </p>

            <a
                    href="${pageContext.request.contextPath}/member/login"
                    class="btn btn-outline-primary me-2">

                로그인

            </a>


            <a
                    href="${pageContext.request.contextPath}/member/join"
                    class="btn btn-outline-secondary">

                회원가입

            </a>

        </div>

    </c:if>


    <!-- =====================================================
         로그인 후
    ====================================================== -->

    <c:if
            test="${not empty sessionScope.loginMember}">

        <div
                class="alert alert-success mt-4"
                role="alert">

            <strong>
                ${sessionScope.loginMember.name}님,
            </strong>

            환영합니다!

        </div>

    </c:if>


</div>


</div>

<!-- =========================================================
     Bootstrap JS
========================================================= -->

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>
