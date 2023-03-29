FROM cruizba/ubuntu-dind

# Copy scripts to the container
COPY install.sh /install.sh
COPY ngrok.sh /ngrok.sh
COPY easy.sh /easy.sh

# Make the scripts executable
RUN chmod +x /install.sh /ngrok.sh /easy.sh

# Execute the scripts in order
RUN /install.sh && /ngrok.sh && /easy.sh
