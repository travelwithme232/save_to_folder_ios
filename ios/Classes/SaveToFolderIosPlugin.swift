import Flutter
import UIKit

public class SaveToFolderIosPlugin: NSObject, FlutterPlugin, UIDocumentPickerDelegate {
  var result: FlutterResult?
  var filePath: String?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "SaveToFolder", binaryMessenger: registrar.messenger())
    let instance = SaveToFolderIosPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "copy",
       let args = call.arguments as? [String: Any],
       let path = args["path"] as? String {
      self.result = result
      self.filePath = path
      presentDocumentPicker(filePath: path)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }

  private func presentDocumentPicker(filePath: String) {
    let fileURL = URL(fileURLWithPath: filePath)
    DispatchQueue.main.async {
      guard let rootVC = UIApplication.shared.delegate?.window??.rootViewController else {
        self.result?(false)
        self.result = nil
        return
      }

      if #available(iOS 14.0, *) {
        let picker = UIDocumentPickerViewController(forExporting: [fileURL], asCopy: true)
        picker.shouldShowFileExtensions = true
        picker.delegate = self
        rootVC.present(picker, animated: true, completion: nil)
      } else {
        let activityVC = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        activityVC.completionWithItemsHandler = { _, completed, _, _ in
          self.result?(completed)
          self.result = nil
        }
        rootVC.present(activityVC, animated: true, completion: nil)
      }
    }
  }

  public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
    result?(false)
    result = nil
  }

  public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
    result?(true)
    result = nil
  }
}
