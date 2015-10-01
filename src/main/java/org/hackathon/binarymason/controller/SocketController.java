package org.hackathon.binarymason.controller;

//import org.atmosphere.cpr.AtmosphereResource;
//import org.hackathon.binarymason.utils.AtmosphereUtils;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by dev on 10/1/15.
 */
@Controller
public class SocketController {

    @MessageMapping("/hello")
    @SendTo("/topic/greetings")
    public Greeting greeting(HelloMessage message) throws Exception {
        Thread.sleep(3000); // simulated delay
        return new Greeting("Hello, " + message.getName() + "!");
    }

    @RequestMapping("/one")
    public ModelAndView showMessage(
            @RequestParam(value = "name", required = false, defaultValue = "World") String name) {
        System.out.println("in controller");

        ModelAndView mv = new ModelAndView("helloworld");
        mv.addObject("message", "hi");
        mv.addObject("name", name);
        return mv;
    }
}

class HelloMessage {

    private String name;

    public String getName() {
        return name;
    }

}

class Greeting {

    private String content;

    public Greeting(String content) {
        this.content = content;
    }

    public String getContent() {
        return content;
    }

}