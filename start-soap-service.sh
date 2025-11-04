#!/bin/bash

# Calculator SOAP Web Service Startup Script
# This script starts the Java SOAP web service with required JVM arguments

echo "🚀 Starting Calculator SOAP Web Service..."
echo ""

# Build the project first
echo "📦 Building project..."
mvn clean compile

if [ $? -ne 0 ]; then
    echo "❌ Build failed. Please check the errors above."
    exit 1
fi

echo ""
echo "🔧 Getting classpath..."
CLASSPATH=$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q)

echo ""
echo "🔧 Starting SOAP service with JVM arguments..."
echo ""

# Run with required JVM arguments to open internal modules
java \
    --add-opens java.base/java.lang.reflect=ALL-UNNAMED \
    --add-opens java.base/java.util=ALL-UNNAMED \
    --add-opens java.base/jdk.internal.misc=ALL-UNNAMED \
    --add-opens java.base/java.lang=ALL-UNNAMED \
    --add-opens java.base/sun.nio.ch=ALL-UNNAMED \
    -cp "target/classes:$CLASSPATH" \
    com.calculator.ServicePublisher

echo ""
echo "⏹️  Service stopped."
