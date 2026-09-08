<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>회원관리</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>

<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<nav class="navbar navbar-dark bg-dark">

    <div class="container">

        <a
                class="navbar-brand"
                href="${pageContext.request.contextPath}/list">

            KYI Mobility

        </a>

        <span class="navbar-text text-white">
            관리자 회원관리
        </span>

    </div>

</nav>


<div class="container py-5">

    <div class="d-flex
                justify-content-between
                align-items-center
                mb-4">

        <div>

            <h2 class="fw-bold">
                회원관리
            </h2>

            <p class="text-muted">
                전체 회원을 관리합니다.
            </p>

        </div>

    </div>


    <div class="card shadow-sm">

        <div class="card-body p-0">

            <div class="table-responsive">

                <table
                        class="table table-hover mb-0">

                    <thead class="table-light">

                    <tr>

                        <th class="text-center">
                            번호
                        </th>

                        <th>
                            아이디
                        </th>

                        <th>
                            이름
                        </th>

                        <th>
                            전화번호
                        </th>

                        <th>
                            이메일
                        </th>

                        <th class="text-center">
                            권한
                        </th>

                        <th class="text-center">
                            상태
                        </th>

                        <th class="text-center">
                            관리
                        </th>

                    </tr>

                    </thead>


                    <tbody>

                    <c:if test="${empty memberList}">

                        <tr>

                            <td
                                    colspan="8"
                                    class="text-center py-5">

                                등록된 회원이 없습니다.

                            </td>

                        </tr>

                    </c:if>


                    <c:forEach
                            var="member"
                            items="${memberList}">

                        <tr>

                            <td class="text-center">
                                ${member.id}
                            </td>

                            <td>

                                <a
                                        href="${pageContext.request.contextPath}/member/detail?id=${member.id}"
                                        class="text-decoration-none">

                                    ${member.userid}

                                </a>

                            </td>

                            <td>
                                ${member.name}
                            </td>

                            <td>
                                ${member.tel}
                            </td>

                            <td>
                                ${member.email}
                            </td>

                            <td class="text-center">

                                <c:choose>

                                    <c:when test="${member.role == 'ADMIN'}">

                                        <span class="badge bg-danger">
                                            관리자
                                        </span>

                                    </c:when>

                                    <c:otherwise>

                                        <span class="badge bg-primary">
                                            일반회원
                                        </span>

                                    </c:otherwise>

                                </c:choose>

                            </td>


                            <td class="text-center">

                                <c:choose>

                                    <c:when test="${member.status == 'ACTIVE'}">

                                        <span class="badge bg-success">
                                            정상
                                        </span>

                                    </c:when>

                                    <c:otherwise>

                                        <span class="badge bg-secondary">
                                            정지
                                        </span>

                                    </c:otherwise>

                                </c:choose>

                            </td>


                            <td class="text-center">

                                <a
                                        href="${pageContext.request.contextPath}/member/detail?id=${member.id}"
                                        class="btn btn-sm btn-outline-primary">

                                    상세

                                </a>


                                <c:if test="${member.role != 'ADMIN'}">

                                    <form
                                            method="post"
                                            action="${pageContext.request.contextPath}/member/admin/delete"
                                            class="d-inline"
                                            onsubmit="return confirm('정말 해당 회원을 강퇴하시겠습니까?');">

                                        <input
                                                type="hidden"
                                                name="id"
                                                value="${member.id}">

                                        <button
                                                type="submit"
                                                class="btn btn-sm btn-outline-danger">

                                            강퇴

                                        </button>

                                    </form>

                                </c:if>

                            </td>

                        </tr>

                    </c:forEach>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</div>

</body>
</html>