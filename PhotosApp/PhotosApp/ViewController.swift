import UIKit
import Alamofire

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var imagesArray = [NSDictionary]()
    var indexPath = NSIndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        search("Ferrari")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPhoto" {
            let photoView = segue.destinationViewController as! PhotoViewController
            photoView.url = self.imagesArray[self.indexPath.row]["url"] as? String
            photoView.navigationItem.title = self.imagesArray[self.indexPath.row]["title"] as? String

        }
    }

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.imagesArray.count > 0 {
            return self.imagesArray.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.indexPath = indexPath
        self.performSegueWithIdentifier("showPhoto", sender: self)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCellWithReuseIdentifier("photoCell", forIndexPath: indexPath) as! PhotoCell
        
        photoCell.url = self.imagesArray[indexPath.row]["url"] as? String
        photoCell.source = self.imagesArray[indexPath.row]["source"] as? String
        photoCell.title = self.imagesArray[indexPath.row]["title"] as? String


        return photoCell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 2)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.imagesArray = []
        self.collectionView.reloadData()
        search(searchBar.text!)
    }
    
    func search(query: String) {
        let query_ = query.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        let request = Alamofire.request(.GET, "http://localhost:8000/api/\(query_)")
        request.responseJSON { (request, response, JSON) -> Void in
            let json = JSON.value!
            for photo in json as! [AnyObject] {
                var imageDictionary = [String:String]()
                imageDictionary["title"] = photo["title"] as? String
                imageDictionary["source"] = photo["source"] as? String
                imageDictionary["url"] = photo["url"] as? String
                self.imagesArray.append(imageDictionary)
            }
            self.collectionView.reloadData()
            self.navigationItem.title = query
        }
        
    }
    
}
