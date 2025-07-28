#!/bin/bash

# Get the drone_id from the environment variable
DRONE_ID=${DRONE_ID:-0}  # Default to 0 if not set

# Wait for some time before takeoff
sleep 3

# Publish takeoff command
rostopic pub --once /iris_${DRONE_ID}_px4ctrl/takeoff_land quadrotor_msgs/TakeoffLand "takeoff_land_cmd: 1"

# Wait for the drone to reach final position
# First waypoint + second waypoint + safety margin
sleep 100

# Check if drone reached target position
# Get current position and compare with target
CURRENT_POS=$(rostopic echo -n 1 /iris_${DRONE_ID}/mavros/local_position/pose)

# Send landing command
rostopic pub --once /iris_${DRONE_ID}_px4ctrl/takeoff_land quadrotor_msgs/TakeoffLand "takeoff_land_cmd: 2"

# Wait for landing to complete
sleep 5
