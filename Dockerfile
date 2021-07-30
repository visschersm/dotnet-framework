# Remember to ignore bin/obj since the packages.config setup of dotnet framework can conflict the restore.

FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY . .
RUN dotnet restore

RUN dotnet build

RUN dotnet test
