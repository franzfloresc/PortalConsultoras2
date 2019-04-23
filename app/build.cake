#addin nuget:?package=Cake.Sonar&version=1.1.18
#tool  nuget:?package=MSBuild.SonarQube.Runner.Tool&version=4.3.1
#addin nuget:?package=Cake.SonarScanner&version=1.1.0
#addin nuget:?package=Cake.Git&version=0.19.0

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
string hash = null;

Setup(ctx =>
{
   // Executed BEFORE the first task.
   var repositoryDirectoryPath = DirectoryPath.FromString("../");
   var currentBranch = GitBranchCurrent(repositoryDirectoryPath);
   branch = "DEV";//currentBranch.FriendlyName;
   var commit = GitLog(repositoryDirectoryPath, 1).FirstOrDefault();
   if (commit != null) {
       hash = commit.Sha.Substring(0, 11);
   }

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
        Name = "Consultoras - Web - " + branch,
        Key = "portal.consultoras",
        Login = sonarLogin,
        Password = sonarPassword,
        Version = hash,
        Exclusions = "**/*.js,**/*.css,**/emt_chat/**,*UnitTest/**"
        // Branch = branch
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
            {"sonar.projectVersion", hash},
            {"project.settings", "../sonar-project-js.properties"},
        }
    });
});

// Require: https://docs.sonarqube.org/display/PLUG/SonarCSS
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