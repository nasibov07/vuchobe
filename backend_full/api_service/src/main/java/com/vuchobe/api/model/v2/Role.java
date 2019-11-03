package com.vuchobe.api.model.v2;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity(name = "role_vuchobe")
@Data
@NoArgsConstructor
public class Role implements GrantedAuthority {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    @Column
    private String name;

    @Column(unique = true, name = "authority")
    @Enumerated(value = EnumType.STRING)
    private RoleEnum authorityType;

    @ManyToMany
    @JoinTable(name = "role_to_section",
            joinColumns = @JoinColumn(name = "role_id"),
            inverseJoinColumns = @JoinColumn(name = "section_id")
    )
    Set<Section> sections = new HashSet<>();

    @OneToMany(mappedBy = "role")
    private Set<UserAuthEntity> user;

    public Role(String name, RoleEnum value) {
        this.name = name;
        this.authorityType = value;
    }

    public RoleEnum getAuthorityType() {
        return authorityType;
    }

    public void setAuthorityType(RoleEnum authorityType) {
        this.authorityType = authorityType;
    }

    @Override
    public String getAuthority() {
        return authorityType.toString();
    }

    public enum RoleEnum {
        ADMIN,
        STUDENT,
        ORGANIZATION;

        RoleEnum() {
        }
    }
}
