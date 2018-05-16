FROM gentoo-base-container:latest
RUN mkdir -p /data/nextcloud
ADD etc /etc
ADD var /var
ADD container-specific-setup.sh /
RUN echo 'rc_sys="docker"' >> /etc/rc.conf && echo 'rc_provide="net"' >> /etc/rc.conf
