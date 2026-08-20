// This file should ONLY contain buildscript and allprojects
buildscript {
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        // Use the same versions as in settings.gradle.kts
        classpath("com.android.tools.build:gradle:8.7.3")  // MATCHES settings.gradle.kts
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:2.1.0")  // MATCHES settings.gradle.kts
        classpath("com.google.gms:google-services:4.4.2")  // MATCHES settings.gradle.kts
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}