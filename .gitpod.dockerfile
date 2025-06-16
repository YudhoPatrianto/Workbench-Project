# Use Debian Bookworm for the os
FROM debian:bookworm

# Set All Environment Variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# Install packages
RUN apt update && \
    apt upgrade -y && \
    apt install sudo bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev locales wget zsh fonts-powerline python3 python3-pip python-venv python-is-python3 procps -y

# Install Repo
RUN curl https://storage.googleapis.com/git-repo-downloads/repo -o /usr/local/bin/repo && \
    chmod a+rx /usr/local/bin/repo && \
    repo --version

# Set Locale and localtime
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8 && \
    ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# Set ZSH And change shell theme
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended
RUN sed -i 's/ZSH_THEME=".*"/ZSH_THEME="gozilla"/g' ~/.zshrc
# Add User and switch to directory
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod && \
    sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers
USER gitpod

# Set Git
RUN git config --global user.name "YudhoPatrianto" && \
    git config --global user.email "kydh01123@gmail.com"

# Start ZSH
CMD ["zsh"]


