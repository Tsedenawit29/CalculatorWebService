package com.calculator;

import javax.xml.ws.Endpoint;

/**
 * Standalone SOAP Calculator Web Service
 * 
 * Usage: Run this class to start the service on localhost:8080
 */
public class ServicePublisher {
    public static void main(String[] args) {
        String url = "http://localhost:9090/calculator";
        
        System.out.println("🚀 Starting Calculator SOAP Web Service...");
        System.out.println("📍 URL: " + url);
        
        try {
            Endpoint.publish(url, new CalcWebService());
            
            System.out.println("✅ Calculator Service is running!");
            System.out.println("📄 WSDL: " + url + "?wsdl");
            System.out.println("\n🔧 Available Operations:");
            System.out.println("   - add(a, b)");
            System.out.println("   - subtract(a, b)");
            System.out.println("   - multiply(a, b)");
            System.out.println("   - divide(a, b)");
            System.out.println("\n⏹️  Press Ctrl+C to stop the service.");
        } catch (Exception e) {
            System.err.println("❌ Failed to start service: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
