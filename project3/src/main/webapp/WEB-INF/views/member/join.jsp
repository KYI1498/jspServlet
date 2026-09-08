<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>회원가입</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>

<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<div class="container py-5"
     style="max-width: 900px;">

    <div class="mb-4">

        <h2 class="fw-bold">
            회원가입
        </h2>

        <p class="text-muted">
            GIT Mobility 서비스 회원가입
        </p>

    </div>


    <!-- 오류 -->
    <% if (request.getAttribute("error") != null) { %>

    <div class="alert alert-danger">

        ${error}

    </div>

    <% } %>


    <!-- 회원 약관 -->

    <div class="card mb-4">

        <div class="card-header fw-bold">
            회원 약관
        </div>

        <div class="card-body"
             style="height: 220px; overflow-y: auto;">

            <h5>제1조 목적</h5>

            <p>
                본 약관은 GIT Mobility 서비스 이용과 관련하여
                회원의 권리와 의무를 규정하는 것을 목적으로 합니다.
            </p>

            <h5>제2조 회원가입</h5>

            <p>
                회원은 본 약관에 동의하고 필요한 정보를 입력함으로써
                회원가입을 신청할 수 있습니다.
            </p>

            <h5>제3조 개인정보</h5>

            <p>
                서비스 제공을 위하여 필요한 회원정보를 수집하며,
                수집된 정보는 서비스 운영 목적에 사용됩니다.
            </p>

            <h5>제4조 회원의 의무</h5>

            <p>
                회원은 자신의 계정을 타인에게 양도하거나
                부정한 목적으로 사용해서는 안 됩니다.
            </p>

        </div>

    </div>


    <form method="post"
          action="${pageContext.request.contextPath}/member/join">


        <!-- 약관 동의 -->

        <div class="form-check mb-4">

            <input
                    class="form-check-input"
                    type="checkbox"
                    name="agree"
                    value="Y"
                    id="agree"
                    required>

            <label class="form-check-label"
                   for="agree">

                회원 약관에 동의합니다.

            </label>

        </div>


        <!-- 아이디 -->

        <div class="mb-3">

            <label class="form-label">
                아이디 *
            </label>

            <input
                    type="text"
                    name="userid"
                    class="form-control"
                    required
                    maxlength="50">

        </div>


        <!-- 비밀번호 -->

        <div class="mb-3">

            <label class="form-label">
                비밀번호 *
            </label>

            <input
                    type="password"
                    name="password"
                    class="form-control"
                    required>

        </div>


        <!-- 이름 -->

        <div class="mb-3">

            <label class="form-label">
                이름 *
            </label>

            <input
                    type="text"
                    name="name"
                    class="form-control"
                    required
                    maxlength="50">

        </div>


        <!-- 전화번호 -->

        <div class="mb-3">

            <label class="form-label">
                전화번호
            </label>

            <input
                    type="text"
                    name="tel"
                    class="form-control">

        </div>


        <!-- 이메일 -->

        <div class="mb-4">

            <label class="form-label">
                이메일
            </label>

            <input
                    type="email"
                    name="email"
                    class="form-control">

        </div>


        <div class="d-flex gap-2">

            <button
                    type="submit"
                    class="btn btn-primary">

                회원가입

            </button>

            <a
                    href="${pageContext.request.contextPath}/member/login"
                    class="btn btn-outline-secondary">

                로그인

            </a>

        </div>

    </form>

</div>

</body>
</html>