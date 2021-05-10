package com.task_generator.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class IndexController {

    @RequestMapping("/")
    public String index(){
        return "random_task";
    }

    @RequestMapping(value = "/random_task")
    public String generateTask(){
        return "random_task";
    }

    @RequestMapping(value = "/questions")
    public String questions(){
        return "questions";
    }

    @RequestMapping(value = "/exercises")
    public String exercises(){
        return "exercises";
    }

}
