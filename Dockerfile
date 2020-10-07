FROM node
USER root
RUN npm install
EXPOSE 4200
CMD [ "node", "app.js" ]
