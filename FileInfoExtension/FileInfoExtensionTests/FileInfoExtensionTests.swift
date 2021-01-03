//
//  FileInfoExtensionTests.swift
//  FileInfoExtensionTests
//
//  Created by eaglx on 30/12/2020.
//

import Quick
import Nimble
@testable import FileInfoFinderExtension

class FileInfoExtensionTests: QuickSpec {

    override func spec() {
        describe("FileInfoFinderExtension") {
            let fileInfoMenu = FileInfoMenu(title: "Test of FileInfoMenu")
            
            context("create a menu") {
                let dirPath = NSTemporaryDirectory()
                let testFilePath1 = "test1.txt"
                let testFilePath2 = "test2.txt"
                let testDirPath1 = "testDir1"
                let testDirPath2 = "testDir2"
                let testData = "test data for file 1".data(using: .utf8)
                
                if !FileManager.default.fileExists(atPath: dirPath + testFilePath1) {
                    FileManager.default.createFile(atPath: dirPath + testFilePath1, contents: testData, attributes: nil)
                }
                
                if !FileManager.default.fileExists(atPath: dirPath + testFilePath2) {
                    FileManager.default.createFile(atPath: dirPath + testFilePath2, contents: testData, attributes: nil)
                }
                
                if !FileManager.default.fileExists(atPath: dirPath + testDirPath1) {
                    try? FileManager.default.createDirectory(atPath: dirPath + testDirPath1, withIntermediateDirectories: false, attributes: nil)
                }
                
                if !FileManager.default.fileExists(atPath: dirPath + testDirPath2) {
                    try? FileManager.default.createDirectory(atPath: dirPath + testDirPath2, withIntermediateDirectories: false, attributes: nil)
                }
                
                describe("when no data is passed") {
                    it("with nil url array") {
                        fileInfoMenu.setInfo(with: nil, resources: [.fileSize])
                        
                        guard let submenu = fileInfoMenu.items.first?.submenu else {
                            fail("No submenu")
                            return
                        }
                        
                        guard let firstItem = submenu.items.first else {
                            fail("No items in submenu")
                            return
                        }
                        
                        expect(firstItem.title).to(equal("No data available"))
                    }
                    
                    it("with empty url array") {
                        fileInfoMenu.setInfo(with: [], resources: [.fileSize])
                        
                        guard let submenu = fileInfoMenu.items.first?.submenu else {
                            fail("No submenu")
                            return
                        }
                        
                        guard let firstItem = submenu.items.first else {
                            fail("No items in submenu")
                            return
                        }
                        
                        expect(firstItem.title).to(equal("No data available"))
                    }
                    
                    it("with empty resource array") {
                        fileInfoMenu.setInfo(with: [URL(string: "/path/to/file")!], resources: [])
                        
                        guard let submenu = fileInfoMenu.items.first?.submenu else {
                            fail("No submenu")
                            return
                        }
                        
                        guard let firstItem = submenu.items.first else {
                            fail("No items in submenu")
                            return
                        }
                        
                        expect(firstItem.title).to(equal("No data available"))
                    }
                }
                
                describe("when there is some data") {
                    it("for a file") {
                        fileInfoMenu.setInfo(with: [URL(fileURLWithPath: dirPath + testFilePath1, isDirectory: false)], resources: [.fileSize])
                        
                        guard let submenu = fileInfoMenu.items.first?.submenu else {
                            fail("No submenu")
                            return
                        }
                        
                        guard let firstItem = submenu.items.first else {
                            fail("No items in submenu")
                            return
                        }
                        
                        expect(firstItem.title.contains("\(testData?.count ?? 0)")).to(beTrue())
                    }
                    
                    it("for two files") {
                        fileInfoMenu.setInfo(with: [URL(fileURLWithPath: dirPath + testFilePath1, isDirectory: false), URL(fileURLWithPath: dirPath + testFilePath2, isDirectory: false)], resources: [.fileSize])
                        
                        guard let submenu = fileInfoMenu.items.first?.submenu else {
                            fail("No submenu")
                            return
                        }
                        
                        guard let firstItem = submenu.items.first else {
                            fail("No items in submenu")
                            return
                        }
                        
                        expect(firstItem.title.contains("\((testData?.count ?? 0) * 2)")).to(beTrue())
                    }
                    
                    it("for a directory") {
                        fileInfoMenu.setInfo(with: [URL(fileURLWithPath: dirPath + testDirPath1, isDirectory: true)], resources: [.fileSize])
                        
                        guard let submenu = fileInfoMenu.items.first?.submenu else {
                            fail("No submenu")
                            return
                        }
                        
                        guard let firstItem = submenu.items.first else {
                            fail("No items in submenu")
                            return
                        }
                        
                        expect(firstItem.title.contains("0")).to(beTrue())
                    }
                    
                    it("for two directories") {
                        fileInfoMenu.setInfo(with: [URL(fileURLWithPath: dirPath + testDirPath1, isDirectory: true), URL(fileURLWithPath: dirPath + testDirPath2, isDirectory: true)], resources: [.fileSize])
                        
                        guard let submenu = fileInfoMenu.items.first?.submenu else {
                            fail("No submenu")
                            return
                        }
                        
                        guard let firstItem = submenu.items.first else {
                            fail("No items in submenu")
                            return
                        }
                        
                        expect(firstItem.title.contains("0")).to(beTrue())
                    }
                    
                    it("for a file and a directory") {
                        fileInfoMenu.setInfo(with: [URL(fileURLWithPath: dirPath + testFilePath1, isDirectory: false), URL(fileURLWithPath: dirPath + testDirPath2, isDirectory: true)], resources: [.fileSize])
                        
                        guard let submenu = fileInfoMenu.items.first?.submenu else {
                            fail("No submenu")
                            return
                        }
                        
                        guard let firstItem = submenu.items.first else {
                            fail("No items in submenu")
                            return
                        }
                        
                        expect(firstItem.title.contains("\(testData?.count ?? 0)")).to(beTrue())
                    }
                }
                
                describe("updating a menu") {
                    it("if menu items are updated") {
                        fileInfoMenu.setInfo(with: [URL(fileURLWithPath: dirPath + testFilePath1, isDirectory: false)], resources: [.fileSize])
                        
                        guard let submenu1 = fileInfoMenu.items.first?.submenu else {
                            fail("No submenu")
                            return
                        }
                        
                        guard let firstItem1 = submenu1.items.first else {
                            fail("No items in submenu")
                            return
                        }
                        
                        let firstTitle = firstItem1.title
                        
                        fileInfoMenu.setInfo(with: [URL(fileURLWithPath: dirPath + testFilePath1, isDirectory: false)], resources: [.fileAllocatedSize])
                        
                        guard let submenu2 = fileInfoMenu.items.first?.submenu else {
                            fail("No submenu")
                            return
                        }
                        
                        guard let firstItem2 = submenu2.items.first else {
                            fail("No items in submenu")
                            return
                        }
                        
                        let secondTitle = firstItem2.title
                        
                        expect(firstTitle).toNot(be(secondTitle))
                    }
                }
            }
        }
    }
}
