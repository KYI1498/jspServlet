<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>글 수정 - 게시판</title>

    <!-- Bootstrap 5 CSS -->
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>


<body>


<jsp:include page="/WEB-INF/views/common/header.jsp" />


<!-- 본문 -->
<div class="container py-5">

    <div class="row justify-content-center">

        <div class="col-lg-8">


            <div class="mb-4">

                <h2 class="fw-bold">
                    글 수정
                </h2>

                <p class="text-muted">
                    게시글 내용을 수정해주세요.
                </p>

            </div>


            <!-- 수정 폼 -->
            <div class="card shadow-sm">

                <div class="card-body p-4">


                    <form method="post"
                          action="${pageContext.request.contextPath}/edit">


                        <!-- 게시글 ID -->
                        <input
                                type="hidden"
                                name="id"
                                value="${board.id}">


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
                                    value="${board.title}"
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
                                    id="writer"
                                    name="writer"
                                    class="form-control"
                                    value="${board.writer}"
                                    maxlength="50"
                                    required>

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
                                    required>${board.content}</textarea>

                        </div>


                        <!-- 버튼 -->
                        <div class="d-flex justify-content-between">


                            <a href="${pageContext.request.contextPath}/detail?id=${board.id}"
                               class="btn btn-secondary">

                                취소

                            </a>


                            <button
                                    type="submit"
                                    class="btn btn-primary">

                                수정 완료

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