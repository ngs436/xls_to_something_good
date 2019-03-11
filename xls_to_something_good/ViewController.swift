//
//  ViewController.swift
//  xls_to_something_good
//
//  Created by 野田慶 on 2019/03/11.
//  Copyright © 2019 knoda. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var textField: NSTextField!
    
    // 文字列保存用の変数
    var textFieldString = ""
    // Task実行用
    var task = Process()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var OKButton: NSButton!
    
    @IBAction func openPanel(_ sender: Any) {
        let panel = NSOpenPanel()
        // .xls,.xlsm,.xlsxのみ選択可能に
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = false
        panel.allowedFileTypes = ["xls","xlsx","xlsm"]
        panel.begin (completionHandler:{ (num) -> Void in
            if num == NSApplication.ModalResponse.OK {
                // ファイルを選択したか(OKを押したか)
                guard let url = panel.url else { return }
                // NSLog(url.absoluteString)
                // 選択したファイルのパスをテキストボックスにペースト
                self.textField.stringValue = url.path
            }
        })
        
    }
    
    @IBAction func runFileConvert(_ sender: Any) {
        let scptpath: String = Bundle.main.path(forResource: "xls2xlsm", ofType: "scpt")!
        task = Process()
        textFieldString = textField.stringValue
        task.launchPath = "/usr/bin/osascript"
//        task.standardError = pipe
        task.arguments = [scptpath,"\(textFieldString)"]
//        NSLog("わーい\"\(textFieldString)\"")
        task.launch()
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

