# Clone CAIRO CC-LfD
cd ~/ws_moveit/src && git clone https://github.com/cairo-robotics/cairo-lfd.git

# Clone and install KDL for MoveIt plan listener
cd ~/ws_moveit/src
git clone https://github.com/gt-ros-pkg/hrl-kdl.git
cd hrl-kdl/pykdl_utils/
python setup.py install
cd ../hrl_geom
python setup.py install

# Clone CAIRO constraint classification
cd ~/ws_moveit/src && git clone https://github.com/cairo-robotics/constraint_classification.git

# Clone CAIRO feedback CC-LfD
cd ~/ws_moveit/src && git clone https://github.com/jgkawell/cairo-feedback-cclfd.git

# Clone CAIRO robot interface
cd ~/ws_moveit/src && git clone https://github.com/cairo-robotics/cairo-robot-interface.git

# Clone CAIRO collision / scene repo
cd ~/ws_moveit/src && git clone https://github.com/cairo-robotics/collision_objects.git

# Install LfD Python requirements
cd ~/ws_moveit/src/cairo-lfd && pip install -r requirements.txt
cd ~/ws_moveit/src/cairo-feedback-cclfd && pip install -r requirements.txt

# Finally build the workspace
cd ~/ws_moveit
sudo catkin build

# Add Intera setup script alias
echo 'alias sim="cd ~/ws_moveit && clear && ./intera.sh sim"' >> ~/.bashrc
