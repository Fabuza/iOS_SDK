//
//  AppDelegate.swift
//  FabuzaExampleSwift
//
//  Created by Ilya Tarasov on 23.08.16.
//  Copyright © 2016 Applicatura. All rights reserved.
//

import UIKit
import SCKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? = FZTouchVisualizerWindow(frame: UIScreen.main.bounds)
    
    var customWindow: FZTouchVisualizerWindow
        {
        get {
            return window! as! FZTouchVisualizerWindow
        }
    }
    
    let schemeName = "fabuzaExample"
    
    var externalUrl: URL? = nil
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        self.externalUrl = url
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        self.customWindow.pauseRecord()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if self.externalUrl != nil {
            self.initSDK()
            self.customWindow.resumeRecord()
        } else {
            self.openFabuzaWithParams(["bundleId" : Bundle.main.bundleIdentifier!])
        }
    }
    
    fileprivate func openFabuzaWithParams(_ params: [AnyHashable: Any])
    {
        FZTestEngine.instance().dataSource = self;
        FZTestEngine.instance().delegate = self;
        FZTestEngine.instance().openFabuza(withParams: params)
    }
    
    fileprivate func initSDK()
    {
        FZTestEngine.instance().dataSource = self;
        FZTestEngine.instance().delegate = self;
        FZTestEngine.instance().on()
    }
    
}

extension AppDelegate : FZTestEngineDataSource, FZTestEngineDelegate
{

    func getExternalUrl() -> URL?
    {
        return self.externalUrl
    }
    
    func getVideoFilesSize() -> UInt
    {
        return self.customWindow.videoSize
    }
    
    public func startRecordScreen(_ screenRecord: UInt, andCamera cameraRecord: UInt) {
        self.customWindow.startRecordScreen(RecordTypes(rawValue: screenRecord), andCamera: RecordTypes(rawValue: cameraRecord))
    }
    
    public func stopRecord(progress: ((Progress) -> Void)?, success: @escaping (String, String) -> Void, failure: @escaping (Error) -> Void) {
        self.customWindow.stopRecord(progress: progress, success: success, failure: failure)
    }

    func didEndProcess() {
        self.openFabuzaWithParams(FZTestEngine.instance().parseExternalTestParams(from: self.externalUrl)!)
    }
    
    //Остальные методы делегата FZTestEngineDelegate не надо экспортировать
}
