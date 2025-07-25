FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y git curl sed bash gnupg diffutils     && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg |     gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg &&     echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" |     tee /etc/apt/sources.list.d/github-cli.list > /dev/null &&     apt-get update && apt-get install -y gh

COPY entrypoint.sh /entrypoint.sh
COPY scorecards.yml /app/scorecards.yml

RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
