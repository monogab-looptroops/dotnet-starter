# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the .csproj and restore any dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application and build it
COPY . ./
RUN dotnet publish -c Release -o out

# Use the official .NET runtime image to run the app
FROM mcr.microsoft.com/dotnet/runtime:9.0

# Set the working directory inside the container
WORKDIR /app

# Copy the published app from the build container
COPY --from=build /app/out .

# Run the app
ENTRYPOINT ["dotnet", "dotnet-starter.dll"]