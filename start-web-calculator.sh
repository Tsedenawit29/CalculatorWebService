#!/bin/bash

echo "🌐 Starting Web Calculator..."
echo ""
echo "📍 Opening calculator at: http://localhost:8000/calculator.html"
echo ""
echo "⚠️  Make sure SOAP service is running!"
echo "   Run in another terminal: ./start-soap-service.sh"
echo ""
echo "Press Ctrl+C to stop..."
echo ""

python3 -m http.server 8000
