# vim: set ft=make :
# This file can be modified downstream to add custom just commands

# enable rootless docker for user
enable-rootless-docker-for-user:
    #!/usr/bin/bash
    /usr/bin/dockerd-rootless-setuptool.sh install
    mkdir -p ~/.config/docker/
    json='{
    "default-address-pools":
        [
        {"base":"10.2.0.0/16","size":24}
        ]
    }'
    echo "$json" | tee -a ~/.config/docker/daemon.json
    systemctl --user enable docker.service
    systemctl --user start docker.service
    systemctl --user restart docker.service
    echo 'export DOCKER_HOST=unix:///run/user/1000/docker.sock' >> ~/.bashrc

# starship
install-starship:
    #!/usr/bin/bash
    mkdir -p ~/.local/bin
    mkdir -p /tmp/starship
    cd /tmp/starship
    curl -O https://starship.rs/install.sh
    chmod +x install.sh
    ./install.sh -b ~/.local/bin -y
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
    cd ~
    source ~/.bashrc
    