package com.vuchobe.auth.model;

public class UserSecurity {
    private Long id;
    
    private String email;
    
    private Long manId;
    
    private Long studentId;
    private Long organizationUserId;

    public UserSecurity() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Long getManId() {
        return manId;
    }

    public void setManId(Long manId) {
        this.manId = manId;
    }

    public Long getStudentId() {
        return studentId;
    }

    public void setStudentId(Long studentId) {
        this.studentId = studentId;
    }

    public Long getOrganizationUserId() {
        return organizationUserId;
    }

    public void setOrganizationUserId(Long organizationUserId) {
        this.organizationUserId = organizationUserId;
    }
}
