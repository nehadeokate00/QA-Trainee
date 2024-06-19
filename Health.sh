#!/bin/bash

# URL of the application to monitor
URL="http://example.com"

# Function to check application status
check_application_status() {
    local response_code=$(curl -s -o /dev/null -w "%{http_code}" $URL)

    if [ $response_code -eq 200 ]; then
        echo "Application is UP - HTTP Status Code: $response_code"
    else
        echo "Application is DOWN - HTTP Status Code: $response_code"
    fi
}

# Main function to trigger application status check
main() {
    check_application_status
}

# Execute the main function
main