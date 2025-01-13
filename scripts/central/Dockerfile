FROM oracleinanutshell/oracle-xe-11g:latest
EXPOSE 1521

# Copy your files
COPY . /app

# Copy the startup script
COPY ./run.sh /docker-entrypoint-initdb.d/

# Make the script executable
RUN chmod +x /docker-entrypoint-initdb.d/run.sh


