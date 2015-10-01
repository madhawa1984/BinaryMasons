package org.hackathon.binarymason.controller;

import org.hackathon.binarymason.model.OperationMessage;
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
    public OperationMessage handle(OperationMessage message) throws Exception {
        return message;
    }

}