ARG ZEPHYR_TAG=latest
FROM zephyrprojectrtos/zephyr-build:${ZEPHYR_TAG}

USER root

# Set default to bash instead sh
ENV SHELL /bin/bash

# Install packages
RUN apt-get -y update && \
  apt-get install --no-install-recommends -y \
  bash-completion \
  curl \
  doxygen \
  graphviz \
  minicom \
  mscgen \
  latexmk \
  librsvg2-bin \
  texlive-latex-base \
  texlive-latex-extra \
  texlive-fonts-recommended \
  tmux \
  udev \
  usbutils \
  vim

# Clean up stale packages
RUN apt-get clean -y && \
  apt-get autoremove --purge -y && \
  rm -rf /var/lib/apt/lists/*

# Adjust 'user' home directory permissions
RUN chown -R user:user /home/user

# Add 'user' to groups to access USB devices
RUN usermod -aG dialout user

# Switch to 'user' context
USER user

# Create directories
RUN mkdir -p /home/user/.vscode-server/extensions

# Fix bash completion error
RUN sed -ri 's/(\. \$bcfile)/[ -f "$bcfile" ] \&\& \1/' /home/user/.bash_completion

# Set working directory
WORKDIR /workspace

# Launch bash shell by default
CMD ["/bin/bash"]
