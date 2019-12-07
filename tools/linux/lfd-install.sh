# Clone CAIRO CC-LfD
cd ~/ws_moveit/src && git clone https://github.com/cairo-robotics/cairo-lfd.git

# Clone CAIRO constraint classification
cd ~/ws_moveit/src && git clone https://github.com/cairo-robotics/constraint_classification.git

# Clone CAIRO feedback CC-LfD
cd ~/ws_moveit/src && git clone https://github.com/jgkawell/cairo-feedback-cclfd.git

# Clone CAIRO robot interface
cd ~/ws_moveit/src && git clone https://github.com/cairo-robotics/cairo-robot-interface.git

# Clone CAIRO collision / scene repo
cd ~/ws_moveit/src && git clone https://github.com/cairo-robotics/collision_objects.git

# Finally build the workspace
cd ~/ws_moveit && catkin build
