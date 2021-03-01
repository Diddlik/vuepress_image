FROM node:latest AS BUILD_IMAGE

RUN curl -sfL https://install.goreleaser.com/github.com/tj/node-prune.sh | bash -s -- -b /usr/local/bin

WORKDIR /usr/src/docs

COPY . /usr/src/docs

EXPOSE 8080

RUN yarn add -D vuepress

RUN yarn add -D vuepress-plugin-table-of-contents

RUN yarn add -D vuepress-plugin-flowchart

RUN yarn add -D vuepress-plugin-mermaidjs

RUN yarn add -D vuepress-bar

RUN npm prune --production

RUN /usr/local/bin/node-prune

FROM node:current-alpine

WORKDIR /usr/src/docs

# copy from build image
COPY --from=BUILD_IMAGE /usr/src/docs /usr/src/docs

CMD yarn dev

