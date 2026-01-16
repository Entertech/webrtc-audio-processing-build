plugins {
    `maven-publish`
    signing
}

val POM_ARTIFACT_ID = "audio"
val AAR_FILE = "libexport_audio.aar"

afterEvaluate {
    publishing {
        publications {
            create<MavenPublication>("android") {
                groupId = property("GROUP") as String
                artifactId = POM_ARTIFACT_ID
                version = property("VERSION_NAME") as String
                artifact(AAR_FILE)
                artifact("deploy/sources.jar") {
                    classifier = "sources"
                }
                artifact("deploy/javadoc.jar") {
                    classifier = "javadoc"
                }
                pom {
                    name = property("POM_NAME") as String
                    packaging = property("POM_PACKAGING") as String
                    description = property("POM_DESCRIPTION") as String
                    url = property("POM_URL") as String

                    scm {
                        url = property("POM_SCM_URL") as String
                        connection = property("POM_SCM_CONNECTION") as String
                        developerConnection = property("POM_SCM_DEV_CONNECTION") as String
                    }

                    licenses {
                        license {
                            name = property("POM_LICENCE_NAME") as String
                            url = property("POM_LICENCE_URL") as String
                            distribution = property("POM_LICENCE_DIST") as String
                        }
                    }

                    developers {
                        developer {
                            id = property("POM_DEVELOPER_ID") as String
                            name = property("POM_DEVELOPER_NAME") as String
                        }
                    }
                }
            }
        }

        signing {
            sign(publishing.publications)
        }
    }
}
