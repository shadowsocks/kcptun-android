scalaVersion := "2.11.8"

enablePlugins(AndroidApp)
android.useSupportVectors

name := "kcptun"
organization := "com.github.shadowsocks"
version := "0.0.2"
versionCode := Some(2)

platformTarget := "android-25"

compileOrder := CompileOrder.JavaThenScala
javacOptions ++= "-source" :: "1.7" :: "-target" :: "1.7" :: Nil
scalacOptions ++= "-target:jvm-1.7" :: "-Xexperimental" :: Nil

proguardVersion := "5.3.2"
proguardCache := Seq()

shrinkResources := true
typedResources := false
resConfigs := Seq("zh-rCN")

resolvers += "Sonatype OSS Snapshots" at "https://oss.sonatype.org/content/repositories/snapshots"

libraryDependencies += "com.github.shadowsocks" %% "plugin" % "0.0.1-SNAPSHOT"

lazy val goBuild = TaskKey[Unit]("go-build", "Build go and kcptun")
goBuild := {
  Process(Seq("src/make.bash", minSdkVersion.value)) ! streams.value.log match {
    case 0 => // Success!
    case n => sys.error(s"Native build script exit code: $n")
  }
}
