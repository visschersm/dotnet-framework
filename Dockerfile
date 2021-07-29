FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 as build
WORKDIR /app

COPY *.sln .
COPY ClassLibrary1/*.csproj ./utils/
COPY UnitTestProject1/*.csproj ./tests/
RUN dotnet restore

# copy everything else and build app
COPY . .
WORKDIR /app
RUN dotnet build --no-restore


FROM build AS testrunner
WORKDIR /app/tests
ENTRYPOINT ["dotnet", "test", "--logger:trx"]

FROM build AS test
WORKDIR /app/tests
RUN dotnet test
