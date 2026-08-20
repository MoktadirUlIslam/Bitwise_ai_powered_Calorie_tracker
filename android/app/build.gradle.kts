plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.bitwise_ai_calorri_tracker"
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17  // CHANGED: Kotlin 2.1.0 requires Java 17
        targetCompatibility = JavaVersion.VERSION_17  // CHANGED: Kotlin 2.1.0 requires Java 17
    }

    kotlinOptions {
        jvmTarget = "17"  // CHANGED: Kotlin 2.1.0 requires JVM 17
    }

    defaultConfig {
        applicationId = "com.example.bitwise_ai_calorri_tracker"
        minSdk = 23
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("com.google.firebase:firebase-analytics:22.1.2")
    implementation("com.google.firebase:firebase-auth:23.1.0")
    implementation("com.google.firebase:firebase-firestore:25.1.1")
    implementation("androidx.multidex:multidex:2.0.1")
}