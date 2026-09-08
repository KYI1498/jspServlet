<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>게시판</title>

    <!-- Bootstrap 5 CSS -->
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">
</head>

<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />


<!-- 본문 -->
<div class="container py-5">

    <div class="d-flex justify-content-between align-items-center mb-4">

        <div>
            <h2 class="fw-bold">게시글 목록</h2>
            <p class="text-muted mb-0">
                전체 게시글을 확인할 수 있습니다.
            </p>
        </div>

        <a href="${pageContext.request.contextPath}/write"
           class="btn btn-primary">
            + 글쓰기
        </a>

    </div>


    <!-- 게시글 테이블 -->
    <div class="card shadow-sm">

        <div class="card-body p-0">

            <div class="table-responsive">

                <table class="table table-hover mb-0">

                    <thead class="table-light">

                    <tr>
                        <th style="width: 80px;" class="text-center">
                            번호
                        </th>

                        <th>
                            제목
                        </th>

                        <th style="width: 120px;" class="text-center">
                            작성자
                        </th>

                        <th style="width: 180px;" class="text-center">
                            작성일
                        </th>

                        <th style="width: 160px;" class="text-center">
                            관리
                        </th>
                    </tr>

                    </thead>


                    <tbody>

                    <!-- 게시글이 없는 경우 -->
                    <c:if test="${empty boardList}">
                        <tr>
                            <td colspan="5"
                                class="text-center py-5 text-muted">

                                등록된 게시글이 없습니다.

                            </td>
                        </tr>

                    </c:if>


                    <!-- 게시글 출력 -->
                    <c:forEach var="board"
                               items="${boardList}">

                        <tr>

                            <td class="text-center">
                                ${board.id}
                            </td>


                            <td>

                                <a href="${pageContext.request.contextPath}/detail?id=${board.id}"
                                   class="text-decoration-none text-dark fw-semibold">

                                    ${board.title}

                                </a>

                            </td>


                            <td class="text-center">
                                ${board.writer}
                            </td>


                            <td class="text-center text-muted">

                                ${board.formattedCreatedAt}

                            </td>


                            <td class="text-center">

                                <c:if test="${
                                    sessionScope.loginMember.role eq 'ADMIN'
                                    or board.writer eq sessionScope.loginMember.userid
                                }">

                                    <a href="${pageContext.request.contextPath}/edit?id=${board.id}"
                                       class="btn btn-sm btn-outline-secondary">

                                        수정

                                    </a>


                                    <form method="post"
                                          action="${pageContext.request.contextPath}/delete"
                                          class="d-inline">

                                        <input type="hidden"
                                               name="id"
                                               value="${board.id}">

                                        <button type="submit"
                                                class="btn btn-sm btn-outline-danger"
                                                onclick="return confirm('정말 삭제하시겠습니까?');">

                                            삭제

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


<!-- Bootstrap JS -->
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>
</html>