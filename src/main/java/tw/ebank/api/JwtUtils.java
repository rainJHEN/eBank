package tw.ebank.api;
import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class JwtUtils {
    private static final long EXPIRATION_TIME = 3600000; // 1 hour
    private static final byte[] SECRET_KEY = Keys.secretKeyFor(SignatureAlgorithm.HS256).getEncoded();
    public static String generateToken(String email) {
        Date now = new Date();
        Date expiration = new Date(now.getTime() + EXPIRATION_TIME);
        Map<String, Object> header = new HashMap();
        header.put("alg", "HS256");
        header.put("typ", "JWT");
        Map<String, Object> payload = new HashMap();
        payload.put("email", email);
        payload.put("iat", new Date().getTime());
        payload.put("counts", 0);
        payload.put("used", false);
        return Jwts.builder()
        		.setHeader(header)
        		.setClaims(payload)
                .setExpiration(expiration)
                .signWith(SignatureAlgorithm.HS256, SECRET_KEY)
                .compact();
    }

    public static Claims parseToken(String token) {
        return Jwts.parser()
                .setSigningKey(SECRET_KEY)
                .parseClaimsJws(token)
                .getBody();
    }
}
