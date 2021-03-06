# Use SDK Image
FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env
MAINTAINER Aditya Mandil
WORKDIR /app

# Copy csproj and restore for dependencies 
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image & Expose Port
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
WORKDIR /app
EXPOSE 80
COPY --from=build-env /app/out .
ENTRYPOINT [ "dotnet","AdityaWebApi.dll" ]
