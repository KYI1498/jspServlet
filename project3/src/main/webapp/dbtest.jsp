<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DB 연결 테스트</title>
</head>
<body>

<h1>PostgreSQL DB 연결 테스트</h1>

<%
    String url = "jdbc:postgresql://localhost:5432/app";
    String username = "postgres";
    String password = "1004";

    Connection conn = null;

    try {
        Class.forName("org.postgresql.Driver");

        conn = DriverManager.getConnection(
            url,
            username,
            password
        );

        out.println("<h2>DB 연결 성공!</h2>");

    } catch (ClassNotFoundException e) {

        out.println("<h2>JDBC Driver를 찾을 수 없습니다.</h2>");
        e.printStackTrace();

    } catch (SQLException e) {

        out.println("<h2>DB 연결 실패!</h2>");
        out.println("<p>" + e.getMessage() + "</p>");

    } finally {

        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

</body>
</html>