<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c"
           uri="jakarta.tags.core" %>

<!DOCTYPE html>

<html lang="ko">

<head>

    <meta charset="UTF-8">

    <title>상품 상세</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>


<body>


<jsp:include
        page="/WEB-INF/views/common/header.jsp"/>


<div class="container py-5">


    <h2 class="fw-bold mb-4">
        상품 상세
    </h2>


    <div class="card shadow-sm">

        <div class="card-body p-4">


            <h3>

                <c:out
                        value="${product.name}"/>

            </h3>


            <hr>


            <p>

                <strong>
                    상품 번호
                </strong>

                <br>

                ${product.id}

            </p>


            <p>

                <strong>
                    가격
                </strong>

                <br>

                ${product.price} 원

            </p>


            <p>

                <strong>
                    재고
                </strong>

                <br>

                ${product.stock}

            </p>


            <p>

                <strong>
                    상품 설명
                </strong>

            </p>


            <div
                    style="white-space: pre-wrap;
                           min-height: 150px;">

                <c:out
                        value="${product.description}"/>

            </div>


            <hr>


            <small class="text-muted">

                등록일:
                ${product.formattedCreatedAt}

                <br>

                수정일:
                ${product.formattedUpdatedAt}

            </small>

        </div>

    </div>


    <div class="mt-4">


        <a
                href="${pageContext.request.contextPath}/product/list"
                class="btn btn-secondary">

            목록

        </a>


        <c:if test="${sessionScope.loginRole eq 'ADMIN'}">


            <a
                    href="${pageContext.request.contextPath}/product/edit?id=${product.id}"
                    class="btn btn-primary">

                수정

            </a>


            <form
                    method="post"
                    action="${pageContext.request.contextPath}/product/delete"
                    class="d-inline">


                <input
                        type="hidden"
                        name="id"
                        value="${product.id}">


                <button
                        type="submit"
                        class="btn btn-danger"
                        onclick="return confirm('상품을 삭제하시겠습니까?');">

                    삭제

                </button>


            </form>


        </c:if>


    </div>

</div>


</body>

</html>