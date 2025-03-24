# Spring Boot with PostgreSQL Dev Container

[![🇯🇵 日本語](https://img.shields.io/badge/%F0%9F%87%AF%F0%9F%87%B5-日本語-white)](./README.ja.md) [![🇺🇸 English](https://img.shields.io/badge/%F0%9F%87%BA%F0%9F%87%B8-English-white)](./README.md)

A template repository for Spring Boot development with PostgreSQL using devcontainer configuration. Ready-to-use development environment with pre-configured tools, dependencies, and database setup for Java backend development with Spring Boot and PostgreSQL.

## Features

- **Complete Java Development Environment**: Amazon Corretto Java 21 with Gradle 8.13
- **PostgreSQL Database**: PostgreSQL 15.8 with primary and replica setup
- **pgAdmin**: Web-based PostgreSQL administration tool pre-configured
- **VS Code Extensions**: Java, Spring Boot, Docker, and other essential development extensions
- **Consistent Environment**: Ensures all developers use the same tools and dependencies

## Architecture

This template provides a multi-container setup with:

1. **Java Application Container**: For Spring Boot development
2. **PostgreSQL Primary**: Main database server
3. **PostgreSQL Replica**: Read replica for scaling or testing replication
4. **pgAdmin**: Database management UI accessible at http://localhost:5050

## Prerequisites

- [Docker](https://www.docker.com/products/docker-desktop/)
- [VS Code](https://code.visualstudio.com/)
- [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension for VS Code

## Getting Started

### 1. Create a Repository from This Template

There are two ways to use this template:

**Option A: Use GitHub's "Use this template" feature**
1. Click the "Use this template" button at the top of this repository
2. Give your new repository a name
3. Choose to make it public or private
4. Click "Create repository from template"

**Option B: Clone and reinitialize**
```bash
# Clone the template repository
git clone https://github.com/yourusername/devcontainer-spring-boot-with-postgresql.git my-new-project
cd my-new-project
# Remove existing git history and start fresh
rm -rf .git
git init
git add .
git commit -m "Initial commit from template"
```

### 2. Clone Your New Project

If you used Option A above:
```bash
git clone https://github.com/yourusername/your-new-repo-name.git
cd your-new-repo-name
```

### 3. Modify the Configuration

1. Update passwords in the `.devcontainer/docker-compose.yml` file:
   - Replace `<your-password-here>` with secure passwords for both PostgreSQL and pgAdmin

2. Customize the project name in `.devcontainer/devcontainer.json` (optional)

3. Adjust Docker configurations as needed:
   - `.devcontainer/Dockerfile` for Java environment
   - `.devcontainer/DockerfilePostgreSQL` for PostgreSQL configuration

### 4. Open in VS Code

```bash
code .
```

### 5. Start the Dev Container

1. Click on the green button in the lower-left corner of VS Code
2. Select "Reopen in Container" from the menu

VS Code will build the dev container and open your project inside it. This process may take several minutes on the first run.

## Using the Environment

### Accessing the Database

- PostgreSQL Primary: `jdbc:postgresql://db_primary:5432/postgres`
- PostgreSQL Replica: `jdbc:postgresql://db_replica:5432/postgres`
- Username: `root` (defined in docker-compose.yml)
- Password: Your configured password

### Using pgAdmin

1. Access pgAdmin through your browser at http://localhost:5050
2. Log in using:
   - Email: `sample@example.com` (defined in docker-compose.yml)
   - Password: Your configured password

### Spring Boot Development

1. Create a new Spring Boot project:
   - Using Spring Initializr extension in VS Code
   - Or using the command line with Spring CLI
   
2. Add the PostgreSQL dependency to your project:
   ```gradle
   dependencies {
       implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
       implementation 'org.postgresql:postgresql'
       // other dependencies
   }
   ```

3. Configure the database connection in `application.properties` or `application.yml`:
   ```properties
   spring.datasource.url=jdbc:postgresql://db_primary:5432/postgres
   spring.datasource.username=root
   spring.datasource.password=your-password-here
   spring.jpa.hibernate.ddl-auto=update
   spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
   ```

## Troubleshooting

- **Container fails to build**: Check Docker is running with sufficient resources
- **Database connection issues**: Verify passwords in docker-compose.yml match your application configuration
- **Java version issues**: Confirm the Java version in the Dockerfile matches your project requirements

## Contributing

Contributions to improve this template are welcome! Please submit a pull request or open an issue.

## License

This template is available under the MIT License. See the LICENSE file for more information.
