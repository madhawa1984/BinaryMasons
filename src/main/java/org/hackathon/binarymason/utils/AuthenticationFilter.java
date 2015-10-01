package org.hackathon.binarymason.utils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by madhawa on 10/1/15.
 */
public class AuthenticationFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        try {
            HttpServletRequest request = (HttpServletRequest) req;
            HttpServletResponse httpResponse = (HttpServletResponse) resp;
            HttpSession session = request.getSession(true);
            String online = "offline";
            if(session !=null) {
                online = (String) session.getAttribute("onlineStatus");
            }
            if ("online".equals(online)) {
                System.out.println("---xxx---"+online);
                chain.doFilter(req,resp);
            }else {
                httpResponse.sendRedirect("/BinaryMasons/ui/login");
            }

            // chain.doFilter(req, resp);
        }catch(Exception e) {
            e.printStackTrace();
        }
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
