//
//  ThreeViewController.swift
//  uplod File
//
//  Created by Ibrahim MOHAMMED on 13/11/1443 AH.
//

import UIKit

import PDFKit

import CoreData

var arrayOfSignature = [Signuter]()
var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


class ThreeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDragDelegate {
    @IBOutlet weak var PDFView: PDFView!
    var pdfURL: URL!
    
    @IBOutlet weak var MycollectionView: UICollectionView!
    
    
    var arrayImage : [signtuerImage] = []
    var imageStamp: ImageStampAnnotation?
    
    // the funcation is only drag image
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath ) -> [UIDragItem] {
        var x = [UIDragItem] ()
        if let data = arrayOfSignature[indexPath.row].imagesigntuer {
            let provider = NSItemProvider(object: UIImage(data: data)!)
            let dragItem = UIDragItem(itemProvider: provider)
            x = [dragItem]
        }
        return x
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        
    }
    
    func loadData(){
        
        do {
            arrayOfSignature =  try context.fetch(Signuter.fetchRequest())
            MycollectionView.reloadData()
            for i in arrayOfSignature {
                
                print("iiiiiiiiiiiiii >>>>>>>>>> : ",i.imagesigntuer)
                
                if i.imagesigntuer == nil{
                    
                    print("is emptyyyyyyyyyyyy@@@@@@@@@@@@@@@@@@@@@@", arrayOfSignature.count)
                    
                    
                    MycollectionView.reloadData()
                    var x = arrayOfSignature.count - arrayOfSignature.endIndex
                    
                    arrayOfSignature.remove(at: x)
                    MycollectionView.reloadData()
                    
                    
                }else{
                    
                    print("Not empty ")
                    //  MycollectionView.reloadData()
                    
                }
                
            }
        }catch{
            print("Error")
        }
        
        
        
    }
    
    
    func SaveData() {
        do{
            try context.save()
        }catch{
            print (error)
        }
        MycollectionView.reloadData()
        
        
    }
    
    
    func deleteData (){
        
        if let arrOfArticles = try? context.fetch(Signuter.fetchRequest()) {
            for object in arrOfArticles {
                context.delete(object)
            }
        }
        
        do {
            try context.save()
        } catch {
            //Handle error
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        loadData()
        
        
    }
    
    @objc func onTouch(_ sender: UIPanGestureRecognizer) {
        
        let transiton = sender.translation(in: self.PDFView)
        if let view = sender.view {
            view.center = CGPoint(x: view.center.x + transiton.x, y: view.center.y + transiton.y)
        }
        
        sender.setTranslation(.zero, in: PDFView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        UserDefaults.standard.setValue(UserDefaults.standard.integer(forKey: "id") + 1, forKey: "id") //this will increment id each time by 1 and saved in userDefault, so it will generate a unique id for each article.
        
        if let document = PDFDocument(url: pdfURL) {
            
            PDFView.displayMode = .singlePageContinuous
            
            PDFView.displayDirection = .vertical
            
            PDFView.autoScales = true
            
            document.delegate = self
            PDFView.document = document
            
        }
        
        
        
        // Get the current page
        guard let page = PDFView.currentPage else {return}

        
        
        MycollectionView.dataSource = self
        MycollectionView.delegate = self
        
        MycollectionView.dragDelegate = self
        //        MycollectionView.dropDelegate = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        arrayOfSignature.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        guard let signatureImage = cell.signtuerImage.image else { return }
    
        let customView = RayanView(frame: CGRect(x: 0 , y: 0 , width: 100, height: 60))
        customView.RayanImage.image = signatureImage
        PDFView.addSubview(customView)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MycollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let convertData = arrayOfSignature[indexPath.row]
        // let image = UIImage(data: convertData!)
        
        if let data = arrayOfSignature[indexPath.row].imagesigntuer {
            var r = UIImage(data: data)
            cell.signtuerImage.image = UIImage(data: data)
            print("data ::::>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>",type(of: r ))
            
        }
        
        
        
        cell.buttonAction = { [unowned self] in
            // return index aftear click
            let selectedIndexPath = indexPath.row
            
            
            
            let alert = UIAlertController(title: "", message: "هل انت متأكد من حذف التوقيع ", preferredStyle: .alert)
            let action2 = UIAlertAction(title: "لا", style: .default, handler: nil)
            alert.addAction(action2)
            let action = UIAlertAction(title: "نعم", style: .destructive, handler: { action in
                
                
                context.delete(arrayOfSignature[indexPath.row])
                
                arrayOfSignature.remove(at: selectedIndexPath)
                
                print("selectedIndexPath :",selectedIndexPath)
                
                self.SaveData()
                
                
                
            })
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
            
        }
        
        return cell
        
    }
    
    
    
    @IBAction func BackButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    @IBAction func NextPage(_ sender: Any) {
        
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "move4")as! foureViewController
        
        
        present(nextVC, animated: true)
        
        
    }
    
    
    
}


extension ThreeViewController: PDFDocumentDelegate {
    
}


struct signtuerImage{
    
    var image : UIImage
    
}



class ImageStampAnnotation: PDFAnnotation {
    
    var image: UIImage!
    
    // A custom init that sets the type to Stamp on default and assigns our Image variable
    init(with image: UIImage!, forBounds bounds: CGRect, withProperties properties: [AnyHashable : Any]?) {
        super.init(bounds: bounds, forType: PDFAnnotationSubtype.stamp, withProperties: properties)
        
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(with box: PDFDisplayBox, in context: CGContext) {
        
        // Get the CGImage of our image
        guard let cgImage = self.image.cgImage else { return }
        
        // Draw our CGImage in the context of our PDFAnnotation bounds
        context.draw(cgImage, in: self.bounds)
        
    }
}



class RayanView: UIView {


    @IBOutlet var contentView1: UIView!
    @IBOutlet weak var RayanImage: UIImageView!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    func commonInit() {
        
       guard let view = loadViewFromNib() else { return }
       view.frame = self.bounds
       self.addSubview(view)
       contentView1 = view
        contentView1.backgroundColor = .clear
        contentView1.layer.borderWidth = 0.5
       contentView1.layer.borderColor = UIColor.darkGray.cgColor

    }
    
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "RayanView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    override func didMoveToSuperview() {
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(pan)))
    }
    
    @objc func pan(_ gesture: UIPanGestureRecognizer) {
        translate(gesture.translation(in: self))
        gesture.setTranslation(.zero, in: self)
        setNeedsDisplay()
        print("Frames after moving : \(frame)")
        contentView1.layer.borderWidth = 0.0
    }
}


extension  CGPoint {
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    static func +=(lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }
}
extension UIView {
    func translate(_ translation: CGPoint) {
        let destination = center + translation
        let minX = frame.width/2
        let minY = frame.height/2
        let maxX = superview!.frame.width-minX
        let maxY = superview!.frame.height-minY
        center = CGPoint(
            x: min(maxX, max(minX, destination.x)),
            y: min(maxY ,max(minY, destination.y)))
    }
}
