<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>마이페이지</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>

<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container py-5"
     style="max-width: 800px;">

    <h2 class="fw-bold mb-4">
        마이페이지
    </h2>


    <div class="card shadow-sm">

        <div class="card-body">

            <table class="table">

                <tr>

                    <th style="width: 180px;">
                        회원번호
                    </th>

                    <td>
                        ${member.id}
                    </td>

                </tr>

                <tr>

                    <th>
                        아이디
                    </th>

                    <td>
                        ${member.userid}
                    </td>

                </tr>

                <tr>

                    <th>
                        이름
                    </th>

                    <td>
                        ${member.name}
                    </td>

                </tr>

                <tr>

                    <th>
                        전화번호
                    </th>

                    <td>
                        ${member.tel}
                    </td>

                </tr>

                <tr>

                    <th>
                        이메일
                    </th>

                    <td>
                        ${member.email}
                    </td>

                </tr>

                <tr>

                    <th>
                        회원등급
                    </th>

                    <td>
                        ${member.role}
                    </td>

                </tr>

                <tr>

                    <th>
                        회원상태
                    </th>

                    <td>
                        ${member.status}
                    </td>

                </tr>

            </table>


            <div class="d-flex gap-2">

                <a
                        href="${pageContext.request.contextPath}/member/edit"
                        class="btn btn-primary">

                    회원정보 수정

                </a>


                <form
                        method="post"
                        action="${pageContext.request.contextPath}/member/delete"
                        onsubmit="return confirm('정말 탈퇴하시겠습니까?');">

                    <button
                            type="submit"
                            class="btn btn-outline-danger">

                        회원탈퇴

                    </button>

                </form>

            </div>

        </div>

    </div>

</div>

</body>
</html>