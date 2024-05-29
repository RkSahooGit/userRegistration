import UIKit

class MainPageVC: UIViewController {
    
    @IBOutlet weak var firstTxtFld: UITextField!
    @IBOutlet weak var secondTxtFld: UITextField!
    
    var percentage = ""
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func calculateActionbutton(_ sender: Any) {
        guard let firstName = firstTxtFld.text, !firstName.isEmpty else {
            showAlert(message: "Enter First Name")
            return
        }
        guard let secondName = secondTxtFld.text, !secondName.isEmpty else {
            showAlert(message: "Enter Second Name")
            return
        }
        
        if let resultVC = storyboard?.instantiateViewController(withIdentifier: "resultVCStoryboardId") as? resultVC {
            getMatchPercentage(firstName: firstName, secondName: secondName)

            resultVC.result = result
            navigationController?.pushViewController(resultVC, animated: true)
        }
            }
    
    func getMatchPercentage(firstName: String, secondName: String) {
       
        let headers = [
            "X-RapidAPI-Key": "308d25b9aemsh9f3672bc4d6efcep1e4159jsn3c6864177005",
            "X-RapidAPI-Host": "love-calculator.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://love-calculator.p.rapidapi.com/getPercentage?sname=\(firstName)&fname=\(secondName)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers as? [String: String]
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { [self](data, response, error) -> Void in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("HTTP status code: \(httpResponse.statusCode)")
                return
            }
            
            guard let responseData = data else {
                print("No data received")
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] {
                    print("Response Data:")
                    print(jsonResponse)
                    if let percentage = jsonResponse["percentage"] as? Int,
                                      let result = jsonResponse["result"] as? String {
                                       // Update UI on main thread
                                       DispatchQueue.main.async {
                                           
                                           self.percentage = String(percentage)
                                           self.result = result
                                                   
                                                  
                                       }
                                   }
                    
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        })
        
        dataTask.resume()
    }
    
    func showAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

struct Match: Codable {
    let percentage: Int
    let result: String
}
