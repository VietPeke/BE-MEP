# MEP Backend - Docker image for Render (build context = repo root)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY MEP_Management_System/MEP_Management_System.csproj ./MEP_Management_System/
RUN dotnet restore ./MEP_Management_System/MEP_Management_System.csproj
COPY . ./
RUN dotnet publish ./MEP_Management_System/MEP_Management_System.csproj -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish ./
ENV ASPNETCORE_URLS=http://0.0.0.0:10000
EXPOSE 10000
ENTRYPOINT ["dotnet", "MEP_Management_System.dll"]
