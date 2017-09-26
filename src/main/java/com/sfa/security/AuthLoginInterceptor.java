package com.sfa.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.sfa.service.UserService;
import com.sfa.util.ChangeDate;
import com.sfa.vo.UserVo;

public class AuthLoginInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private UserService userService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		String id = request.getParameter("id");
		String password=request.getParameter("passwd");
		
		System.out.println("[Server]:" + id);
		System.out.println("[Server]:" + password);

		if (id == null || password == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return false;
		}
		UserVo userVo = userService.getUser(id, password);

		if (userVo == null) {
			response.sendRedirect(request.getContextPath() + "/login?result=fail");
			return false;
		}
		String today=ChangeDate.today();
		userVo.setDate(today);
		System.out.println(today);
		HttpSession session = request.getSession(true);
		session.setAttribute("authUser", userVo);
		System.out.println("Session 정보"+session.getAttribute("authUser"));
		response.sendRedirect( request.getContextPath() + "/main" );
		return false;
	}
}