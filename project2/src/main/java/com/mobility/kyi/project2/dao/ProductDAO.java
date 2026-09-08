package com.mobility.kyi.project2.dao;

import com.mobility.kyi.project2.dto.ProductDTO;
import com.mobility.kyi.project2.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // =========================================================
    // 상품 등록
    // =========================================================
    public boolean insert(ProductDTO product) {

        String sql =
                "INSERT INTO product " +
                        "(name, description, price, stock) " +
                        "VALUES (?, ?, ?, ?)";

        try (
                Connection conn = DBUtil.getConnection();
                PreparedStatement pstmt =
                        conn.prepareStatement(sql)
        ) {

            pstmt.setString(
                    1,
                    product.getName()
            );

            pstmt.setString(
                    2,
                    product.getDescription()
            );

            pstmt.setBigDecimal(
                    3,
                    product.getPrice()
            );

            pstmt.setInt(
                    4,
                    product.getStock()
            );

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // 상품 전체 목록
    // =========================================================
    public List<ProductDTO> findAll() {

        List<ProductDTO> productList =
                new ArrayList<>();

        String sql =
                "SELECT id, name, description, price, stock, " +
                        "created_at, updated_at " +
                        "FROM product " +
                        "ORDER BY id DESC";

        try (
                Connection conn =
                        DBUtil.getConnection();

                PreparedStatement pstmt =
                        conn.prepareStatement(sql);

                ResultSet rs =
                        pstmt.executeQuery()
        ) {

            while (rs.next()) {

                ProductDTO product =
                        mapProduct(rs);

                productList.add(product);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return productList;
    }


    // =========================================================
    // 상품 한 개 조회
    // =========================================================
    public ProductDTO findById(long id) {

        String sql =
                "SELECT id, name, description, price, stock, " +
                        "created_at, updated_at " +
                        "FROM product " +
                        "WHERE id = ?";

        try (
                Connection conn =
                        DBUtil.getConnection();

                PreparedStatement pstmt =
                        conn.prepareStatement(sql)
        ) {

            pstmt.setLong(1, id);

            try (
                    ResultSet rs =
                            pstmt.executeQuery()
            ) {

                if (rs.next()) {
                    return mapProduct(rs);
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // 상품 수정
    // =========================================================
    public boolean update(ProductDTO product) {

        String sql =
                "UPDATE product " +
                        "SET name = ?, " +
                        "description = ?, " +
                        "price = ?, " +
                        "stock = ?, " +
                        "updated_at = CURRENT_TIMESTAMP " +
                        "WHERE id = ?";

        try (
                Connection conn =
                        DBUtil.getConnection();

                PreparedStatement pstmt =
                        conn.prepareStatement(sql)
        ) {

            pstmt.setString(
                    1,
                    product.getName()
            );

            pstmt.setString(
                    2,
                    product.getDescription()
            );

            pstmt.setBigDecimal(
                    3,
                    product.getPrice()
            );

            pstmt.setInt(
                    4,
                    product.getStock()
            );

            pstmt.setLong(
                    5,
                    product.getId()
            );

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // 상품 삭제
    // =========================================================
    public boolean delete(long id) {

        String sql =
                "DELETE FROM product " +
                        "WHERE id = ?";

        try (
                Connection conn =
                        DBUtil.getConnection();

                PreparedStatement pstmt =
                        conn.prepareStatement(sql)
        ) {

            pstmt.setLong(
                    1,
                    id
            );

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // ResultSet → ProductDTO
    // =========================================================
    private ProductDTO mapProduct(
            ResultSet rs
    ) throws SQLException {

        ProductDTO product =
                new ProductDTO();

        product.setId(
                rs.getLong("id")
        );

        product.setName(
                rs.getString("name")
        );

        product.setDescription(
                rs.getString("description")
        );

        product.setPrice(
                rs.getBigDecimal("price")
        );

        product.setStock(
                rs.getInt("stock")
        );


        Timestamp createdAt =
                rs.getTimestamp(
                        "created_at"
                );

        Timestamp updatedAt =
                rs.getTimestamp(
                        "updated_at"
                );


        if (createdAt != null) {

            product.setCreatedAt(
                    createdAt.toLocalDateTime()
            );
        }


        if (updatedAt != null) {

            product.setUpdatedAt(
                    updatedAt.toLocalDateTime()
            );
        }


        return product;
    }
}