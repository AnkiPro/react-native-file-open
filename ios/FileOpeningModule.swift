// Copyright © 2023 Vedas Apps Ltd. All rights reserved.

import Foundation
import React

@objc(FileOpeningModule)
public class FileOpeningModule: RCTEventEmitter {
  
  static let FILE_OPENED_EVENT = "FileOpened"

  @objc public static var sharedInstance: FileOpeningModule?

  private var openedFileURL: URL?
  private var callbacks: [String: RCTResponseSenderBlock] = [:]

  override init() {
    super.init()
    FileOpeningModule.sharedInstance = self
  }

  @objc(markFileOpened:)
  public func markFileOpened(url: URL) {
    openedFileURL = url
    sendFileOpenedEvent()
  }

  @objc(getOpenedFileURL:rejecter:)
  func getOpenedFileURL(resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
    if let openedFileURL = openedFileURL {
      resolver(openedFileURL.absoluteString)
      self.openedFileURL = nil
    } else {
      rejecter("E_NO_FILE_OPENED", "No file has been opened yet", nil)
    }
  }

  private func sendFileOpenedEvent() {
    if let openedFileURL = openedFileURL {
      self.sendEvent(withName: FileOpeningModule.FILE_OPENED_EVENT, body: ["url": openedFileURL.absoluteString])
    }
  }

  @objc
  public override static func requiresMainQueueSetup() -> Bool {
    return true
  }

  @objc
  public override func supportedEvents() -> [String]! {
    return [FileOpeningModule.FILE_OPENED_EVENT]
  }
}
