#################################################################################################
#                                           INSTRUCTIONS                                        #
#################################################################################################
# See the README.md file from the source repository from which you downloaded this file


# correct image
FROM ubuntu:20.04

# define env for PWSH on Linux
ENV PS_INSTALL_FOLDER=/opt/microsoft/powershell/7 \
    # Define ENVs for Localization/Globalization
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false \
    C_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8

RUN apt update -y \
    && apt upgrade -y \
    && apt-get install -y wget apt-transport-https software-properties-common \
    && wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb" \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update -y \
    && apt-get install -y powershell \
    && apt install git -y \
    && apt-get install awscli -y

# install terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor > /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list

RUN apt update -y \
    && apt upgrade -y \
    && apt install terraform -y

# create the container instance developer user
RUN useradd cohesion2022 -s /usr/bin/bash \
    && mkdir /home/cohesion2022 \
    && chown cohesion2022:cohesion2022 /home/cohesion2022 \
    && chmod 770 /home/cohesion2022

# copy the .profile file to the container instance development user
COPY .profile /home/cohesion2022
RUN chown cohesion2022:cohesion2022 /home/cohesion2022/.profile



