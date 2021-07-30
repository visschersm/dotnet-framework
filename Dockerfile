# Remember to ignore bin/obj since the packages.config setup of dotnet framework can conflict the restore.

FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY MSUnitTestProject/*.csproj ./MSUnitTestProject/
#COPY XUnitTestProject/*.csproj ./XUnitTestProject/
#COPY NUnitTestProject/*.csproj ./NUnitTestProject/
RUN dotnet restore

FROM build AS testrunner
WORKDIR /app/MSUnitTestProject
ENTRYPOINT ["dotnet", "test", "--logger:trx"]

FROM build AS test
WORKDIR /app/MSUnitTestProject
RUN dotnet test

#WORKDIR /app/NUnitTestProject
#RUN dotnet test
#
#WORKDIR /app/XUnitTestProject
#RUN dotnet test