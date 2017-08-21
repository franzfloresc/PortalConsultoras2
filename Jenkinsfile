node {
    try {    
        stage('Start') {
            notify('Job started')
        }
        /*
        stage('Compile') {
            checkout scm
            dir('app') {
                powershell("& \"${tool 'msbuild'}msbuild\" Belcorp.sln /v:q /clp:Summary")
            }
        }*/
        /*
        stage('Linting') {
            bat "yarn install"
            try {
                bat "npm test"
            } 
            catch(err) {
            }
            step([$class: 'CheckStylePublisher',
                pattern: '* * /results/ *.xml',
                unstableTotalAll: '0',
                usePreviousBuildAsReference: true])
        }
        */
        stage('Sonar Metrics') {
            def sqScannerMsBuildHome = tool 'sonar-scanner-msbuild'
            def msBuildHome = tool 'msbuild'
            checkout scm
            withSonarQubeEnv('Sonar Qube Server') {
                dir('app') {
                    // Due to SONARMSBRU-307 value of sonar.host.url and credentials should be passed on command line
                    bat "${sqScannerMsBuildHome}\\SonarQube.Scanner.MSBuild.exe begin /k:portal.consultoras.2 /n:SomosBelcorp2 /v:1.0 /d:sonar.host.url=%SONAR_HOST_URL% /d:sonar.login=%SONAR_AUTH_TOKEN% /d:sonar.branch=${env.BRANCH_NAME} /d:sonar.inclusions=**/*.cs"
                    bat "\"${msBuildHome}\"\\MSBuild.exe /t:Rebuild"
                    bat "${sqScannerMsBuildHome}\\SonarQube.Scanner.MSBuild.exe end"
                }
            }
        }
        /*
        stage('Quality Gate') {
            timeout(time: 3, unit: 'MINUTES') {
                def qg = waitForQualityGate()
                if (qg.status != 'OK') {
                    error "Pipeline aborted due to quality gate failure: ${qg.status}"
                }
            }
        }
        */
        stage('Finish') {
            notify('Job finished')
        }
    }
    catch(err) {
        sh "echo **************************************"
        sh "echo ${error}"
        sh "echo **************************************"
        notify(error)
        currentBuild.result = 'FAILURE'
    }
}

def notify(status) {
    def to = ""
    def subject = "${status}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
    def blueOceanBuildUrl = "${env.JENKINS_URL}blue/organizations/jenkins/${env.JOB_NAME}/detail/${env.JOB_NAME}/${env.BUILD_NUMBER}/pipeline"
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
