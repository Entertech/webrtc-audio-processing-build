plugins {
    alias(libs.plugins.gradle.nexus.publish)
}

group = property("GROUP") as String
version = property("VERSION_NAME") as String

fun getReleaseRepositoryUrl(): String {
    return findProperty("RELEASE_REPOSITORY_URL")?.toString()
        ?: "https://ossrh-staging-api.central.sonatype.com/service/local/"
}

fun getProjectSnapshotRepositoryUrl(): String {
    return findProperty("SNAPSHOT_REPOSITORY_URL")?.toString()
        ?: "https://central.sonatype.com/repository/maven-snapshots/"
}

fun getRepositoryUsername(): String {
    return findProperty("nexusUsername")?.toString() ?: ""
}

fun getRepositoryPassword(): String {
    return findProperty("nexusPassword")?.toString() ?: ""
}

nexusPublishing {
    packageGroup = property("GROUP") as String
    repositories {
        sonatype {
            nexusUrl = uri(getReleaseRepositoryUrl())
            snapshotRepositoryUrl = uri(getProjectSnapshotRepositoryUrl())
            username = getRepositoryUsername()
            password = getRepositoryPassword()
        }
    }
}
