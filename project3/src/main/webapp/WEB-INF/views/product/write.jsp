<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>

<html lang="ko">

<head>

    <meta charset="UTF-8">

    <title>상품 등록</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>


<body>


<jsp:include
        page="/WEB-INF/views/common/header.jsp"/>


<div class="container py-5">

    <div class="row justify-content-center">

        <div class="col-lg-8">


            <h2 class="fw-bold mb-4">
                상품 등록
            </h2>


            <form
                    method="post"
                    action="${pageContext.request.contextPath}/product/write">


                <div class="mb-3">

                    <label
                            for="name"
                            class="form-label">

                        상품명

                    </label>

                    <input
                            type="text"
                            id="name"
                            name="name"
                            class="form-control"
                            maxlength="200"
                            required>

                </div>


                <div class="mb-3">

                    <label
                            for="description"
                            class="form-label">

                        상품 설명

                    </label>

                    <textarea
                            id="description"
                            name="description"
                            class="form-control"
                            rows="8"></textarea>

                </div>


                <div class="mb-3">

                    <label
                            for="price"
                            class="form-label">

                        가격

                    </label>

                    <input
                            type="number"
                            id="price"
                            name="price"
                            class="form-control"
                            min="0"
                            step="0.01"
                            required>

                </div>


                <div class="mb-4">

                    <label
                            for="stock"
                            class="form-label">

                        재고

                    </label>

                    <input
                            type="number"
                            id="stock"
                            name="stock"
                            class="form-control"
                            min="0"
                            required>

                </div>


                <button
                        type="submit"
                        class="btn btn-primary">

                    상품 등록

                </button>


                <a
                        href="${pageContext.request.contextPath}/product/list"
                        class="btn btn-secondary">

                    취소

                </a>


            </form>

        </div>

    </div>

</div>


</body>

</html>