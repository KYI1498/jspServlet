<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>회원 상세</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>

<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<div class="container py-5"
     style="max-width: 800px;">

    <h2 class="fw-bold mb-4">
        회원 상세정보
    </h2>


    <div class="card shadow-sm">

        <div class="card-body">

            <table class="table">

                <tr>

                    <th>
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
                        권한
                    </th>

                    <td>
                        ${member.role}
                    </td>

                </tr>


                <tr>

                    <th>
                        상태
                    </th>

                    <td>
                        ${member.status}
                    </td>

                </tr>

            </table>


            <div class="d-flex gap-2">

                <a
                        href="${pageContext.request.contextPath}/member/admin/edit?id=${member.id}"
                        class="btn btn-primary">

                    회원정보 수정

                </a>


                <c:if test="${member.role != 'ADMIN'}">

                    <form
                            method="post"
                            action="${pageContext.request.contextPath}/member/admin/delete"
                            onsubmit="return confirm('정말 강퇴하시겠습니까?');">

                        <input
                                type="hidden"
                                name="id"
                                value="${member.id}">

                        <button
                                type="submit"
                                class="btn btn-danger">

                            회원 강퇴

                        </button>

                    </form>

                </c:if>


                <a
                        href="${pageContext.request.contextPath}/member/list"
                        class="btn btn-secondary">

                    목록

                </a>

            </div>

        </div>

    </div>

</div>

</body>
</html>