FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build-env
WORKDIR /App

COPY EmployeeRecordsApp.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /App

COPY --from=build-env /App/out ./

EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:${PORT}

ENTRYPOINT ["dotnet", "EmployeeRecordsApp.dll"]
