#addin "nuget:?package=Cake.Sonar"
#tool "nuget:?package=MSBuild.SonarQube.Runner.Tool"
#addin "nuget:?package=Cake.SonarScanner"
#addin nuget:?package=Cake.Git

///////////////////////////////////////////////////////////////////////////////
// ARGUMENTS
///////////////////////////////////////////////////////////////////////////////

var target = Argument("target", "Default");
var configuration = Argument("configuration", "Release");
var sonarEndpoint = "http://localhost:9000";
var sonarLogin = "admin";
var sonarPassword = "admin";
///////////////////////////////////////////////////////////////////////////////
// SETUP / TEARDOWN
///////////////////////////////////////////////////////////////////////////////

var buildDir = Directory("./Portal.Consultoras.Web/bin") + Directory(configuration);
var solutionPath = "./Belcorp.sln";
var branch = string.Empty;

Setup(ctx =>
{
   // Executed BEFORE the first task.
   var repositoryDirectoryPath = DirectoryPath.FromString("../");
   var currentBranch = ((ICakeContext)Context).GitBranchCurrent(repositoryDirectoryPath);
   branch = currentBranch.FriendlyName;

   Information("Current Branch: " + branch);
   Information("Running tasks...");
});

Teardown(ctx =>
{
   // Executed AFTER the last task.
   Information("Finished running tasks.");
});

///////////////////////////////////////////////////////////////////////////////
// TASKS
///////////////////////////////////////////////////////////////////////////////


Task("Clean")
    .Does(() =>
{
    CleanDirectory(buildDir);
});

Task("Restore-NuGet-Packages")
    .IsDependentOn("Clean")
    .Does(() =>
{
    NuGetRestore(solutionPath);
});

Task("Build")
    .IsDependentOn("Restore-NuGet-Packages")
    .Does(() =>
{
    MSBuild(solutionPath, settings =>
        settings.SetConfiguration(configuration));
});

Task("Run-Unit-Tests")
    .IsDependentOn("Build")
    .Does(() =>
{
    MSTest("./**/bin/" + configuration + "/*.UnitTest.dll");
});

Task("Java8")
  .Does(() => ChocolateyInstall("jre8"));

Task("Sonar")
  .IsDependentOn("SonarBegin")
  .IsDependentOn("Build")
  .IsDependentOn("SonarEnd");
 
Task("SonarBegin")
  .Does(() => 
{
    SonarBegin(new SonarBeginSettings {
        Url = sonarEndpoint,
        Name = "Consultoras - Web - ",
        Key = "portal.consultoras",
        Login = sonarLogin,
        Password = sonarPassword,
        // Branch = branch // Require https://docs.sonarqube.org/display/PLUG/Branch+Plugin
    });
});

Task("SonarEnd")
  .Does(() => 
{
    SonarEnd(new SonarEndSettings {
        Login = sonarLogin,
        Password = sonarPassword,
    });
});

Task("SonarJS")
    .Does(() => 
{
    SonarScanner(new SonarScannerSettings {
        Properties = new Dictionary<string, string> {
            {"sonar.host.url", sonarEndpoint},
            {"sonar.login", sonarLogin},
            {"sonar.password", sonarPassword},
            {"sonar.branch", branch},
            {"project.settings", "../sonar-project-js.properties"},
        }
    });
});

// Require: https://github.com/racodond/sonar-css-plugin
Task("SonarCSS")
    .Does(() => 
{
    SonarScanner(new SonarScannerSettings {
        Properties = new Dictionary<string, string> {
            {"sonar.host.url", sonarEndpoint},
            {"sonar.login", sonarLogin},
            {"sonar.password", sonarPassword},
            {"sonar.branch", branch},
            {"project.settings", "../sonar-project-css.properties"},
        }
    });
});

Task("SonarSQL")
    .Does(() => 
{
    SonarScanner(new SonarScannerSettings {
        Properties = new Dictionary<string, string> {
            {"sonar.host.url", sonarEndpoint},
            {"sonar.login", sonarLogin},
            {"sonar.password", sonarPassword},
            {"sonar.branch", branch},
            {"sonar.sources", "Scripts"},
            {"sonar.projectKey", "portal.consultoras.sql"},
            {"sonar.projectName", "Consultoras-SQL-"},
        }
    });
});

//////////////////////////////////////////////////////////////////////
// TASK TARGETS
//////////////////////////////////////////////////////////////////////

Task("Default")
    .IsDependentOn("Run-Unit-Tests");

//////////////////////////////////////////////////////////////////////
// EXECUTION
//////////////////////////////////////////////////////////////////////

RunTarget(target);