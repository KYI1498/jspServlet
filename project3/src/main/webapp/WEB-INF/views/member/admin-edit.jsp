<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>관리자 회원정보 수정</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>

<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<div class="container py-5"
     style="max-width: 700px;">

    <h2 class="fw-bold mb-4">
        관리자 회원정보 수정
    </h2>


    <form
            method="post"
            action="${pageContext.request.contextPath}/member/admin/edit">


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


        <div class="mb-3">

            <label class="form-label">
                권한
            </label>

            <select
                    name="role"
                    class="form-select">

                <option
                        value="MEMBER"
                        ${member.role == 'MEMBER' ? 'selected' : ''}>

                    일반회원

                </option>

                <option
                        value="ADMIN"
                        ${member.role == 'ADMIN' ? 'selected' : ''}>

                    관리자

                </option>

            </select>

        </div>


        <div class="mb-4">

            <label class="form-label">
                회원상태
            </label>

            <select
                    name="status"
                    class="form-select">

                <option
                        value="ACTIVE"
                        ${member.status == 'ACTIVE' ? 'selected' : ''}>

                    정상

                </option>

                <option
                        value="BLOCKED"
                        ${member.status == 'BLOCKED' ? 'selected' : ''}>

                    정지

                </option>

            </select>

        </div>


        <div class="d-flex gap-2">

            <button
                    type="submit"
                    class="btn btn-primary">

                저장

            </button>


            <a
                    href="${pageContext.request.contextPath}/member/detail?id=${member.id}"
                    class="btn btn-secondary">

                취소

            </a>

        </div>

    </form>

</div>

</body>
</html>