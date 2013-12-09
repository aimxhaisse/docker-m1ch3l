FROM ubuntu:latest
MAINTAINER s. rannou <mxs@sbrk.org>

# deps
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y golang git binutils gcc netcat bc

# user
RUN groupadd m1ch3l
RUN useradd -m m1ch3l -g m1ch3l

# build
RUN cd /home/m1ch3l && git clone https://github.com/aimxhaisse/gorobot/ && cd gorobot && sed -i s/mxs/m1ch3l/ all.bash && ./all.bash build
ADD m1ch3l.json /home/m1ch3l/gorobot/root/
RUN chown -R m1ch3l:m1ch3l /home/m1ch3l

# admin port for commands
EXPOSE 3112

# here we go
CMD /home/m1ch3l/gorobot/all.bash start && tail -F /home/m1ch3l/gorobot/root/m1ch3l.log
