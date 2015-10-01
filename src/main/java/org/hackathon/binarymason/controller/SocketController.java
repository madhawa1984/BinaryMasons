package org.hackathon.binarymason.controller;

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
    public Object handle(String message) throws Exception {
        return message;
    }

}