package com.vuchobe.api.model.v2;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;

@JsonTypeInfo(
        use = JsonTypeInfo.Id.NAME,
        include = JsonTypeInfo.As.PROPERTY,
        property = "type")
@JsonSubTypes({
        @JsonSubTypes.Type(value = Student.class, name = "student"),
        @JsonSubTypes.Type(value = OrganizationUser.class, name = "organization"),
        @JsonSubTypes.Type(value = OrganizationUser.class, name = "admin")
})
public interface UserSystem {
}
