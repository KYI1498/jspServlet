package com.mobility.kyi.project3.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBUtil {

    private static final String URL;
    private static final String USERNAME;
    private static final String PASSWORD;

    static {
        Properties properties = new Properties();

        try (InputStream inputStream =
                     DBUtil.class.getClassLoader()
                             .getResourceAsStream("db.properties")) {

            if (inputStream == null) {
                throw new RuntimeException(
                        "db.properties 파일을 찾을 수 없습니다."
                );
            }

            properties.load(inputStream);

            URL = properties.getProperty("db.url");
            USERNAME = properties.getProperty("db.username");
            PASSWORD = properties.getProperty("db.password");

            Class.forName("org.postgresql.Driver");

        } catch (IOException e) {
            throw new RuntimeException(
                    "DB 설정 파일을 읽을 수 없습니다.", e
            );
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(
                    "PostgreSQL JDBC Driver를 찾을 수 없습니다.", e
            );
        }
    }

    private DBUtil() {
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(
                URL,
                USERNAME,
                PASSWORD
        );
    }
}