package com.sfa.security;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;


@Retention( RetentionPolicy.RUNTIME )
@Target( { ElementType.METHOD, ElementType.TYPE} )
public @interface Auth {
	
	public enum Role { 팀장,팀원 }
	Role value() default Role.팀원;

}
