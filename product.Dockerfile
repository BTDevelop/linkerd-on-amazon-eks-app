#Build Stage
FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS build-env

WORKDIR /workdir

COPY ./src/Product.API ./src/Product.API/

RUN dotnet restore ./src/Product.API/Product.API.csproj
RUN dotnet publish ./src/Product.API/Product.API.csproj -c Release -o /publish

FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine
COPY --from=build-env /publish /publish
WORKDIR /publish
EXPOSE 5000
ENTRYPOINT ["dotnet", "Product.API.dll"]