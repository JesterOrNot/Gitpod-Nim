FROM gitpod/workspace-full

USER gitpod
RUN curl https://nim-lang.org/choosenim/init.sh -sSf | sh
