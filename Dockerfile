FROM haskell

RUN mkdir workspace
WORKDIR /workspace
COPY . /workspace

# Utils
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    cabal-install \
    vim \
    locales \
    git \
    zsh \
    && rm -rf /var/lib/apt/lists/*

# ZSH
RUN locale-gen en_US.UTF-8
RUN  wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN chsh -s $(which zsh)

# Installing Cabal
RUN cabal update 
RUN cabal install parsec

CMD ["zsh"]

