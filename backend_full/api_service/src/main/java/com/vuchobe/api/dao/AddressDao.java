package com.vuchobe.api.dao;

import com.vuchobe.api.model.v2.Address;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AddressDao extends JpaRepository<Address, Long> {
}
