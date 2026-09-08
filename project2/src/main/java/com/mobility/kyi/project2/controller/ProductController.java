package com.mobility.kyi.project2.controller;

import com.mobility.kyi.project2.dao.ProductDAO;
import com.mobility.kyi.project2.dto.MemberDTO;
import com.mobility.kyi.project2.dto.ProductDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/product/*")
public class ProductController
        extends HttpServlet {

    private ProductDAO productDAO;


    @Override
    public void init() {

        productDAO =
                new ProductDAO();
    }


    // =========================================================
    // GET
    // =========================================================
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding(
                "UTF-8"
        );


        String path =
                request.getPathInfo();


        if (path == null) {

            path = "/";
        }


        // 상품 목록
        if (path.equals("/") ||
                path.equals("/list")) {

            productList(
                    request,
                    response
            );

            return;
        }


        // 상품 상세
        if (path.equals("/detail")) {

            productDetail(
                    request,
                    response
            );

            return;
        }


        // 상품 등록 화면
        if (path.equals("/write")) {

            if (!isAdmin(
                    request,
                    response
            )) {

                return;
            }


            writeForm(
                    request,
                    response
            );

            return;
        }


        // 상품 수정 화면
        if (path.equals("/edit")) {

            if (!isAdmin(
                    request,
                    response
            )) {

                return;
            }


            editForm(
                    request,
                    response
            );

            return;
        }


        response.sendError(
                HttpServletResponse.SC_NOT_FOUND
        );
    }


    // =========================================================
    // POST
    // =========================================================
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding(
                "UTF-8"
        );


        String path =
                request.getPathInfo();


        if (path == null) {

            path = "/";
        }


        // 상품 등록
        if (path.equals("/write")) {

            if (!isAdmin(
                    request,
                    response
            )) {

                return;
            }


            write(
                    request,
                    response
            );

            return;
        }


        // 상품 수정
        if (path.equals("/edit")) {

            if (!isAdmin(
                    request,
                    response
            )) {

                return;
            }


            edit(
                    request,
                    response
            );

            return;
        }


        // 상품 삭제
        if (path.equals("/delete")) {

            if (!isAdmin(
                    request,
                    response
            )) {

                return;
            }


            delete(
                    request,
                    response
            );

            return;
        }


        response.sendError(
                HttpServletResponse.SC_NOT_FOUND
        );
    }


    // =========================================================
    // 상품 목록
    // =========================================================
    private void productList(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<ProductDTO> productList =
                productDAO.findAll();


        request.setAttribute(
                "productList",
                productList
        );


        request.getRequestDispatcher(
                "/WEB-INF/views/product/list.jsp"
        ).forward(
                request,
                response
        );
    }


    // =========================================================
    // 상품 상세
    // =========================================================
    private void productDetail(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        long id =
                getId(request);


        ProductDTO product =
                productDAO.findById(id);


        if (product == null) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "상품을 찾을 수 없습니다."
            );

            return;
        }


        request.setAttribute(
                "product",
                product
        );


        request.getRequestDispatcher(
                "/WEB-INF/views/product/detail.jsp"
        ).forward(
                request,
                response
        );
    }


    // =========================================================
    // 상품 등록 화면
    // =========================================================
    private void writeForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/WEB-INF/views/product/write.jsp"
        ).forward(
                request,
                response
        );
    }


    // =========================================================
    // 상품 등록
    // =========================================================
    private void write(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        ProductDTO product =
                createProduct(
                        request
                );


        productDAO.insert(
                product
        );


        response.sendRedirect(
                request.getContextPath()
                        + "/product/list"
        );
    }


    // =========================================================
    // 상품 수정 화면
    // =========================================================
    private void editForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        long id =
                getId(request);


        ProductDTO product =
                productDAO.findById(id);


        if (product == null) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "상품을 찾을 수 없습니다."
            );

            return;
        }


        request.setAttribute(
                "product",
                product
        );


        request.getRequestDispatcher(
                "/WEB-INF/views/product/edit.jsp"
        ).forward(
                request,
                response
        );
    }


    // =========================================================
    // 상품 수정
    // =========================================================
    private void edit(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        long id =
                getId(request);


        ProductDTO product =
                createProduct(
                        request
                );


        product.setId(id);


        productDAO.update(
                product
        );


        response.sendRedirect(
                request.getContextPath()
                        + "/product/detail?id="
                        + id
        );
    }


    // =========================================================
    // 상품 삭제
    // =========================================================
    private void delete(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        long id =
                getId(request);


        productDAO.delete(id);


        response.sendRedirect(
                request.getContextPath()
                        + "/product/list"
        );
    }


    // =========================================================
    // 요청값 → ProductDTO
    // =========================================================
    private ProductDTO createProduct(
            HttpServletRequest request) {

        String name =
                request.getParameter(
                        "name"
                );

        String description =
                request.getParameter(
                        "description"
                );

        String price =
                request.getParameter(
                        "price"
                );

        String stock =
                request.getParameter(
                        "stock"
                );


        ProductDTO product =
                new ProductDTO();


        product.setName(name);

        product.setDescription(
                description
        );

        product.setPrice(
                new BigDecimal(price)
        );

        product.setStock(
                Integer.parseInt(stock)
        );


        return product;
    }


    // =========================================================
    // id 파라미터 처리
    // =========================================================
    private long getId(
            HttpServletRequest request) {

        String id =
                request.getParameter("id");


        if (id == null ||
                id.isBlank()) {

            throw new IllegalArgumentException(
                    "상품 id가 없습니다."
            );
        }


        try {

            return Long.parseLong(id);

        } catch (NumberFormatException e) {

            throw new IllegalArgumentException(
                    "올바른 상품 id가 아닙니다."
            );
        }
    }


    // =========================================================
    // 관리자 확인
    // =========================================================
    private boolean isAdmin(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session =
                request.getSession(false);


        if (session == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/member/login"
            );

            return false;
        }


        MemberDTO loginMember =
                (MemberDTO)
                        session.getAttribute(
                                "loginMember"
                        );


        if (loginMember == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/member/login"
            );

            return false;
        }


        if (!"ADMIN".equals(
                loginMember.getRole()
        )) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "관리자만 사용할 수 있습니다."
            );

            return false;
        }


        return true;
    }
}