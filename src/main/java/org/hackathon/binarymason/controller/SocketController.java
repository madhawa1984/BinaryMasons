package org.hackathon.binarymason.controller;

//import org.atmosphere.cpr.AtmosphereResource;
//import org.hackathon.binarymason.utils.AtmosphereUtils;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

/**
 * Created by dev on 10/1/15.
 */
@Controller
public class SocketController {

    @MessageMapping("/socket")
    @SendTo("/operation/get")
    public Greeting greeting(HelloMessage message) throws Exception {
        Thread.sleep(3000); // simulated delay
        return new Greeting("Hello, " + message.getName() + "!");
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