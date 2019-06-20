node {
    try {    
        ws("workspace/${env.JOB_NAME}") {
            stage('Start') {
                notifyBuild('STARTED')
                hygieiaBuildPublishStep buildStatus: 'InProgress'
            }
            stage('Clean') {
                step([$class: 'WsCleanup'])
            }
            stage('Checkout') {
                checkout scm
            }
            stage('Sonar') {
                def sqScannerMsBuildHome = tool 'sonar-scanner-msbuild'
                def sqScannerHome = tool 'sonar-scanner'
                def msBuildHome = tool 'msbuild'
                def branchName = env.BRANCH_NAME.capitalize()
                withSonarQubeEnv('Sonar Qube Server') {
                    dir('app') {
                        bat ".\\.nuget\\Nuget.exe restore -Source \"https://api.nuget.org/v3/index.json;https://www.nuget.org/api/v2/\""
                        bat "${sqScannerMsBuildHome}\\SonarScanner.MSBuild.exe begin /k:portal.consultoras /n:\"Consultoras - Web - \" /d:sonar.host.url=%SONAR_HOST_URL% /d:sonar.login=%SONAR_AUTH_TOKEN% /d:sonar.branch=${branchName} /d:sonar.inclusions=**/*.cs"
                        bat "\"${msBuildHome}\"\\MSBuild.exe /t:Rebuild"
                        bat "${sqScannerMsBuildHome}\\SonarScanner.MSBuild.exe end /d:sonar.login=%SONAR_AUTH_TOKEN%"
                        bat "${sqScannerHome}\\sonar-scanner.bat -Dsonar.host.url=%SONAR_HOST_URL% -Dsonar.login=%SONAR_AUTH_TOKEN% -Dsonar.branch=${branchName} -Dproject.settings=../sonar-project-js.properties"
                        bat "${sqScannerHome}\\sonar-scanner.bat -Dsonar.host.url=%SONAR_HOST_URL% -Dsonar.login=%SONAR_AUTH_TOKEN% -Dsonar.branch=${branchName} -Dproject.settings=../sonar-project-css.properties"
                    }
                }
            }
            stage('Linting') {
                bat "yarn install --ignore-engines"
                try {
                    bat "npm run jslint"
                } 
                catch(error) {
                    def patternHtml = "**/results/*-lint.html"
                    archiveArtifacts "${patternHtml}"
                    throw error
                }
            }
        }
    }
    catch(error) {
        currentBuild.result = 'FAILURE'
        hygieiaBuildPublishStep buildStatus: 'Failure'
    }
    stage('Finish') {
        notifyBuild(currentBuild.result)
        hygieiaBuildPublishStep buildStatus: 'Success'
    }
}

def notifyBuild(String buildStatus = 'STARTED') {
    // default build status in case is not passed as parameter
    buildStatus = buildStatus ?: 'SUCCESS'

    // variables and constants
    def colorName = 'RED'
    def colorCode = '#FF0000'
    def from = 'jenkins@belcorp.biz'
    def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
    def summary = "${subject} (${env.RUN_DISPLAY_URL})"
    def details = "<p>${buildStatus}: Job <a href='${env.RUN_DISPLAY_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a></p>"

    // override default values based on build status
    if (buildStatus == 'STARTED') {
        color = 'YELLOW'
        colorCode = '#FFFF00'
    } else if (buildStatus == 'SUCCESS') {
        color = 'GREEN'
        colorCode = '#00FF00'
    } else {
        color = 'RED'
        colorCode = '#FF0000'
    }

    // send notifications
	 slackSend (
        color: colorCode,
        message: summary,
        channel: '#jenkins',
        teamDomain: 'hubconsultorasbelcorp',
        tokenCredentialId: 'hubconsultorasbelcorp_slack_credentials')
    
    def url = "https://outlook.office.com/webhook/dd5fc7a8-3175-499d-aa3b-f0fccf4379a7@e1fd30ac-0226-49d7-9516-edd8d1e0b18d/JenkinsCI/ed1d974ebb514f5a987abedd565f962d/de686be7-b5fb-44ff-ba7e-2dbd6e742f03"

    office365ConnectorSend (
        color: colorCode, 
        message: summary,
        status: buildStatus,
        webhookUrl: url)
    
    // send email in case of failure
    if (buildStatus == 'FAILURE') {
        emailext(
            from: from,
            subject: subject,
            body: '${JELLY_SCRIPT,template="log"}',
            to: '$DEFAULT_RECIPIENTS',
            attachLog: true,
            compressLog: true
        )
    }
}