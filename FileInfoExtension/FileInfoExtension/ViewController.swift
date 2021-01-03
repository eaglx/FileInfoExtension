//
//  ViewController.swift
//  FileInfoExtension
//
//  Created by eaglx on 30/12/2020.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var descriptionLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.stringValue = "Hi, this is a simple app to show some file details"
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        view.window?.title = "FileInfo"
    }
    
    @IBAction func clickOkButton(_ sender: Any) {
        view.window?.close()
    }
}
