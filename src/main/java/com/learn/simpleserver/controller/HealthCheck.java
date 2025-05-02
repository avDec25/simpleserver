package com.learn.simpleserver.controller;

import com.google.gson.JsonObject;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.net.InetAddress;
import java.util.Date;

@RestController
@RequestMapping("healthcheck")
@Slf4j
public class HealthCheck {

    @SneakyThrows
    @GetMapping(value = "service", produces = MediaType.APPLICATION_JSON_VALUE)
    public String healthcheck() {
        String timestamp = new Date().toString();
        String hostname = InetAddress.getLocalHost().getHostName();
        log.info("Request received at {} on {}", timestamp, hostname);

        JsonObject response = new JsonObject();
        response.addProperty("timestamp", timestamp);
        response.addProperty("hostname", hostname);
        response.addProperty("message", "Service is up and running");
        return response.toString();
    }
}
