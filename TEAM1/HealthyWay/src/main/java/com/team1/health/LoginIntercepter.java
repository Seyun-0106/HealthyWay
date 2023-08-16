package com.team1.health;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
/*preHandle은 컨트롤러에 요청이 넘겨지기 이전에, 
 * postHandle은 컨트롤러가 처리를 마친 후, 
 * afterCompletion은 view까지의 모든 요청처리가 완료되었을 때 호출된다.*/

@Component
public class LoginIntercepter implements HandlerInterceptor {
	public List<String> loginEssential
    = Arrays.asList("/recipe/**","/board/**","/trainning/**","/mypage/**","/master/**");

	public List<String> loginInessential
    = Arrays.asList("/member/**", "/");
	
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String loginId = (String)request.getSession().getAttribute("logId");
		if (loginId != null) {
			return true;
		}
		else{
            String destUri = request.getRequestURI();
            String destQuery = request.getQueryString();
            String dest = (destQuery == null) ? destUri : destUri+"?"+destQuery;
            request.getSession().setAttribute("dest", dest);      
            response.sendRedirect("/member/loginForm");
            return false;
        }
		
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
    }
}
