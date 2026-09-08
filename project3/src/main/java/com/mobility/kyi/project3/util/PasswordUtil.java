package com.mobility.kyi.project3.util;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.security.SecureRandom;
import java.util.Base64;

public class PasswordUtil {

    private static final int ITERATIONS = 65536;
    private static final int KEY_LENGTH = 256;
    private static final int SALT_LENGTH = 16;

    private PasswordUtil() {
    }

    public static String hash(String password) {

        try {

            byte[] salt = new byte[SALT_LENGTH];

            SecureRandom random = new SecureRandom();
            random.nextBytes(salt);

            PBEKeySpec spec = new PBEKeySpec(
                    password.toCharArray(),
                    salt,
                    ITERATIONS,
                    KEY_LENGTH
            );

            SecretKeyFactory factory =
                    SecretKeyFactory.getInstance(
                            "PBKDF2WithHmacSHA256"
                    );

            byte[] hash = factory
                    .generateSecret(spec)
                    .getEncoded();

            return ITERATIONS + ":"
                    + Base64.getEncoder().encodeToString(salt)
                    + ":"
                    + Base64.getEncoder().encodeToString(hash);

        } catch (Exception e) {

            throw new RuntimeException(
                    "비밀번호 암호화 중 오류가 발생했습니다.",
                    e
            );
        }
    }

    public static boolean verify(
            String password,
            String storedPassword) {

        try {

            String[] parts = storedPassword.split(":");

            int iterations = Integer.parseInt(parts[0]);

            byte[] salt =
                    Base64.getDecoder().decode(parts[1]);

            byte[] expectedHash =
                    Base64.getDecoder().decode(parts[2]);

            PBEKeySpec spec = new PBEKeySpec(
                    password.toCharArray(),
                    salt,
                    iterations,
                    expectedHash.length * 8
            );

            SecretKeyFactory factory =
                    SecretKeyFactory.getInstance(
                            "PBKDF2WithHmacSHA256"
                    );

            byte[] actualHash =
                    factory
                            .generateSecret(spec)
                            .getEncoded();

            if (actualHash.length != expectedHash.length) {
                return false;
            }

            int result = 0;

            for (int i = 0; i < actualHash.length; i++) {
                result |= actualHash[i] ^ expectedHash[i];
            }

            return result == 0;

        } catch (Exception e) {

            return false;
        }
    }
}