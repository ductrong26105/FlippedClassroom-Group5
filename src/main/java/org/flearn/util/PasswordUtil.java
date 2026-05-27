package org.flearn.util;

import org.mindrot.jbcrypt.BCrypt;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.nio.charset.StandardCharsets;

public final class PasswordUtil {

    private static final String COOKIE_SALT = "FLearnSuperSecretRememberMeSaltKey2026!";

    private PasswordUtil() {
        // Utility class — prevent instantiation
    }

    /**
     * Hashes a plain text password using BCrypt.
     */
    public static String hashPassword(String plainPassword) {
        if (plainPassword == null) {
            return null;
        }
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
    }

    /**
     * Verifies a plain text password against a BCrypt hashed password.
     * Incorporates a fallback to plain text matching for migration safety.
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (IllegalArgumentException e) {
            // Fallback for plain text password comparison during migration/seeding
            return plainPassword.equals(hashedPassword);
        }
    }

    /**
     * Generates a SHA-256 signature for a given email to secure the Remember Me cookie.
     */
    public static String generateCookieSignature(String email) {
        if (email == null) {
            return null;
        }
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            String input = email + COOKIE_SALT;
            byte[] hash = digest.digest(input.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 algorithm not found", e);
        }
    }

    /**
     * Verifies the signature of a Remember Me cookie value.
     */
    public static boolean verifyCookieSignature(String email, String signature) {
        if (email == null || signature == null) {
            return false;
        }
        String expectedSignature = generateCookieSignature(email);
        return expectedSignature.equals(signature);
    }
}
