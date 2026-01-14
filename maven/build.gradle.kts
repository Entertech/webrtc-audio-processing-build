plugins {
    id("com.vanniktech.maven.publish") version "0.35.0"
    id("maven-publish")
}

val aarPath = System.getenv("EXPORT_AUDIO_AAR_PATH")?.takeIf { it.isNotBlank() }
    ?: error("EXPORT_AUDIO_AAR_PATH is required")

group = "ai.looktech.webrtc"
version = System.getenv("EXPORT_AUDIO_VERSION") ?: "0.0.0"

val artifactIdValue = "audio"

publishing {
    repositories {
        mavenLocal()
    }
}

mavenPublishing {
    publishToMavenCentral()

    val hasSigning = (project.findProperty("signingInMemoryKey") as? String)?.isNotBlank() == true
    val isLocalOnly = gradle.startParameter.taskNames
        .filter { it.contains("publish") }
        .let { tasks -> tasks.any { it.contains("MavenLocal") } && !tasks.any { it.contains("MavenCentral") } }
    if (hasSigning || !isLocalOnly) {
        signAllPublications()
    }

    coordinates(group.toString(), artifactIdValue, version.toString())
    pom {
        name.set("audio")
        description.set("WebRTC Audio package")
        inceptionYear.set("2026")
        url.set("https://github.com/Entertech/webrtc-audio-processing-build")
        licenses {
            license {
                name.set("The Apache License, Version 2.0")
                url.set("http://www.apache.org/licenses/LICENSE-2.0.txt")
                distribution.set("repo")
            }
        }
        developers {
            developer {
                id.set("Entertech")
                name.set("Entertech")
                url.set("https://github.com/Entertech")
            }
        }
        scm {
            url.set("https://github.com/Entertech/webrtc-audio-processing-build.git")
            connection.set("scm:git:git://github.com/Entertech/webrtc-audio-processing-build.git")
            developerConnection.set("scm:git:ssh://git@github.com/Entertech/webrtc-audio-processing-build.git")
        }
    }
}

artifacts {
    add("archives", file(aarPath)) {
        extension = "aar"
    }
}
