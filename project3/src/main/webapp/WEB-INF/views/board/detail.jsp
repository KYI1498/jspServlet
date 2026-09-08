<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>${board.title} - 게시판</title>

    <!-- Bootstrap 5 CSS -->
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>


<body>


<jsp:include page="/WEB-INF/views/common/header.jsp" />


<!-- 본문 -->
<div class="container py-5">


    <!-- 제목 -->
    <div class="mb-4">

        <h2 class="fw-bold">
            ${board.title}
        </h2>

        <div class="text-muted">

            <span>
                작성자: ${board.writer}
            </span>

            <span class="mx-2">|</span>

            <span>
                작성일: ${board.formattedCreatedAt}
            </span>

        </div>

    </div>


    <!-- 게시글 내용 -->
    <div class="card shadow-sm mb-4">

        <div class="card-body">

            <div class="py-3"
                 style="min-height: 300px; white-space: pre-wrap;">

                ${board.content}

            </div>

        </div>

    </div>


    <!-- 버튼 -->
    <div class="d-flex justify-content-between">


        <!-- 목록 -->
        <a href="${pageContext.request.contextPath}/list"
           class="btn btn-secondary">

            목록

        </a>


        <c:if test="${
            sessionScope.loginMember.role eq 'ADMIN'
            or board.writer eq sessionScope.loginMember.userid
        }">

            <div>

                <a href="${pageContext.request.contextPath}/edit?id=${board.id}"
                   class="btn btn-outline-primary">

                    수정

                </a>


                <form method="post"
                      action="${pageContext.request.contextPath}/delete"
                      class="d-inline">

                    <input type="hidden"
                           name="id"
                           value="${board.id}">

                    <button type="submit"
                            class="btn btn-outline-danger"
                            onclick="return confirm('정말 삭제하시겠습니까?');">

                        삭제

                    </button>

                </form>

            </div>

        </c:if>

    </div>


</div>


<!-- Bootstrap JS -->
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>
</html>