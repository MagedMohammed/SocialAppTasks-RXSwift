//
//  EditPostViewController.swift
//  SocialAppTask
//
//  Created by Youxel mac5 on 1/20/20.
//  Copyright © 2020 Maged Mohammed. All rights reserved.
//

import UIKit


protocol  EditPostViewProtocol : ShowAlertProtocol {
    func updateDone(data:Posts)
}

class EditPostViewController: UIViewController {
    //    MARK:- Outlet
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTexetView: UITextView!
    
    
    //    MARK:- Properties
    var postData:Posts?
    var segueId = "editPost"
    var presenter:EditPostPresenterProtocol!
    
    //    MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = EditPostPresenter(view: self)
        if let post = self.postData{
            self.setDataForEdit(data: post)
        }
        // Do any additional setup after loading the view.
    }
    
    //    MARK:- Method
    
    func setDataForEdit(data:Posts){
        DispatchQueue.main.async {
            self.bodyTexetView.text = data.body ?? ""
            self.titleTextField.text = data.title ?? ""
        }
    }
    
    //    MARK:- Action
    
    @IBAction func savePost(_ sender: UIButton) {
        guard let title = titleTextField.text, !title.isEmpty else{return}
        guard let body = bodyTexetView.text, !body.isEmpty else{return}
        let userId = self.postData?.userId ?? 1
        let id = self.postData?.id ?? 1
        if self.postData != nil {
            self.presenter.editPost(title: title, userId: userId, body: body, id: id)
        }else{
             self.presenter.addPost(title: title, userId: userId, body: body)
        }
    }
}

extension EditPostViewController : EditPostViewProtocol{
    func updateDone(data:Posts) {
        print(data)
//        performSegue(withIdentifier: segueId, sender: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: { [weak self] _ in
            guard let self = self else {return}
            self.performSegue(withIdentifier: self.segueId, sender: nil)
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    

    
    
}
