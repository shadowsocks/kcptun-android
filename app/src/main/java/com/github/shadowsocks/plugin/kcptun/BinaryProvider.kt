package com.github.shadowsocks.plugin.kcptun

import android.net.Uri
import android.os.ParcelFileDescriptor
import com.github.shadowsocks.plugin.NativePluginProvider
import com.github.shadowsocks.plugin.PathProvider
import java.io.File
import java.io.FileNotFoundException

class BinaryProvider : NativePluginProvider() {
    override fun populateFiles(provider: PathProvider) {
        provider.addPath("kcptun", 0b111101101)
    }
    override fun getExecutable() = context!!.applicationInfo.nativeLibraryDir + "/libkcptun.so"
    override fun openFile(uri: Uri?): ParcelFileDescriptor = when (uri?.path) {
        "/kcptun" -> ParcelFileDescriptor.open(File(getExecutable()), ParcelFileDescriptor.MODE_READ_ONLY)
        else -> throw FileNotFoundException()
    }
}
