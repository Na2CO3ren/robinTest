package robin.web.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MainController {

    @Value("${robin.healthy.word}")
    private String healthyWord;

    @RequestMapping("/")
    @ResponseBody
    public String healthyCheck() {

        return healthyWord;
    }
}
