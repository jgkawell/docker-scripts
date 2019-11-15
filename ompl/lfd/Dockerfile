# Build from sawyer ompl dev box
FROM jgkawell/ompl-dev:sawyer

# Clone CAIRO CC-LfD
RUN cd ~/ws_moveit/src && git clone https://github.com/cairo-robotics/cairo-lfd.git

# Clone CAIRO constraint classification
RUN cd ~/ws_moveit/src && git clone https://github.com/cairo-robotics/constraint_classification.git

# Clone CAIRO feedback CC-LfD
RUN cd ~/ws_moveit/src && git clone https://github.com/jgkawell/cairo-feedback-cclfd.git

# Clone CAIRO robot interface
RUN cd ~/ws_moveit/src && git clone https://github.com/cairo-robotics/cairo-robot-interface.git

# Finally build the workspace
RUN cd ~/ws_moveit && catkin build

# Clean up apt
RUN rm -rf /var/lib/apt/lists/*
