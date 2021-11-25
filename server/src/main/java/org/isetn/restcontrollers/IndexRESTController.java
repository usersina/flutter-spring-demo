package org.isetn.restcontrollers;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
@CrossOrigin
public class IndexRESTController {

    @RequestMapping(method = RequestMethod.GET)
    Map<String, String> index() {
        HashMap<String, String> map = new HashMap<>();
        map.put("status", "success");
        map.put("message", "Api is responding successfully");
        return map;
    }
}
