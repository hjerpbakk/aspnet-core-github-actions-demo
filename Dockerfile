FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS builder
WORKDIR /source

COPY ./src/GitHubActionsDemo.sln .
COPY ./src/WebApi/WebApi.csproj ./WebApi/
COPY ./src/Tests/Tests.csproj ./Tests/

RUN dotnet restore

COPY ./src/WebApi ./WebApi
COPY ./src/Tests ./Tests

RUN dotnet test ./GitHubActionsDemo.sln --configuration Release --no-restore

RUN dotnet publish "./WebApi/WebApi.csproj" --output "../dist" --configuration Release --no-restore

FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-buster-slim
WORKDIR /app
COPY --from=builder /dist . 
EXPOSE 80 443
ENTRYPOINT ["dotnet", "WebApi.dll"]
