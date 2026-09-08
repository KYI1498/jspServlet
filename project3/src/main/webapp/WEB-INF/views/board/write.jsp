<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>글쓰기 - 게시판</title>

    <!-- Bootstrap 5 CSS -->
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>


<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- 네비게이션 -->
<nav class="navbar navbar-dark bg-dark">

    <div class="container">

        <a class="navbar-brand"
           href="${pageContext.request.contextPath}/list">

            Project2 Board

        </a>

    </div>

</nav>


<!-- 본문 -->
<div class="container py-5">

    <div class="row justify-content-center">

        <div class="col-lg-8">


            <div class="mb-4">

                <h2 class="fw-bold">
                    글쓰기
                </h2>

                <p class="text-muted">
                    새로운 게시글을 작성해주세요.
                </p>

            </div>


            <!-- 글쓰기 폼 -->
            <div class="card shadow-sm">

                <div class="card-body p-4">


                    <form method="post"
                          action="${pageContext.request.contextPath}/write">


                        <!-- 제목 -->
                        <div class="mb-3">

                            <label for="title"
                                   class="form-label fw-semibold">

                                제목

                            </label>

                            <input
                                    type="text"
                                    id="title"
                                    name="title"
                                    class="form-control"
                                    placeholder="제목을 입력하세요."
                                    maxlength="200"
                                    required>

                        </div>


                        <!-- 작성자 -->
                        <div class="mb-3">

                            <label for="writer"
                                   class="form-label fw-semibold">

                                작성자

                            </label>

                            <input
                                    type="text"
                                                class="form-control"
                                                value="${sessionScope.loginMember.userid}"
                                                readonly>

                        </div>


                        <!-- 내용 -->
                        <div class="mb-4">

                            <label for="content"
                                   class="form-label fw-semibold">

                                내용

                            </label>

                            <textarea
                                    id="content"
                                    name="content"
                                    class="form-control"
                                    rows="12"
                                    placeholder="내용을 입력하세요."
                                    required></textarea>

                        </div>


                        <!-- 버튼 -->
                        <div class="d-flex justify-content-end gap-2">

                            <a href="${pageContext.request.contextPath}/list"
                               class="btn btn-secondary">

                                취소

                            </a>


                            <button
                                    type="submit"
                                    class="btn btn-primary">

                                등록

                            </button>

                        </div>


                    </form>


                </div>

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