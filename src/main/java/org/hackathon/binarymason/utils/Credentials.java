package org.hackathon.binarymason.utils;

import java.util.HashMap;

/**
 * Created by madhawa on 10/1/15.
 */
public class Credentials {
    private HashMap<String,String> userCredentials =new HashMap<String, String>();

    public Credentials() {
        userCredentials.put("madhawa","madhawa123");
        userCredentials.put("chammila","chamila123");
        userCredentials.put("asela","asela123");
        userCredentials.put("thilina","thilina123");

    }

    public boolean validateUser(String uname,String pwd) {
        try {
            String correctPasswrd = userCredentials.get(uname);
            if (pwd.equals(correctPasswrd)) {
                return true;
            } else {
                return false;
            }
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }
    public String getPwd(String userName) {
        return userCredentials.get(userName);
    }
}