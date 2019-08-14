# Set the base image
FROM alpine:3.6
RUN apk -v --update add \
        python \
        py-pip \
        groff \
        less \
        mailcap \
        mysql-client \
        curl \
        && \
    pip install --upgrade awscli s3cmd python-magic && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/*
# Set Default Environment Variables
ENV TARGET_DATABASE_PORT=3306
# Copy backup script and execute
COPY resources/perform-backup.sh /
RUN chmod +x /perform-backup.sh
CMD ["sh", "/perform-backup.sh"]
