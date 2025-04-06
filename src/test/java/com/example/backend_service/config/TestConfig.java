package com.example.backend_service.config;

import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;

@TestConfiguration
@EnableAutoConfiguration
@EnableFeignClients(basePackages = "com.example.backend_service.clients")
public class TestConfig {
    // Add any additional test-specific beans here if needed
} 