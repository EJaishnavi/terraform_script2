FROM hashicorp/terraform:1.14.0-alpha20250724
WORKDIR /app
COPY . .
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/bin/sh", "./entrypoint.sh"]
