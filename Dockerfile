# ==========================================
# Stage: Base
# ==========================================
FROM node:24.13.0-bookworm AS base
WORKDIR /usr/src/app
COPY package*.json ./

# ==========================================
# Stage: Development
# ==========================================
FROM base AS development
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "run", "start:dev"]

# ==========================================
# Stage: Build
# ==========================================
FROM base AS build
RUN npm ci
COPY . .
RUN npm run build

# ==========================================
# Stage: Production
# ==========================================
FROM node:24.13.0-bookworm AS production
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force
COPY --from=build /usr/src/app/dist ./dist
EXPOSE 3000
USER node
CMD ["node", "dist/main.js"]