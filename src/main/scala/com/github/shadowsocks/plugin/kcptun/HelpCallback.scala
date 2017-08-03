package com.github.shadowsocks.plugin.kcptun

import com.github.shadowsocks.plugin.PluginOptions

import scala.io.Source

/**
  * @author Mygod
  */
class HelpCallback extends com.github.shadowsocks.plugin.HelpCallback {
  override def produceHelpMessage(options: PluginOptions): CharSequence = {
    val process = new ProcessBuilder(getApplicationInfo.nativeLibraryDir + "/libkcptun.so", "--help")
      .redirectErrorStream(true)
      .start()
    process.waitFor()
    Source.fromInputStream(process.getInputStream())
      .getLines()
      .dropWhile(line => line != "GLOBAL OPTIONS:")
      .drop(1)
      .takeWhile(line => line.length() > 3)
      .filter(line =>
        !line.startsWith("   --localaddr ") &&
        !line.startsWith("   --remoteaddr ") &&
        !line.startsWith("   -c ") &&
        !line.startsWith("   -V ") &&
        !line.startsWith("   --fast-open ") &&
        !line.startsWith("   --help,") &&
        !line.startsWith("   --version,"))
      .mkString("\n")
      .replaceAll(" {2,}", "\n")
      .replaceAll("--", "")
      .replaceAll(" value", "=value;")
      .substring(1) // remove 1st \n
  }
}
