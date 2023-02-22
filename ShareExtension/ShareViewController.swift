
//Extension View controller responsible for getting recpie's title,url and image url using a simple javascript file named GetURL
//Web scrapping and string opertations are applied here then sent to SwiftUI sheet through an observable object (type: EnvObject) which is reveived by an obsereved object in RecipeDetailsView

import UIKit
import Social
import MobileCoreServices
import SwiftUI
//import OpenAISwift
//
class CustomShareViewController: UIViewController {

    var envModel = EnvObject()
    //var client: OpenAISwift?
   
    override func viewDidAppear(_ animated: Bool) {
     super.viewDidAppear(true)
     navigationController?.setNavigationBarHidden(true, animated: false)
   }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)

        //MARK: ChatGPT Sol
//        setup()
//        send(recipeURL: urlString2) { response in
//            DispatchQueue.main.async {
//
//                self.openRecipeSheet(recipeDetails: response)
//            }
//
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Crucial connection
        
        //Connecting our EnvObject (ObservableObject) with CustomShareViewController(UIKit view) in order to be able to share data (Recpie URL) with swiftui view and call uikit functions from swiftUI view
        //We need to call  UIKit functions cancelAction() and doneAction() from swiftUI View to tell safari extension we are done and let the user be back to safari
        //rest of connection is in openRecipeSheet
        envModel.uIViewController = self
        openRecipeSheet(urlString: getURL())
      //  getURL()
        //openRecipeSheet(recipeDetails: "fakeURL",folders: folders)
   
        
        // 1: Set the background and call the function to create the navigation bar
        //self.view.backgroundColor = .systemGray6
        
        // setupNavBar()
    }
    
    // 2: Set the title and the navigation items
    private func setupNavBar() {
        self.navigationItem.title = "My app"
        
        let itemCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        self.navigationItem.setLeftBarButton(itemCancel, animated: false)
        
        let itemDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        self.navigationItem.setRightBarButton(itemDone, animated: false)
    }
    
    // 3: Define the actions for the navigation items
    @objc  func cancelAction () {
        let error = NSError(domain: "some.bundle.identifier", code: 0, userInfo: [NSLocalizedDescriptionKey: "An error description"])
        extensionContext?.cancelRequest(withError: error)
    }
    
    @objc func doneAction() {//save request prolly gonna be here
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    
    //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
    private func getURL() -> String {
        var urlString11 = "empty content"
        let extensionItem = extensionContext?.inputItems.first as! NSExtensionItem
        let itemProvider = extensionItem.attachments?.first as! NSItemProvider
        let propertyList = String(kUTTypePropertyList)
        if itemProvider.hasItemConformingToTypeIdentifier(propertyList) {
            itemProvider.loadItem(forTypeIdentifier: propertyList, options: nil, completionHandler: { (item, error) -> Void in
                guard let dictionary = item as? NSDictionary else { return }
                OperationQueue.main.addOperation {
                    if let results = dictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary,
                       let urlString = results["URL"] as? String,
                       let url = NSURL(string: urlString),let title = results["title"] as? String {
                       
                        self.openRecipeSheet(urlString: urlString)
                        //send it to firebase
                        //self.writeReading(url: urlString)
                        print("my url is \(urlString) and title is \(title)")
                    }
                }
            })
        } else {
            print("error")
        }
        
        return urlString11
    }
//
//    func getHtmlContents(url:String){
//        var contents = "fml"
//        do {
//             contents = try String(contentsOf: URL(string: url)!)
//            //self.openRecipeSheet(htmlContents: contents)
//
//
//            print(contents)
//        } catch {
//            // contents could not be loaded
//        }
//        DispatchQueue.main.async {
//            //self.openRecipeSheet(htmlContents: contents)
//
//        }
//    }
    
    func openRecipeSheet(urlString:String){
       
        self.envModel.recipeURL = urlString
        let controller = UIHostingController(rootView:RecipeShareSheetScreen(model:self.envModel))
        self.present(controller, animated: true)
        
   
        

      //  let viewCtrl = UIHostingController(rootView: RecipeDetailsView(model: envModel,dismissAction: {self.dismiss( animated: true, completion: nil )}))
//present(viewCtrl, animated: true)
       // self.navigationController?.pushViewController(viewCtrl, animated: true)



//Sol2 presneting swiftui view wihtout pushing it using navigation
//        let childView = UIHostingController(rootView: RecipeDetailsView(model: vc,dismissAction: {self.dismiss( animated: true, completion: nil )}))
//
//        addChild(childView)
//        childView.view.frame = self.view.frame
//        view.addSubview(childView.view)
//        childView.didMove(toParent: self)
//
     
        
    }
    
    
    
    //chatGPT
    //Create client
//    func setup() {
//         client = OpenAISwift(authToken: "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")
//    }
    //Send request to the ChatGPT API
//    func send(recipeURL: String, completion: @escaping (String) -> Void) {
//        //make the call
//        let command = "extract ingredients and steps of the recipe in this site \(recipeURL)"
//        client?.sendCompletion(with: command,maxTokens: 1000 ,completionHandler: { result in
//            switch result {
//            case .success(let model):
//               let output = model.choices.first?.text ?? "empty"
//                completion(output)
//            case .failure:
//                break
//            }
//        })
//    }
}

//Extension that uses URL session to download an image,Data(contentsOf:) method will download the contents of the url synchronously
//but we can change that using gcd
//citation:https://stackoverflow.com/a/27517280/18271330
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}




//DONT TOUCH THIS
// 1: Set the `objc` annotation
@objc(CustomShareNavigationController)
class CustomShareNavigationController: UINavigationController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // 2: set the ViewControllers
        self.setViewControllers([CustomShareViewController()], animated: false)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}






