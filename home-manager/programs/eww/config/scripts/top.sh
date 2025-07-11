# vim:fileencoding=utf-8:foldmethod=marker

#: Temperature {{{

# Get temperature in Celsius
temp=$(echo "$(cat /sys/class/thermal/thermal_zone0/temp)/1000" | bc)

# Define temperature ranges (35°C to 95°C, 60° range divided into 8 blocks)
# Each block represents 7.5° range
min_temp=35
max_temp=95
range=$((max_temp - min_temp))  # 60°C range
block_size=$((range / 8))       # 7.5° per block

# Calculate which block to display based on temperature
if [ $temp -le $min_temp ]; then
    block="▁"
elif [ $temp -le $((min_temp + block_size)) ]; then     # 35-42.5°C
    block="▁"
elif [ $temp -le $((min_temp + 2 * block_size)) ]; then # 42.5-50°C
    block="▂"
elif [ $temp -le $((min_temp + 3 * block_size)) ]; then # 50-57.5°C
    block="▃"
elif [ $temp -le $((min_temp + 4 * block_size)) ]; then # 57.5-65°C
    block="▄"
elif [ $temp -le $((min_temp + 5 * block_size)) ]; then # 65-72.5°C
    block="▅"
elif [ $temp -le $((min_temp + 6 * block_size)) ]; then # 72.5-80°C
    block="▆"
elif [ $temp -le $((min_temp + 7 * block_size)) ]; then # 80-87.5°C
    block="▇"
else                                                     # 87.5-95°C+
    block="█"
fi

# Display the result
a="$block $temp°"

#: }}}

#: CPU {{{

# File to store previous CPU stats and timestamp
STATS_FILE="/tmp/cpu_stats_$(whoami)"

# Function to get CPU stats
get_cpu_stats() {
    awk '/^cpu /{print $2, $3, $4, $5}' /proc/stat
}

# Get current stats and timestamp
read user2 nice2 system2 idle2 <<< $(get_cpu_stats)
total2=$((user2 + nice2 + system2 + idle2))
busy2=$((user2 + nice2 + system2))
timestamp2=$(date +%s.%3N)  # Current time in seconds with milliseconds

# Initialize CPU percentage
cpu_percent=0

# Check if previous stats exist
if [ -f "$STATS_FILE" ]; then
    # Read previous stats
    read user1 nice1 system1 idle1 timestamp1 < "$STATS_FILE"
    total1=$((user1 + nice1 + system1 + idle1))
    busy1=$((user1 + nice1 + system1))

    # Calculate differences
    total_diff=$((total2 - total1))
    busy_diff=$((busy2 - busy1))

    # Calculate time difference (in seconds)
    time_diff=$(echo "$timestamp2 - $timestamp1" | bc -l 2>/dev/null || echo "1")

    # Only calculate if we have valid data and reasonable time difference
    if [ $total_diff -gt 0 ] && (( $(echo "$time_diff >= 0.1" | bc -l 2>/dev/null || echo "1") )); then
        cpu_percent=$((busy_diff * 100 / total_diff))
    fi
fi

# Save current stats for next run
echo "$user2 $nice2 $system2 $idle2 $timestamp2" > "$STATS_FILE"

# Ensure percentage is within bounds
if [ $cpu_percent -lt 0 ]; then
    cpu_percent=0
elif [ $cpu_percent -gt 100 ]; then
    cpu_percent=100
fi

# Define the block characters array
blocks=("▁" "▂" "▃" "▄" "▅" "▆" "▇" "█")

# Calculate which block to use based on CPU percentage
# Distribute uniformly across 8 blocks (0-12.5%, 12.5-25%, 25-37.5%, etc.)
block_index=$((cpu_percent / 13))

# Ensure we don't exceed array bounds
if [ $block_index -gt 7 ]; then
    block_index=7
fi

# Display the result with right-aligned percentage (2 digits + % sign = 3 characters)
c="${blocks[$block_index]} $(printf '%4s' "${cpu_percent}%")"

#: }}}

#: Memory {{{

read mem_total mem_free mem_buffers mem_cached <<< $(awk '/^MemTotal:|^MemFree:|^Buffers:|^Cached:/{print $2}' /proc/meminfo | tr '\n' ' ')
mem_used=$((mem_total - mem_free - mem_buffers - mem_cached))
mem_percent=$((mem_used * 100 / mem_total))

# Ensure memory percentage is within bounds
if [ $mem_percent -lt 0 ]; then
    mem_percent=0
elif [ $mem_percent -gt 100 ]; then
    mem_percent=100
fi

# Calculate which block to use for memory based on percentage
mem_block_index=$((mem_percent / 13))

# Ensure we don't exceed array bounds
if [ $mem_block_index -gt 7 ]; then
    mem_block_index=7
fi

# Display the results with right-aligned percentages (2 digits + % sign = 3 characters)
b="${blocks[$mem_block_index]} $(printf '%4s' "${mem_percent}%")"

#: }}}

echo "$a $b $c"
