package com.example;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

import java.util.stream.Collectors;

@Path("/")
@ApplicationScoped
public class Main {
    @PersistenceContext
    private EntityManager entityManager;

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String execute() {
        return "result of SELECT 1: " + entityManager.createNativeQuery("SELECT 1").getSingleResult();
    }
}
