FROM ghcr.io/runatlantis/atlantis:latest

USER root

# Install AWS CLI
RUN apk add --no-cache aws-cli

# Create AWS credentials directory and file
RUN mkdir -p /home/atlantis/.aws && \
    touch /home/atlantis/.aws/credentials

# Set correct ownership for the atlantis user
RUN chown -R atlantis:1000 /home/atlantis/

# Switch back to the atlantis user
USER atlantis


