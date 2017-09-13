node {
    try {    
        ws("workspace/${env.JOB_NAME}") {
            stage('Start') {
                notify('Job started')
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
                        bat ".\\.nuget\\Nuget.exe restore"
                        bat "${sqScannerMsBuildHome}\\SonarQube.Scanner.MSBuild.exe begin /k:portal.consultoras /n:\"Consultoras - Web - \" /d:sonar.host.url=%SONAR_HOST_URL% /d:sonar.login=%SONAR_AUTH_TOKEN% /d:sonar.branch=${branchName} /d:sonar.inclusions=**/*.cs"
                        bat "\"${msBuildHome}\"\\MSBuild.exe /t:Rebuild"
                        bat "${sqScannerMsBuildHome}\\SonarQube.Scanner.MSBuild.exe end"
                        bat "${sqScannerHome}\\sonar-scanner.bat -Dsonar.host.url=%SONAR_HOST_URL% -Dsonar.login=%SONAR_AUTH_TOKEN% -Dsonar.branch=${branchName} -Dproject.settings=../sonar-project-js.properties"
                        bat "${sqScannerHome}\\sonar-scanner.bat -Dsonar.host.url=%SONAR_HOST_URL% -Dsonar.login=%SONAR_AUTH_TOKEN% -Dsonar.branch=${branchName} -Dproject.settings=../sonar-project-css.properties"
                    }
                }
            }
            stage('Mail') {
                currentBuild.result = 'SUCCESS'
                emailLog()
            }
           stage('Finish') {
                notify('Job finished')
            }
        }
    }
    catch(error) {
        currentBuild.result = 'FAILURE'
        notify(error)
        emailLog()
    }
}

def notify(status) {
    def to = ""
    def subject = "${status}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
    def blueOceanBuildUrl = "${env.RUN_DISPLAY_URL}"
    def summary = "${subject} (${blueOceanBuildUrl})"
    def details = """<p>${status}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
        <p>Check console output at <a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a></p>"""

    slackSend (
        message: summary,
        channel: '#jenkins',
        teamDomain: 'arquitectura-td',
        tokenCredentialId: 'arquitecturatd_slack_credentials'
    )
}

def emailLog() {
    email(
        "ldiego@belcorp.biz, jdongo@belcorp.biz, carloshurtado@belcorp.biz, elazaro@belcorp.biz",
        "${env.JOB_NAME} - Build #${env.BUILD_NUMBER} - ${currentBuild.result}!",
        '${JELLY_SCRIPT,template="log"}'
    )
}

def email(to, subject, template) {
    try {
        def from = "belcorpdev@gmail.com"
        def mimeType = "text/html"
        def attachLog = true
        def compressLog = true

       emailext from: from,
                to: to,
                subject: subject,
                mimeType: mimeType,
                body: template,
                attachLog: attachLog,
                compressLog: compressLog
    } catch (err) {
        echo "${err}"
    }
}
