FROM kalilinux/kali-rolling

# Copy scripts to the container
COPY install.sh /app/install.sh
COPY ngrok.sh /app/ngrok.sh
COPY easy.sh /app/easy.sh
COPY gui.sh /app/gui.sh

# Make the scripts executable
RUN chmod +x /app/install.sh 
RUN chmod +x /app/ngrok.sh 
RUN chmod +x /app/easy.sh
RUN chmod +x /app/gui.sh

# Execute the scripts in order
RUN /install.sh && /ngrok.sh && /easy.sh && /gui.sh
