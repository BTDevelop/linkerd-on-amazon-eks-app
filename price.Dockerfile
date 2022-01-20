#Build Stage
FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS build-env

WORKDIR /workdir

COPY ./src/Price.API ./src/Price.API/

RUN dotnet restore ./src/Price.API/Price.API.csproj
RUN dotnet publish ./src/Price.API/Price.API.csproj -c Release -o /publish

FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine
COPY --from=build-env /publish /publish
WORKDIR /publish
EXPOSE 5000
ENTRYPOINT ["dotnet", "Price.API.dll"]