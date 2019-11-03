package com.vuchobe.api.model.v2;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonView;
import com.vuchobe.api.views.Views;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Version;
import org.springframework.lang.NonNull;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import javax.validation.constraints.Email;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

@Entity(name = "user_auth")
@Data
@NoArgsConstructor
public class UserAuthEntity implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    @Version
    @JsonIgnore
    private Integer version;

    @Column(unique = true, name = "username")
    @NonNull
    private String username;

    @Email
    @NonNull
    @JsonView({View.Auth.class})
    @Column(unique = true, name = "email")
    private String email;

    @NonNull
    @Column(name = "password")
    @JsonView({View.Auth.class})
    private String password;

    @OneToOne
    @JoinColumn(name = "man_id")
    private Person man;

    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;

    public UserAuthEntity(@Email String email, String username, String password, Person man) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.man = man;
    }


    public static class View {
        public static class Auth {};
        public static class Save {};

        public static class Update extends Save{};

        public static class List extends Views.List {};
    }
    
    @JsonIgnore
    public String getPassword() {
        return password;
    }

    @JsonProperty
    public void setPassword(String password) {
        this.password = password;
    }

    public Collection<? extends GrantedAuthority> getAuthorities() {
        Set<GrantedAuthority> simpleGrantedAuthorities = new HashSet<>();
        role.setUser(null);
        simpleGrantedAuthorities.add(role);

        return simpleGrantedAuthorities;
    }

    @JsonIgnore
    public boolean isAccountNonExpired() {
        return true;
    }

    @JsonIgnore
    public boolean isAccountNonLocked() {
        return true;
    }

    @JsonIgnore
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @JsonIgnore
    public boolean isEnabled() {
        return true;
    }
}
