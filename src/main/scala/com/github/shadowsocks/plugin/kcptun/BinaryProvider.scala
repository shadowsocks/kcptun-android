package com.github.shadowsocks.plugin.kcptun

import java.io.{File, FileNotFoundException}

import android.net.Uri
import android.os.ParcelFileDescriptor
import com.github.shadowsocks.plugin.{NativePluginProvider, PathProvider}

/**
  * @author Mygod
  */
final class BinaryProvider extends NativePluginProvider {
  override protected def populateFiles(provider: PathProvider): Unit = provider.addPath("kcptun", "755")

  override def getExecutable: String = getContext.getApplicationInfo.nativeLibraryDir + "/libkcptun.so"

  override def openFile(uri: Uri): ParcelFileDescriptor = uri.getPath match {
    case "/kcptun" => ParcelFileDescriptor.open(new File(getExecutable), ParcelFileDescriptor.MODE_READ_ONLY)
    case _ => throw new FileNotFoundException()
  }
}
