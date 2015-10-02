package org.hackathon.binarymason.controller;

/*import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

package org.hackathon.binarymason;*/

import org.hackathon.binarymason.utils.Credentials;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.Map;

@Controller
public class loginController {
    String message = "Welcome to Spring MVC!";
    String failedAtemptmessage = "Invalid login";
    @Autowired
    private Credentials credentialBean;

    @RequestMapping(value = "/CameraConference", method = RequestMethod.GET)
    public ModelAndView showCameraConferencePage(Model model,
                                        HttpServletRequest req, HttpServletResponse res, Map<String, String[]> paramMap) throws Exception {
        System.out.println("in controller");
        ModelAndView mv = new ModelAndView("CameraConference");
        mv.addObject("message", message);
        // mv.addObject("name", name);
        return mv;
    }
    @RequestMapping(value = "/au/success", method = RequestMethod.GET)
    public ModelAndView showSuccessPage(Model model,
                                        HttpServletRequest req, HttpServletResponse res, Map<String, String[]> paramMap) throws Exception {
        System.out.println("in controller");
        // ModelAndView mv = new ModelAndView("success");
        ModelAndView mv = new ModelAndView("editor");
        mv.addObject("message", message);
        // mv.addObject("name", name);
        return mv;
    }
    @RequestMapping(value = "/ui/login", method = RequestMethod.GET)
    public ModelAndView showloginPage(Model model,
                                      HttpServletRequest req, HttpServletResponse res, Map<String, String[]> paramMap) throws Exception {
        System.out.println("in controller");
        ModelAndView mv = new ModelAndView("login"); //mcp xxx-1
        mv.addObject("message", message);
        // mv.addObject("name", name);
        return mv;
    }
    // value = "/ui/loginPost"
    @RequestMapping(value = "/ui/login", method = RequestMethod.POST)
    public ModelAndView showMessage(Model model,
                                    HttpServletRequest req, HttpServletResponse res, Map<String, String[]> paramMap) throws Exception {
        System.out.println("in controller");

        String userName = "";
        String pwd = "";
        String redirectpoint="success";
        HttpSession session = req.getSession(true);
        String onlineStatus = (String) session.getAttribute("onlineStatus");
        boolean authorised = false;
        if (!("online".equals(onlineStatus))) {
            userName = req.getParameter("UNAME");
            pwd = req.getParameter("PWD");
            if (userName!=null && pwd!= null) {
                authorised = credentialBean.validateUser(userName, pwd); // not comming via a login page session expiraton occured
            }else {
                authorised = false; // need to redirect to login page
            }
        }
        System.out.println("xxx-1");
        if (authorised) {
            redirectpoint="editor";
            session.setAttribute("onlineStatus","online");
            session.setAttribute("loggedInUser",userName);

        } else {
            redirectpoint="unauthorised";
            message = failedAtemptmessage;
            session.setAttribute("onlineStatus","offline");
            session.removeAttribute("loggedInUser");
        }
        System.out.println("xxx-1"+redirectpoint);
        ModelAndView mv = new ModelAndView(redirectpoint);
        mv.addObject("message", message);
        // mv.addObject("name", name);
        return mv;
    }
}

