<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");

    // ==========================================
    // PostgreSQL DB 연결 정보
    // ==========================================

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

        // ==========================================
        // CRUD 처리
        // ==========================================

        String action = request.getParameter("action");


        // ------------------------------------------
        // CREATE
        // ------------------------------------------

        if ("insert".equals(action)) {

            int no = Integer.parseInt(
                request.getParameter("no")
            );

            String name = request.getParameter("name");

            String sql =
                "INSERT INTO test(no, name) VALUES (?, ?)";

            try (PreparedStatement pstmt =
                     conn.prepareStatement(sql)) {

                pstmt.setInt(1, no);
                pstmt.setString(2, name);

                pstmt.executeUpdate();
            }
        }


        // ------------------------------------------
        // UPDATE
        // ------------------------------------------

        else if ("update".equals(action)) {

            int no = Integer.parseInt(
                request.getParameter("no")
            );

            String name = request.getParameter("name");

            String sql =
                "UPDATE test SET name = ? WHERE no = ?";

            try (PreparedStatement pstmt =
                     conn.prepareStatement(sql)) {

                pstmt.setString(1, name);
                pstmt.setInt(2, no);

                pstmt.executeUpdate();
            }
        }


        // ------------------------------------------
        // DELETE
        // ------------------------------------------

        else if ("delete".equals(action)) {

            int no = Integer.parseInt(
                request.getParameter("no")
            );

            String sql =
                "DELETE FROM test WHERE no = ?";

            try (PreparedStatement pstmt =
                     conn.prepareStatement(sql)) {

                pstmt.setInt(1, no);

                pstmt.executeUpdate();
            }
        }

    } catch (Exception e) {

        out.println("<h2>오류가 발생했습니다.</h2>");
        out.println("<pre>");
        e.printStackTrace();
        out.println("</pre>");

    }
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Test CRUD</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }

        h1 {
            margin-bottom: 30px;
        }

        h2 {
            margin-top: 30px;
        }

        table {
            border-collapse: collapse;
            width: 500px;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #999;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #eeeeee;
        }

        form {
            margin: 10px 0;
        }

        input {
            padding: 6px;
            margin-right: 5px;
        }

        button {
            padding: 6px 12px;
        }

        .box {
            border: 1px solid #ddd;
            padding: 20px;
            width: 500px;
            margin-bottom: 20px;
        }

    </style>

</head>

<body>

<h1>Test 테이블 CRUD</h1>


<!-- ==========================================
     CREATE
========================================== -->

<div class="box">

    <h2>1. Create - 데이터 추가</h2>

    <form method="post" action="test.jsp">

        <input
            type="hidden"
            name="action"
            value="insert"
        >

        번호:
        <input
            type="number"
            name="no"
            required
        >

        이름:
        <input
            type="text"
            name="name"
            required
        >

        <button type="submit">
            추가
        </button>

    </form>

</div>


<!-- ==========================================
     READ
========================================== -->

<div class="box">

    <h2>2. Read - 데이터 조회</h2>

    <table>

        <tr>
            <th>번호</th>
            <th>이름</th>
        </tr>

        <%

            String selectSql =
                "SELECT no, name FROM test ORDER BY no";

            try (PreparedStatement pstmt =
                     conn.prepareStatement(selectSql);

                 ResultSet rs =
                     pstmt.executeQuery()) {

                while (rs.next()) {

                    int no = rs.getInt("no");
                    String name = rs.getString("name");

        %>

        <tr>

            <td>
                <%= no %>
            </td>

            <td>
                <%= name %>
            </td>

        </tr>

        <%

                }

            } catch (SQLException e) {

                out.println(
                    "<tr><td colspan='2'>" +
                    e.getMessage() +
                    "</td></tr>"
                );
            }

        %>

    </table>

</div>


<!-- ==========================================
     UPDATE
========================================== -->

<div class="box">

    <h2>3. Update - 데이터 수정</h2>

    <form method="post" action="test.jsp">

        <input
            type="hidden"
            name="action"
            value="update"
        >

        번호:
        <input
            type="number"
            name="no"
            required
        >

        변경할 이름:
        <input
            type="text"
            name="name"
            required
        >

        <button type="submit">
            수정
        </button>

    </form>

</div>


<!-- ==========================================
     DELETE
========================================== -->

<div class="box">

    <h2>4. Delete - 데이터 삭제</h2>

    <form method="post" action="test.jsp">

        <input
            type="hidden"
            name="action"
            value="delete"
        >

        번호:
        <input
            type="number"
            name="no"
            required
        >

        <button type="submit">
            삭제
        </button>

    </form>

</div>


</body>
</html>

<%

    // ==========================================
    // DB 연결 종료
    // ==========================================

    if (conn != null) {

        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

%>