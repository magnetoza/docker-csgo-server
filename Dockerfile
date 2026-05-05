FROM ubuntu:22.04
MAINTAINER Max Gonzih <gonzih at gmail dot com>

ENV USER cs2
ENV HOME /home/$USER
ENV SERVER $HOME/hlserver

RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y install lib32gcc-s1 curl net-tools lib32stdc++6 locales \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && useradd $USER \
    && mkdir $HOME \
    && chown $USER:$USER $HOME \
    && mkdir $SERVER

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

ADD ./cs2_ds.txt $SERVER/cs2_ds.txt
ADD ./update.sh $SERVER/update.sh
ADD ./autoexec.cfg $SERVER/cs2/game/csgo/cfg/autoexec.cfg
ADD ./server.cfg $SERVER/cs2/game/csgo/cfg/server.cfg
ADD ./cs2.sh $SERVER/cs2.sh

RUN chown -R $USER:$USER $SERVER

USER $USER
RUN curl http://media.steampowered.com/client/steamcmd_linux.tar.gz | tar -C $SERVER -xvz \
    && $SERVER/update.sh

EXPOSE 27015/udp
EXPOSE 27015/tcp

WORKDIR /home/$USER/hlserver
ENTRYPOINT ["./cs2.sh"]
CMD ["+game_type" "0" "+game_mode" "1" "+mapgroup" "mg_active" "+map" "de_dust2"]
