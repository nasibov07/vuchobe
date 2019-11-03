package com.vuchobe.api.dao;

import com.vuchobe.api.model.v2.Role;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RoleDao extends JpaRepository<Role, Long> {
    Optional<Role> findByAuthorityType(Role.RoleEnum role);
}
