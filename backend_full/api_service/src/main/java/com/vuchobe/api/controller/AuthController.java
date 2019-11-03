package com.vuchobe.api.controller;


import com.fasterxml.jackson.annotation.JsonView;
import com.vuchobe.api.json.UserBody;
import com.vuchobe.api.model.v2.*;
import com.vuchobe.api.service.StudentService;
import com.vuchobe.auth.config.JwtConfig;
import com.vuchobe.auth.model.TokenResponse;
import com.vuchobe.auth.service.UserService;
import com.vuchobe.factory.UserFactory;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.naming.OperationNotSupportedException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/auth")
public class AuthController {
    private static final Logger logger = LoggerFactory.getLogger(AuthController.class);

    private final UserService userService;
    private final StudentService studentService;
    private final JwtConfig jwtConfig;
    private final BCryptPasswordEncoder encoder;

    public AuthController(UserService userService, StudentService studentService, JwtConfig jwtConfig, BCryptPasswordEncoder encoder) {
        this.userService = userService;
        this.studentService = studentService;
        this.jwtConfig = jwtConfig;
        this.encoder = encoder;
    }

    @PostMapping("/login")
    public TokenResponse login(@JsonView({UserAuthEntity.View.Auth.class}) @RequestBody UserAuthEntity body) {
        UserAuthEntity userAuth = (UserAuthEntity) userService.loadUserByUsername(body.getEmail() == null ?
                body.getUsername() :
                body.getEmail());
        if (!encoder.matches(body.getPassword(), userAuth.getPassword())) {
            logger.debug("Query returned no results for user '" + userAuth.getEmail() + "'");
            throw new UsernameNotFoundException(String.format("Username %s not found", userAuth.getEmail()));
        }
        Person man = userAuth.getMan();
        Student student = man.getStudent();
        OrganizationUser organizationUser = man.getOrganizationUser();

        Long now = System.currentTimeMillis();
        Map<String, Object> claims = new HashMap<>();
        claims.put("id", userAuth.getId());
        claims.put("manId", userAuth.getMan().getId());
        if (student != null) {
            claims.put("studentId", student.getId());
        }

        if (organizationUser != null) {
            claims.put("organizationUserId", organizationUser.getId());
        }
        String token = Jwts.builder()
                // Convert to list of strings.
                .setClaims(claims)
                .claim("authorities", userAuth.getAuthorities())
                .setSubject(userAuth.getEmail())
                .setIssuedAt(new Date(now))
                .setExpiration(new Date(now + jwtConfig.getExpiration() * 1000))  // in milliseconds
                .signWith(SignatureAlgorithm.HS512, jwtConfig.getSecret().getBytes())
                .compact();

        return new TokenResponse(token);
    }

    @PostMapping("/registration/{type}")
    public Long registration(@PathVariable("type") UserFactory.UserTypeEnum type,
                             @Validated @RequestBody UserBody body)
            throws OperationNotSupportedException {
        UserFactory factory = new UserFactory(type, body);
        UserSystem user = factory.create();
        switch (type) {
            case ADMIN: {
                throw new OperationNotSupportedException("create admin not support");
                // break;
            }
            case STUDENT: {
                return studentService.save((Student) user);
            }
            case ORGANIZATION: {

                break;
            }
        }
        throw new OperationNotSupportedException("role is not supported to create");
    }


}
