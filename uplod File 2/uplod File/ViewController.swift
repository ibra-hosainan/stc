//
//  ViewController.swift
//  uplod File
//
//  Created by Ibrahim MOHAMMED on 07/11/1443 AH.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

import PDFKit


class ViewController: UIViewController, UIDocumentPickerDelegate, UIDocumentMenuDelegate {
    
    
    
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    var pdfView = PDFView()
    var pdfURL: URL?
    var arrayURL = [URL]()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    //    }
    //
    //    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
    //        controller.dismiss(animated: true)
    //    }
    //
    
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL])  {
        
        
        //        let nextVC = storyboard?.instantiateViewController(withIdentifier: "move")as! scondViewController
        //
        //
        //
        //        present(nextVC, animated: true)
        
        
        
        guard let selctedFileURL = urls.first else{
            
            return
            
        }
        
        
        
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        
        let sandBoxFileUrl = dir?.appendingPathComponent(selctedFileURL.lastPathComponent)
       
        
        
        
        
        self.pdfURL = selctedFileURL

        
        
        
//        let pdfViewController = scondViewController()
//
//        pdfViewController.pdfURL = self.pdfURL
//
//        //pdfViewController.newView = pdfViewController.view
//
//       pdfViewController.modalPresentationStyle = .pageSheet
//
//        //navigationController?.pushViewController(pdfViewController, animated: true)
//
//
//        // present(pdfViewController, animated: true, completion: nil)
        
        
               
        
        
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "move3")as! ThreeViewController

      
        nextVC.pdfURL = self.pdfURL
        
       present(nextVC, animated: true)

        
        
        
        
        
        
        if FileManager.default.fileExists(atPath: sandBoxFileUrl!.path ){
            print("Already Exist *************************************************")
            
        }else{
            
            
            do {
                
                
                try FileManager.default.copyItem(at: selctedFileURL, to: sandBoxFileUrl!)
                
                print("copied file : ",selctedFileURL)
                
                
                
                
            }catch{
                
                print("error*******************************************")
                
            }
            
            
        }
        
        
        
        
    }
    
    
    
    @IBAction func importFile(_ sender: Any) {
        //        let types = UTType.types(tag: "docx",
        //                                    tagClass: UTTagClass.filenameExtension,
        //                                    conformingTo: nil)
        //
        //        let documentPiker = UIDocumentPickerViewController(
        //            forOpeningContentTypes: types)
        //
        //        print("documentPiker : ", documentPiker)
        //
        //
        //        documentPiker.delegate = self
        //            self.present(documentPiker, animated: true, completion: nil)
        
        // self.pdfURL = self.selctedFileURL
        
        
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeItem)], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        documentPicker.modalPresentationStyle = .fullScreen
        
        
        present(documentPicker, animated: true, completion: nil)
        
        print("documentPicker : .......",documentPicker)
        
        
        
        
        
        
        
        
    }
    
    
    
}


