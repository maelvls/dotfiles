# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.154.0/containers/ubuntu/.devcontainer/base.Dockerfile

ARG VARIANT="focal"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

RUN cat /etc/passwd
RUN ls /etc/sudoers.d

RUN groupadd temp
RUN useradd --gid temp -m temp
USER temp

COPY --chown=temp . dotfiles/
RUN echo temp ALL=\(root\) NOPASSWD:ALL >/etc/sudoers.d/temp
RUN chmod 0440 /etc/sudoers.d/temp

ENV NONINTERACTIVE=yes
RUN cd dotfiles && ./installdotfiles.sh -f --brew
