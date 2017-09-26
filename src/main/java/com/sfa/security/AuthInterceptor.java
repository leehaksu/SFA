package com.sfa.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.sfa.vo.UserVo;



public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(
		HttpServletRequest request, 
		HttpServletResponse response, 
		Object handler)
		throws Exception {
		
		//1. handler 종류 확인
		if( handler instanceof HandlerMethod == false ) {
			return true;
		}
		
		//2. Casting
		HandlerMethod handlerMethod = (HandlerMethod)handler;
				
		//2. Method의 @Auth 받아오기
		Auth auth = handlerMethod.getMethodAnnotation( Auth.class );
		
		//3. Method에 @Auth가 붙어 있지 않으면, Class(Type)의 @Auth 받아오기  
		if( auth == null ) {
			auth = handlerMethod.getMethod().getDeclaringClass().getAnnotation( Auth.class );
		}

		//4. Method와 Type에 @Auth가 없음 
		if( auth == null ) {
			return true;
		}			
		
		//5. @Auth가 있기 때문에 인증 여부 확인 필요
		HttpSession session = request.getSession();
		UserVo authUser = null;
		
		if( session != null ) {
			authUser = (UserVo)session.getAttribute( "authUser" );
		}
		
		if( authUser == null ) {
			response.sendRedirect( request.getContextPath() + "/login" );
			return false;
		}

		// 6. Role 가져오기
		Auth.Role role = auth.value();

		// 7. USER Role 접근이면 인증만 되어있으면 허용 
		if( role == Auth.Role.팀원 ) {
			return true;
		}
		
		//8. ADMIN Role 접근 
		//   ADMIN 권한이 없는 사용자이면 메인으로...
		if( authUser.getLevel().equals( "팀장" ) == false ) {
			response.sendRedirect( request.getContextPath()+"/main" );
			return false;
		}
		
		//9. ADMIN Role 접근 허용
		return true;
	}
}
