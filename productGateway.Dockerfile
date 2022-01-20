#Build Stage
FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS build-env

WORKDIR /workdir

COPY ./src/ProductGateway.API ./src/ProductGateway.API/

RUN dotnet restore ./src/ProductGateway.API/ProductGateway.API.csproj
RUN dotnet publish ./src/ProductGateway.API/ProductGateway.API.csproj -c Release -o /publish

FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine
COPY --from=build-env /publish /publish
WORKDIR /publish
EXPOSE 5000
ENTRYPOINT ["dotnet", "ProductGateway.API.dll"]