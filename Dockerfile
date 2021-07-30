# Remember to ignore bin/obj since the packages.config setup of dotnet framework can conflict the restore.

FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY ConsoleApp1/*.csproj ./ConsoleApp1/
COPY ClassLibrary1/*.csproj ./ClassLibrary1/
COPY MSUnitTestProject/*.csproj ./MSUnitTestProject/
#COPY XUnitTestProject/*.csproj ./XUnitTestProject/
#COPY NUnitTestProject/*.csproj ./NUnitTestProject/
RUN dotnet restore

# copy everything else and build app
COPY . .
WORKDIR /app/ConsoleApp1
RUN dotnet build --no-restore

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

FROM build AS publish
WORKDIR /app/ConsoleApp1
RUN dotnet publish -c Release -o out --no-restore


FROM mcr.microsoft.com/dotnet/framework/runtime:4.8 AS runtime
WORKDIR /app
COPY --from=publish /app/ConsoleApp1/out ./
ENTRYPOINT ["ConsoleApp1.exe"]