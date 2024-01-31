// Include the generated gradle projects after the
// Skip build plugin transpiles the Swift to Kotlin 
gradle.settingsEvaluated {
    // perform the transpilation
    exec { commandLine("swift", "build", "--build-tests") }

    // include all the module projects that were transpiled by Skip
    val outputs = file(".build/plugins/outputs/")
    val projects = outputs.listFiles()
        .flatMap { it.listFiles().toList() }
        .filter { it.isDirectory }
        .map { it.resolve("skipstone/settings.gradle.kts") }
        .filter { it.isFile }

    for (project in projects) {
        includeBuild(project.parentFile) {
            // the name of the project is the same as the containing module
            name = project.parentFile.parentFile.name
        }
    }

    gradle.projectsLoaded {
        for (taskName in listOf("build", "test", "assemble")) {
            gradle.rootProject.tasks.register(taskName)
            val task = gradle.rootProject.tasks.findByName(taskName)
            for (project in projects) {
                val moduleName = project.parentFile.parentFile.name
                val modName = moduleName.removeSuffix("Tests")
                val isLocalSource = file("Sources/${moduleName}").isDirectory
                val isLocalTest = file("Tests/${moduleName}").isDirectory
                if (!isLocalSource && !isLocalTest) { 
                    continue // only add task aliases for the local modules
                }
                if ((taskName == "test") == (modName != moduleName)) {
                    // e.g., gradle test will run :SkipFoundationTests:SkipFoundation:test
                    task?.dependsOn(gradle.includedBuild(moduleName).task(":${modName}:${taskName}"))
                }
            }
        }
    }
}

