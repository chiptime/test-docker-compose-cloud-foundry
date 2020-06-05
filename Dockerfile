FROM node:12.2.0

WORKDIR /app/

#install SAP Cloud SDK CLI
RUN npm set @sap:registry=https://npm.sap.com

# --unsafe-perm=true --allow-root for fix error in install global dependency
RUN npm install -g @sap/cds-dk --unsafe-perm=true --allow-root


#install dependencies
COPY ./package.json .

RUN npm install 

COPY . .

WORKDIR /app/packages/bookshop

EXPOSE 4004

ENTRYPOINT cds watch
