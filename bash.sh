#!/bin/bash

# Function to check CPU usage
check_cpu_usage() {
    local threshold=80
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    
    if (( $(echo "$cpu_usage > $threshold" | bc -l) )); then
        echo "High CPU usage detected: $cpu_usage%" >&2
    fi
}

# Function to check memory usage
check_memory_usage() {
    local threshold=80
    local memory_usage=$(free | awk '/Mem/{printf("%.2f"), $3/$2 * 100}')

    if (( $(echo "$memory_usage > $threshold" | bc -l) )); then
        echo "High memory usage detected: $memory_usage%" >&2
    fi
}

# Function to check disk space
check_disk_space() {
    local threshold=80
    local disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

    if (( $disk_usage > $threshold )); then
        echo "High disk usage detected: $disk_usage%" >&2
    fi
}

# Function to check running processes
check_running_processes() {
    local threshold=500
    local running_processes=$(ps aux | wc -l)

    if (( $running_processes > $threshold )); then
        echo "High number of running processes detected: $running_processes" >&2
    fi
}

# Main function to trigger checks
main() {
    check_cpu_usage
    check_memory_usage
    check_disk_space
    check_running_processes
}

# Execute the main function
main