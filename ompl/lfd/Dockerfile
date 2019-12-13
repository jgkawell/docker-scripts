### BASE STAGE ###

# Build from sawyer ompl dev box
FROM jgkawell/ompl:sawyer AS base

# Clone CAIRO CC-LfD
RUN cd ~/ws_moveit/src && git clone https://github.com/cairo-robotics/cairo-lfd.git
RUN cd ~/ws_moveit/src/cairo-lfd && git checkout constraint_augmentation

# Clone and install KDL for MoveIt plan listener
RUN cd ~/ws_moveit/src \
        && git clone https://github.com/gt-ros-pkg/hrl-kdl.git \
        && cd hrl-kdl/pykdl_utils/ \
        && python setup.py install \
        && cd ../hrl_geom \
        && python setup.py install

# Clone CAIRO constraint classification
RUN cd ~/ws_moveit/src && git clone https://github.com/cairo-robotics/constraint_classification.git

# Clone CAIRO feedback CC-LfD
RUN cd ~/ws_moveit/src && git clone https://github.com/jgkawell/cairo-feedback-cclfd.git

# Clone CAIRO robot interface
RUN cd ~/ws_moveit/src && git clone https://github.com/cairo-robotics/cairo-robot-interface.git

# Clone CAIRO collision / scene repo
RUN cd ~/ws_moveit/src && git clone https://github.com/cairo-robotics/collision_objects.git

# Install LfD Python requirements
RUN cd ~/ws_moveit/src/cairo-lfd && pip install -r requirements.txt
RUN cd ~/ws_moveit/src/cairo-feedback-cclfd && pip install -r requirements.txt

# Finally build the workspace
RUN cd ~/ws_moveit && catkin build

# Added alias for Intera to .bashrc
RUN echo 'alias sim="cd ~/ws_moveit && clear && ./intera.sh sim"' >> ~/.bashrc

# Clean up apt
RUN rm -rf /var/lib/apt/lists/*


### NVIDIA STAGE ###

# Extra needed setup for Nvidia-based graphics
FROM base AS nvidia

# Copy over needed OpenGL files from Nvidia's image
COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 /usr/local /usr/local
COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 /etc/ld.so.conf.d/glvnd.conf /etc/ld.so.conf.d/glvnd.conf
