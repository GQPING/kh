package com.zyjd.kh.util.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.zyjd.kh.model.User;

/**
 * 自定义拦截器
 */
public class AuthorizedInterceptor  implements HandlerInterceptor {

	/** 定义不需要拦截的请求 */
	private static final String[] IGNORE_URI = {"/login","/exit"};
	
	/** 
     * preHandle方法是进行处理器拦截用的，该方法将在Controller处理之前进行调用，
     * 当preHandle的返回值为false的时候整个请求就结束了。 
     * 如果preHandle的返回值为true，则会继续执行postHandle和afterCompletion。
     */  
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object handler) throws Exception 
	{
		/** 默认用户没有登录 */
		boolean flag = false; 
		/** 获得请求的ServletPath */
		String servletPath = request.getServletPath();
		/** 登录界面地址 **/
		String loginUrl = request.getContextPath() + "/index.jsp";
		/**  判断请求是否需要拦截 */
        for (String s : IGNORE_URI) 
        {
            if (servletPath.contains(s)) 
            {
                flag = true;
                break;
            }
        }
        /** 拦截请求 */
        if (!flag) {
        	/** 1.获取session中的用户  */
        	User user = (User) request.getSession().getAttribute("CurrentUser");
        	 // 超时处理，ajax请求超时设置超时状态，页面请求超时则返回提示并重定向
        	/** 2.判断用户是否已经登录 */
        	if(user == null){
				// 判断是否为ajax请求
				if (request.getHeader("x-requested-with") != null
						&& request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
					response.addHeader("sessionstatus", "timeOut");
					response.addHeader("loginPath", loginUrl);
				} else {
					/** 转发方案 **/
					// request.getRequestDispatcher("login").forward(request, response);
					/** 重定向方案 **/
					String str = "<script language='javascript'>alert('会话已失效，请重新登录!');" 
					        + "window.top.location.href='" + loginUrl + "';</script>";
					response.setContentType("text/html;charset=UTF-8");// 解决中文乱码
					try {
						PrintWriter writer = response.getWriter();
						writer.write(str);
						writer.flush();
						writer.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
        		return flag;
        	}else{
        		 flag = true;
        	}
        }
        return flag;		
	}
	
	/** 
     * 这个方法在preHandle方法返回值为true的时候才会执行。
     * 执行时间是在处理器进行处理之 后，也就是在Controller的方法调用之后执行。
     */  
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response,
			Object handler, ModelAndView mv) throws Exception 
	{ }
	
	/** 
     * 该方法需要preHandle方法的返回值为true时才会执行。
     * 该方法将在整个请求完成之后执行，主要作用是用于清理资源。
     */  
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception exception)
			throws Exception 
	{ }
}