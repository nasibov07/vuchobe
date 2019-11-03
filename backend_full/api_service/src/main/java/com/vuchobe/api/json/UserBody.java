package com.vuchobe.api.json;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.vuchobe.api.model.v2.Person;
import lombok.Data;
import lombok.NonNull;

@Data
public class UserBody extends Person {
    @NonNull
    private String username;
    @NonNull
    private String email;
    @NonNull
    private String password;


    @JsonCreator(mode = JsonCreator.Mode.PROPERTIES)
    public UserBody(@JsonProperty("lastName") String lastName,
                    @JsonProperty("firstName") String firstName,
                    @JsonProperty("secondName") String secondName,
                    @JsonProperty("username") String username,
                    @JsonProperty("email") String email,
                    @JsonProperty("password") String password) {
        super(lastName, firstName, secondName);
        this.username = username;
        this.email = email;
        this.password = password;
    }
}
