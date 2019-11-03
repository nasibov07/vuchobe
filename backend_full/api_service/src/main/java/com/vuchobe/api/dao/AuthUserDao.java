package com.vuchobe.api.dao;

import com.vuchobe.api.model.v2.UserAuthEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AuthUserDao extends JpaRepository<UserAuthEntity, Long> {
    Optional<UserAuthEntity> findByUsernameOrEmail(String username, String email);
}
