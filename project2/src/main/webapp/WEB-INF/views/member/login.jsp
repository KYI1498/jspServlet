<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>로그인 - GIT Mobility</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">
</head>

<body>

<!-- 공통 상단 메뉴 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- 페이지 본문 -->
<div class="container py-5"
     style="max-width: 500px;">

    <div class="text-center mb-4">

        <h2 class="fw-bold">
            GIT Mobility
        </h2>

        <p class="text-muted">
            로그인
        </p>

    </div>


    <% if (request.getAttribute("error") != null) { %>

    <div class="alert alert-danger">

        ${error}

    </div>

    <% } %>


    <div class="card shadow-sm">

        <div class="card-body p-4">

            <form method="post"
                  action="${pageContext.request.contextPath}/member/login">


                <div class="mb-3">

                    <label class="form-label">
                        아이디
                    </label>

                    <input
                            type="text"
                            name="userid"
                            class="form-control"
                            required>

                </div>


                <div class="mb-4">

                    <label class="form-label">
                        비밀번호
                    </label>

                    <input
                            type="password"
                            name="password"
                            class="form-control"
                            required>

                </div>


                <button
                        type="submit"
                        class="btn btn-primary w-100">

                    로그인

                </button>

            </form>


            <div class="text-center mt-4">

                <span class="text-muted">
                    아직 회원이 아니신가요?
                </span>

                <a
                        href="${pageContext.request.contextPath}/member/join"
                        class="ms-2">

                    회원가입

                </a>

            </div>

        </div>

    </div>

</div>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>
</html>