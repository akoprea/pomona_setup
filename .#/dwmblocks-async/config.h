#ifndef CONFIG_H
#define CONFIG_H

// String used to delimit block outputs in the status.
#define DELIMITER " | " // |

// Maximum number of Unicode characters that a block can output.
#define MAX_BLOCK_OUTPUT_LENGTH 45

// Control whether blocks are clickable.
#define CLICKABLE_BLOCKS 1
// if 1, adds "control character" next to blocks in bar that appear as boxes

// Control whether a leading delimiter should be prepended to the status.
#define LEADING_DELIMITER 0

// Control whether a trailing delimiter should be appended to the status.
#define TRAILING_DELIMITER 0

// Define blocks for the status feed as X(icon, cmd, interval, signal).
#define BLOCKS(X)             \
    X( " ", "~/.#/scripts/mediaplayer.sh",			0, 4 ) \
    X( "", "~/.#/scripts/vol_ctrl.sh",				0, 3 ) \
    X( "", "~/.#/scripts/cpu_mem_report.sh", 	   30, 2 ) \
    X( "",  "~/.#/scripts/date_time_report.sh",		5, 1 ) 

// X( "", "pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]\\+%' | head -n1", 	0, 1 )
// X( "", "pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' ", 	0, 1 ) \

#endif  // CONFIG_H

