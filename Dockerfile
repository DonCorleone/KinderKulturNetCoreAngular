FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
RUN apt-get -qq update && apt-get install -y build-essential
RUN curl -sL https://deb.nodesource.com/setup_10.x |  bash -
RUN apt-get install -y nodejs
RUN npm i -g --unsafe-perm node-sass && npm rebuild --unsafe-perm node-sass -f
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY KinderKulturServer.csproj .
RUN apt-get -qq update && apt-get install build-essential -y && apt-get install -my wget gnupg && apt-get -qq -y install bzip2 
RUN curl -sL https://deb.nodesource.com/setup_10.x |  bash -
RUN apt-get install -y nodejs
RUN dotnet restore ./KinderKulturServer.csproj
COPY . .
WORKDIR /src/
RUN dotnet build KinderKulturServer.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish KinderKulturServer.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "KinderKulturServer.dll"]
