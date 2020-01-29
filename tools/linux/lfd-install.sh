# Clone CAIRO LfD
cd ~/catkin_ws/src && git clone https://github.com/cairo-robotics/cairo-lfd.git
cd ~/catkin_ws/src/cairo-lfd && git checkout constraint_augmentation

# Clone CAIRO constraint classification
cd ~/catkin_ws/src && git clone https://github.com/cairo-robotics/constraint_classification.git

# Clone CAIRO robot interface
cd ~/catkin_ws/src && git clone https://github.com/cairo-robotics/cairo-robot-interface.git

# Clone CAIRO collision / scene repo
cd ~/catkin_ws/src && git clone https://github.com/cairo-robotics/collision_objects.git

# Clone CAIRO feedback CC-LfD
cd ~/catkin_ws/src && git clone https://github.com/jgkawell/feedback_cclfd.git

# Clone CAIRO NLP
cd ~/catkin_ws/src && git clone https://github.com/cairo-robotics/cairo-nlp.git

# Install LfD Python requirements
cd ~/catkin_ws/src/cairo-lfd && pip install -r requirements.txt
cd ~/catkin_ws/src/cairo-nlp && pip install -r requirements.txt

# Current workaround since Google Cloud installation is broken
pip install --upgrade pip
pip install --upgrade 'setuptools<45.0.0'
pip install --upgrade 'cachetools<5.0'
pip install --upgrade cryptography
python -m easy_install --upgrade pyOpenSSL

# Clone and install KDL for MoveIt plan listener
cd ~/catkin_ws/src
git clone https://github.com/gt-ros-pkg/hrl-kdl.git
cd hrl-kdl/pykdl_utils/
python setup.py install
cd ../hrl_geom
python setup.py install

# Finally build the workspace
cd ~/catkin_ws
sudo catkin build

# Add Intera setup script alias
echo 'alias sim="cd ~/catkin_ws && clear && ./intera.sh sim"' >> ~/.bashrc
