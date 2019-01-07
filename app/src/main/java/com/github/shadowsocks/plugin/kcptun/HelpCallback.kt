package com.github.shadowsocks.plugin.kcptun

import com.github.shadowsocks.plugin.PluginOptions

class HelpCallback : com.github.shadowsocks.plugin.HelpCallback() {
    override fun produceHelpMessage(options: PluginOptions): CharSequence =
            ProcessBuilder(applicationInfo.nativeLibraryDir + "/libkcptun.so", "--help")
                    .redirectErrorStream(true)
                    .start()
                    .inputStream.bufferedReader().useLines {
                it.dropWhile { it != "GLOBAL OPTIONS:" }
                        .drop(1)
                        .takeWhile { it.length > 3 }
                        .filter {
                            !it.startsWith("   --localaddr ") &&
                                    !it.startsWith("   --remoteaddr ") &&
                                    !it.startsWith("   --log ") &&
                                    !it.startsWith("   --quiet ") &&
                                    !it.startsWith("   -c ") &&
                                    !it.startsWith("   -V ") &&
                                    !it.startsWith("   --fast-open ") &&
                                    !it.startsWith("   --help,") &&
                                    !it.startsWith("   --version,")
                        }
                        .joinToString("\n")
                        .replace(Regex(" {2,}"), "\n")
                        .replace("--", "")
                        .replace(" value", "=value")
                        .substring(1)   // remove 1st \n
            }
}
