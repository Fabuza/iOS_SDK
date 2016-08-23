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
    
    var window: UIWindow? = FZTouchVisualizerWindow(frame: UIScreen.mainScreen().bounds)
    
    var customWindow: FZTouchVisualizerWindow
        {
        get {
            return window! as! FZTouchVisualizerWindow
        }
    }
    
    let schemeName = "fabuzaExample"
    
    var externalUrl: NSURL? = nil
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        return true
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        self.externalUrl = url
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        self.customWindow.pauseRecord()
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        if self.externalUrl != nil {
            self.initSDK()
            self.customWindow.resumeRecord()
        } else {
            self.openFabuzaWithParams(["bundleId" : NSBundle.mainBundle().bundleIdentifier!])
        }
    }
    
    private func openFabuzaWithParams(params: [NSObject:AnyObject])
    {
        FZTestEngine.instance().dataSource = self;
        FZTestEngine.instance().delegate = self;
        FZTestEngine.instance().openFabuzaWithParams(params)
    }
    
    private func initSDK()
    {
        FZTestEngine.instance().dataSource = self;
        FZTestEngine.instance().delegate = self;
        FZTestEngine.instance().on()
    }
    
}

extension AppDelegate : FZTestEngineDataSource, FZTestEngineDelegate
{
    func getExternalUrl() -> NSURL?
    {
        return self.externalUrl
    }
    
    func getVideoFilesSize() -> UInt
    {
        return self.customWindow.videoSize
    }
    
    func startRecordScreen(screenRecord: Bool, andCamera cameraRecord: Bool) {
        self.customWindow.startRecordScreen(screenRecord, andCamera: false)
    }
    
    func stopRecordWithProgress(progress: ((NSProgress) -> Void)?, success: (String, String) -> Void, failure: (NSError) -> Void) {
        self.customWindow.stopRecordWithProgress(progress, success: success, failure: failure)
    }
    
    func didEndProcess() {
        self.openFabuzaWithParams(FZTestEngine.instance().parseExternalTestParamsFromUrl(self.externalUrl)!)
    }
    
    //Остальные методы делегата FZTestEngineDelegate не надо экспортировать
}