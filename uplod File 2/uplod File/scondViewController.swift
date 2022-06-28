//
//  scondViewController.swift
//  uplod File
//
//  Created by Ibrahim MOHAMMED on 08/11/1443 AH.
//

import UIKit
import PDFKit

class scondViewController: UIViewController {
    var pdfView = PDFView()
    var pdfURL : URL!
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var imageFile: UIImageView!
    
    @IBOutlet weak var newView: UIView!
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        view.addSubview(testView)
//        if testView == nil {
//            print("Contains a value! :", testView)
//        } else {
//            print("Doesn’t contain a value.")
//        }
//
//
//
//
//
//    }
    override func viewWillAppear(_ animated: Bool) {
        // newView.addSubview(pdfView)
        if self.newView != nil {
            print("Contains a value!//////////////////////////////////////////////////////", newView)

        
        } else {
            print("Doesn’t contain a value.///////////////////////////////////////////////////////")
        }
    }

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.addSubview(pdfView)
     // view.frame = CGRect (x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 0.7)
        if let document = PDFDocument(url: pdfURL) {
            pdfView.document = document
        }
//        self.testView = pdfView
        newView.backgroundColor = .red
        pdfView.translatesAutoresizingMaskIntoConstraints = false

        newView.addSubview(pdfView)

        print("newView : *******************************", newView)


        print("view : *******************************", view)
        print("pdfView : *******************************", pdfView)

        print("pdfURL : *******************************", pdfURL)


//        pdfView.displayMode = .singlePageContinuous
//
//        //pdfView.displayDirection = .horizontal
//
//
//        pdfView.autoScales = true
//        view.addConstraints([
//
//            pdfView.topAnchor.constraint(equalTo: view.topAnchor, constant: 85),
//            pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -35),
//            pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 40),
//            pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50),
//            pdfView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            pdfView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//
//
//        ])

//        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
//            self.dismiss(animated: true, completion: nil)
//        }

        let button = UIButton(frame: CGRect(x: 0, y: 33, width: 100, height: 50))
         // button.backgroundColor = .green
          button.setTitle("back", for: .normal)
        button.setTitleColor(.blue, for: .normal)
          button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

          self.view.addSubview(button)



    }

    @objc func buttonAction(sender: UIButton!) {
      print("Button tapped")
        self.dismiss(animated: true)
        
        
    }
    
//    override func viewDidLayoutSubviews() {
//        pdfView.frame = view.frame
//
//    }
    
}
