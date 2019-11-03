package com.vuchobe.auth.service;

import com.vuchobe.api.dao.AuthUserDao;
import com.vuchobe.api.model.v2.UserAuthEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.security.core.SpringSecurityMessageSource;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    private static final Logger logger
            = LoggerFactory.getLogger(UserServiceImpl.class);
    private MessageSourceAccessor messages = SpringSecurityMessageSource.getAccessor();
    private final BCryptPasswordEncoder passwordEncoder;
    private final AuthUserDao authUserDao;

    @Autowired
    public UserServiceImpl(BCryptPasswordEncoder passwordEncoder, AuthUserDao authUserDao) {
        this.passwordEncoder = passwordEncoder;
        this.authUserDao = authUserDao;
    }

    public UserDetails loadUserByUsername(String usernameOrEmail) throws UsernameNotFoundException {
        UserAuthEntity user = authUserDao.findByUsernameOrEmail(usernameOrEmail, usernameOrEmail)
                .orElse(null);

        if (user == null) {
            logger.debug("Query returned no results for user '" + usernameOrEmail + "'");
            throw new UsernameNotFoundException(this.messages.getMessage("JdbcDaoImpl.notFound",
                    new Object[]{usernameOrEmail}, "Username {0} not found"));
        }

        return user;
    }

    @Override
    public Long save(UserAuthEntity authEntity) {
        authEntity.setPassword(passwordEncoder.encode(authEntity.getPassword()));
        authUserDao.save(authEntity);
        return authEntity.getId();
    }

    @Override
    public Long delete(Long id) {
        UserAuthEntity userAuthEntity = authUserDao.findById(id).orElseThrow(NullPointerException::new);
        authUserDao.delete(userAuthEntity);
        return id;
    }
}
