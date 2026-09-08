<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c"
           uri="jakarta.tags.core" %>

<!DOCTYPE html>

<html lang="ko">

<head>

    <meta charset="UTF-8">

    <title>상품 목록</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>


<body>


<jsp:include
        page="/WEB-INF/views/common/header.jsp"/>


<div class="container py-5">


    <div class="d-flex
                justify-content-between
                align-items-center
                mb-4">

        <div>

            <h2 class="fw-bold">
                상품 목록
            </h2>

            <p class="text-muted">
                등록된 상품을 확인할 수 있습니다.
            </p>

        </div>


        <c:if test="${sessionScope.loginRole eq 'ADMIN'}">

            <a
                    href="${pageContext.request.contextPath}/product/write"
                    class="btn btn-primary">

                + 상품 등록

            </a>

        </c:if>

    </div>


    <div class="card shadow-sm">

        <div class="card-body p-0">


            <table class="table table-hover mb-0">

                <thead class="table-light">

                <tr>

                    <th>번호</th>

                    <th>상품명</th>

                    <th>가격</th>

                    <th>재고</th>

                    <th>등록일</th>

                </tr>

                </thead>


                <tbody>


                <c:if test="${empty productList}">

                    <tr>

                        <td colspan="5"
                            class="text-center py-5">

                            등록된 상품이 없습니다.

                        </td>

                    </tr>

                </c:if>


                <c:forEach
                        var="product"
                        items="${productList}">

                    <tr>

                        <td>
                            ${product.id}
                        </td>


                        <td>

                            <a
                                    href="${pageContext.request.contextPath}/product/detail?id=${product.id}"
                                    class="text-decoration-none">

                                <c:out
                                        value="${product.name}"/>

                            </a>

                        </td>


                        <td>
                            ${product.price} 원
                        </td>


                        <td>
                            ${product.stock}
                        </td>


                        <td>
                            ${product.formattedCreatedAt}
                        </td>

                    </tr>

                </c:forEach>


                </tbody>

            </table>

        </div>

    </div>

</div>


</body>

</html>