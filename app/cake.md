# Cake Build

Referencia [cakebuild.net](https://cakebuild.net/).

## Requerimientos
- Instalar [Java 8 SE Runtime](http://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html) para Sonar-Scanner.

## Tasks
- Restore-NuGet-Packages
- Build
- Run-Unit-Tests
- Sonar
- SonarJS
- SonarCSS (requiere [plugin](https://github.com/racodond/sonar-css-plugin) instalado en sonarqube)

## Sonar-Scanner

Abrir powersheell en el directorio de build.cake , y ejecutar

Para C#
```
.\build.ps1 -Target Sonar
```

Para Javascript
```
.\build.ps1 -Target SonarJS
```
