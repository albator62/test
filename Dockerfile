#
# Docker configuration for Plex Media server
#
FROM ${image_from}
MAINTAINER Arnaud HIEN <arnaud.hien@gmail.com>

# Versions
ENV PLEX_VERSION 1.0.0.2261-a17e99e

# Upgrade packages and install required packages for build
RUN \
        apt-get update && \
	    apt-get -y dist-upgrade && \
        apt-get -o Dpkg::Options::="--force-confold" --no-install-recommends -y install \
            socat && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#############################################
# Plex Media Server Install
#############################################
# download and install Plex Media Server
RUN \
	curl -L https://downloads.plex.tv/plex-media-server/${PLEX_VERSION}/plexmediaserver_${PLEX_VERSION}_amd64.deb -o /tmp/plexmediaserver_${PLEX_VERSION}_amd64.deb && \
	dpkg -i /tmp/plexmediaserver_${PLEX_VERSION}_amd64.deb && \
	rm -f /tmp/plexmediaserver_${PLEX_VERSION}_amd64.deb

#########################
# Customizations
#########################
# Add files to image
ADD files /

# Configure image
RUN \
	chmod 0755 /usr/local/sbin/*

# Mount configuration folders
VOLUME [ "/var/lib/plexmediaserver" ]

# Expose ports
EXPOSE 32400
