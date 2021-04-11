FROM newtmitch/sonar-scanner:4.5


LABEL "com.github.actions.name"="SonarQube Scan"
LABEL "com.github.actions.description"="Scan your code with SonarQube Scanner to detect bugs, vulnerabilities and code smells in more than 25 programming languages."
LABEL "com.github.actions.icon"="check"
LABEL "com.github.actions.color"="green"

LABEL version="0.0.1"
LABEL repository="https://github.com/goldwindev/sonarqube-action"
LABEL homepage="https://github.com/goldwindev"
LABEL maintainer="goldwindev"

RUN npm config set unsafe-perm true && \
  npm install --silent --save-dev -g typescript@3.5.2 && \
  npm config set unsafe-perm false && \
  apk add --no-cache ca-certificates jq

ENV NODE_PATH "/usr/lib/node_modules/"

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

RUN cat /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
