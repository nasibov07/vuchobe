package com.vuchobe.factory;


import com.vuchobe.api.json.UserBody;
import com.vuchobe.api.model.v2.OrganizationUser;
import com.vuchobe.api.model.v2.Student;
import com.vuchobe.api.model.v2.UserSystem;
import lombok.Getter;

public class UserFactory {
    private UserTypeEnum type;
    private UserBody body;

    public UserFactory(UserTypeEnum type, UserBody body) {
        this.type = type;
        this.body = body;
    }

    public UserSystem create() {
        UserSystem userSystem = null;
        switch (type) {
            case ADMIN: {
                OrganizationUser organizationUser = new OrganizationUser(body);
                userSystem = organizationUser;
                break;
            }
            case STUDENT: {
                Student organizationUser = new Student(body);
                userSystem = organizationUser;
                break;
            }
            case ORGANIZATION: {
                OrganizationUser organizationUser = new OrganizationUser(body);
                userSystem = organizationUser;
                break;
            }
        }

        if (userSystem == null) {
            throw new UnsupportedOperationException("not valid type user");
        }
        return userSystem;
    }

    @Getter
    public enum UserTypeEnum {
        STUDENT("student"),
        ORGANIZATION("organization"),
        ADMIN("admin");

        private String value;

        UserTypeEnum(String value) {
            this.value = value;
        }

        public String getValue() {
            return value;
        }
    }
}
