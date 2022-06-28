//
//  foureViewController.swift
//  uplod File
//
//  Created by Ibrahim MOHAMMED on 16/11/1443 AH.
//

import UIKit
import CoreData

class foureViewController: UIViewController, YPSignatureDelegate {
    

    var newSignuter = Signuter(context:context)
    
    @IBOutlet weak var signtuerView: Signtuer!
    
   // var arrayImage : [signtuerImage] = []
    

    
//   var x = ThreeViewController()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        signtuerView.delegate = self

    }
    
    
    
    
    func didStart(_ view: Signtuer) {
        print("Started Drawing")
    }
    
    func didFinish(_ view: Signtuer) {
        print("Finished Drawing")

    }
    
    @IBAction func BackButton(_ sender: Any) {
//
        //self.performSegue(withIdentifier: "moveN", sender: nil)
        dismiss(animated: true)
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
       

        
        
        if let signatureImage = self.signtuerView.getSignature(scale: 2) {

            
            newSignuter.id = Int32(arrayOfSignature.count)
          
            newSignuter.imagesigntuer = signatureImage.pngData()
            
            print("newSignuter ::::::::::", newSignuter)
            print("ignatureImage.pngData() : ", type(of: signatureImage.pngData()))

            do {
                try context.save()
               
            } catch {
                print("there is an error ")

            }
           
            
            let alert = UIAlertController(title: "", message: "تمت اضافه التوقيع بنجاح", preferredStyle: .alert)
            let action = UIAlertAction(title: "موافق", style: .default ,handler: { action in
                
                self.dismiss(animated: true, completion: nil)
                
            })
            alert.addAction(action)
            present(alert, animated: true)
            
            // Since the Signature is now saved to the Photo Roll, the View can be cleared anyway.
            self.signtuerView.clear()
        }else{
            
            let alert = UIAlertController(title: "", message: "لايوجد توقيع ", preferredStyle: .alert)
            let action = UIAlertAction(title: "موافق", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
            
            
        }
    }
    

    @IBAction func clearButton(_ sender: Any) {
        self.signtuerView.clear()
      //  dismiss(animated: true)
    }
    

}
