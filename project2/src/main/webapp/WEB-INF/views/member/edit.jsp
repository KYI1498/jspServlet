<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>회원정보 수정</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>

<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<div class="container py-5"
     style="max-width: 700px;">

    <h2 class="fw-bold mb-4">
        회원정보 수정
    </h2>


    <form
            method="post"
            action="${pageContext.request.contextPath}/member/edit">


        <input
                type="hidden"
                name="id"
                value="${member.id}">


        <div class="mb-3">

            <label class="form-label">
                아이디
            </label>

            <input
                    type="text"
                    class="form-control"
                    value="${member.userid}"
                    readonly>

        </div>


        <div class="mb-3">

            <label class="form-label">
                이름
            </label>

            <input
                    type="text"
                    name="name"
                    class="form-control"
                    value="${member.name}"
                    required>

        </div>


        <div class="mb-3">

            <label class="form-label">
                전화번호
            </label>

            <input
                    type="text"
                    name="tel"
                    class="form-control"
                    value="${member.tel}">

        </div>


        <div class="mb-3">

            <label class="form-label">
                이메일
            </label>

            <input
                    type="email"
                    name="email"
                    class="form-control"
                    value="${member.email}">

        </div>


        <hr>


        <div class="mb-4">

            <label class="form-label">
                새 비밀번호
            </label>

            <input
                    type="password"
                    name="password"
                    class="form-control">

            <div class="form-text">
                변경하지 않으려면 비워두세요.
            </div>

        </div>


        <div class="d-flex gap-2">

            <button
                    type="submit"
                    class="btn btn-primary">

                저장

            </button>


            <a
                    href="${pageContext.request.contextPath}/member/mypage"
                    class="btn btn-secondary">

                취소

            </a>

        </div>

    </form>

</div>

</body>
</html>