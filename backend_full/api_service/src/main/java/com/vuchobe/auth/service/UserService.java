package com.vuchobe.auth.service;

import com.vuchobe.api.model.v2.UserAuthEntity;
import org.springframework.security.core.userdetails.UserDetailsService;

public interface UserService extends UserDetailsService {

    Long save(UserAuthEntity authEntity);

    Long delete(Long id);
}
