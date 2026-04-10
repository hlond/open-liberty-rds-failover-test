package com.example;

import jakarta.ejb.TransactionManagement;
import jakarta.ejb.TransactionManagementType;
import jakarta.ws.rs.ApplicationPath;

@ApplicationPath("/")
@TransactionManagement(TransactionManagementType.BEAN)
public class Application extends jakarta.ws.rs.core.Application {
}
