FROM debian:bookworm-slim

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git=1:2.39.* \
        curl=7.88.* \
        sed=4.9.* \
        bash=5.2.* \
        gnupg=2.2.* \
        diffutils=1:3.8.* && \
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
    gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
    tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
    apt-get update && \
    apt-get install -y --no-install-recommends gh=2.* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
COPY scorecards.yml /app/scorecards.yml

RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
