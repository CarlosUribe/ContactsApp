//
//  VWelcomeView.swift
//  La App
//
//  Created by Carlos Uribe on 12/21/18.
//  Copyright © 2018 CarlosUribe. All rights reserved.
//

import UIKit
import Contacts
import MessageUI
//INITIAL VIEW THAT SHOWS ALL THE USERS CONTACTS AND CONFIGURATION / MESSAGE ACTION 
class VWelcomeView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, MFMessageComposeViewControllerDelegate{
    weak var controller: CWelcomeController!
    weak var bar: VWelcomeBarView!
    weak var collection:UICollectionView!
    weak var searchBar:UITextField!
    private let kCornerRadius:CGFloat = 8.0
    private let kBarHeight:CGFloat = 88.0
    private let kCellConstantHeight:CGFloat = 116
    private var filteredArray:[MWelcomeModelSection] = []
    private weak var model: MWelcomeModelItem!
    var isFiltered: Bool = false

    convenience init(controller: CWelcomeController){
        self.init()
        self.controller = controller
        clipsToBounds = false
        backgroundColor = .white
        self.model = controller.model

        let bar:VWelcomeBarView = VWelcomeBarView(controller: controller)
        self.bar = bar

        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let search: UIBarButtonItem = UIBarButtonItem(title:  NSLocalizedString("GenericToolbar_search", comment: ""), style: .done, target: self, action: #selector(searchButtonAction))
        let cancel:UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("GenericToolbar_cancel", comment: ""), style: .done, target: self, action: #selector(cancelButtonAction))
        let items = [cancel, flexSpace, search]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        let searchBar:UITextField = UITextField()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.clipsToBounds = true
        searchBar.placeholder = NSLocalizedString("VWelcomeView_placeHolderSearch", comment: "")
        searchBar.textAlignment = .center
        searchBar.backgroundColor = UIColor(red:0.92, green:0.90, blue:0.90, alpha:1.0)
        searchBar.clearButtonMode = .whileEditing
        searchBar.textColor = UIColor(red:0.42, green:0.48, blue:0.61, alpha:1)
        searchBar.layer.cornerRadius = kCornerRadius
        searchBar.delegate = self
        searchBar.inputAccessoryView = doneToolbar
        self.searchBar = searchBar

        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.scrollDirection = UICollectionView.ScrollDirection.vertical
        flow.minimumLineSpacing = 10
        flow.minimumInteritemSpacing = 10
        flow.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

        let collection:UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceVertical = true
        collection.dataSource = self
        collection.delegate = self
        collection.register(
            VWelcomeCellView.self,
            forCellWithReuseIdentifier:
            VWelcomeCellView.reusableIdentifier())
        collection.register(
            VWelcomeHeaderCellView.self,
            forCellWithReuseIdentifier:
            VWelcomeHeaderCellView.reusableIdentifier())
        self.collection = collection

        addSubview(bar)
        addSubview(searchBar)
        addSubview(collection)

        let views:[String : Any] = [
            "bar":bar,
            "search":searchBar,
            "collection":collection]

        let metrics:[String : CGFloat] = [
            "barHeight":kBarHeight]

        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[bar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[bar(barHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-20-[search]-20-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[bar]-0-[search(40)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collection]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[search]-0-[collection]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }

    //MARK: MODEL ITEM INDEX
    func getModelItem(index:Int) -> MWelcomeModelSection{
        if isFiltered{
            return filteredArray[index]
        }else{
            return model.contactIndex[index]
        }
    }

    //MARK: COLLECTION DELEGATES
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltered{
            return filteredArray.count
        }else{
            return model.contactIndex.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model:MWelcomeModelSection = getModelItem(index: indexPath.row)
        let cell:VWelcomeBaseCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: model.identifier,
            for:indexPath) as! VWelcomeBaseCell
        if model.identifier == VWelcomeCellView.reusableIdentifier(){
            cell.config(model:model.contact)
        }else{
            cell.configHeader(title: model.title)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismissKeyboard()
        let model:MWelcomeModelSection = getModelItem(index: indexPath.row)

        if model.identifier == VWelcomeCellView.reusableIdentifier(){
            if let contact = model.contact{
                if CDBaseController.shared.isObjectOnDB(data: contact){
                    let fullContactController:CFullContactInfoController = CFullContactInfoController(model: contact)
                    let transition:CMainControllerTransition = CMainControllerTransition.pushRight(controller: fullContactController, poptype: .none)
                    controller.parentController.transitionTo(transition:transition)
                }else{
                    openActionSheet(model)
                }
            }
        }
    }

    //MARK: FLOW DELEGATES
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model:MWelcomeModelSection = getModelItem(index: indexPath.row)
        let width:CGFloat = model.width
        let height:CGFloat = model.height
        return CGSize(width: width, height: height)
    }

    //MARK: UITEXTFIELD DELEGATES
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" && textField.text?.count == 1{
            clearSearchBarAction()
        }else{
            let stringToSearch:String = textField.text! + string
            searchForString(string: stringToSearch)
        }
        return true
    }

    //MARK: ACTION SHEET
    func openActionSheet(_ model: MWelcomeModelSection){
        let alertController = UIAlertController(title: nil, message: NSLocalizedString("VWelcomeViewMessage_alert", comment: ""), preferredStyle: .actionSheet)

        let configureAction = UIAlertAction(title:NSLocalizedString("VWelcomeViewMessage_configure", comment: ""), style: .default) { action in
            let saveAlert = UIAlertController(title: NSLocalizedString("VWelcomeViewMessage_configure_save_title", comment: ""), message: NSLocalizedString("VWelcomeViewMessage_configure_save_text", comment: ""), preferredStyle: .alert)

            saveAlert.addAction(UIAlertAction(title: NSLocalizedString("VWelcomeViewMessage_configure_save_YES", comment: ""), style: .default, handler: {action in
                DispatchQueue.global(qos: .background).async {
                    if let contact = model.contact{
                        CDBaseController.shared.saveData(data: contact)
                    }
                }
            }))
            saveAlert.addAction(UIAlertAction(title: NSLocalizedString("VWelcomeViewMessage_configure_save_NO", comment: ""), style: .cancel, handler: nil))

            self.controller.present(saveAlert, animated: true)
        }
        alertController.addAction(configureAction)

        let SMSAction = UIAlertAction(title:NSLocalizedString("VWelcomeViewMessage_sms", comment: ""), style: .default) { action in
            if let contact = model.contact{
                self.displayMessageInterface(contact)
            }
        }
        alertController.addAction(SMSAction)

        let cancelAction = UIAlertAction(title: NSLocalizedString("VWelcomeViewMessage_cancel", comment: ""), style: .cancel)
        alertController.addAction(cancelAction)

        controller.present(alertController, animated: true, completion: nil)
    }

    //MARK: UIMESSAGE DELEGATE
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result.rawValue {
        case 0:
            controller.dismiss(animated: true, completion: nil)
            print(NSLocalizedString("VWelcomeViewMessage_sms_cancel", comment: ""))
        case 1:
            print(NSLocalizedString("VWelcomeViewMessage_sms_success", comment: ""))
        case 2:
            controller.dismiss(animated: true, completion: nil)
            print(NSLocalizedString("VWelcomeViewMessage_sms_fail", comment: ""))
        default:
            break
        }
    }

    private func displayMessageInterface(_ contact: CNContact) {
        let composeVC: MFMessageComposeViewController = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self

        // Configure the fields of the interface.
        if let number:CNLabeledValue<CNPhoneNumber> = contact.phoneNumbers.first{
            composeVC.recipients = [number.value.stringValue]
            composeVC.body = NSLocalizedString("VWelcomeViewMessage_sms_compose", comment: "")

            // Present the view controller modally.
            if MFMessageComposeViewController.canSendText() {
                controller.present(composeVC, animated: true, completion: nil)
            } else {
                print(NSLocalizedString("VWelcomeViewMessage_sms_error", comment: ""))
            }
        }else{
            print(NSLocalizedString("VWelcomeViewMessage_sms_error_contact", comment: ""))
        }
    }

    // SEARCH FUNCTION

    //MARK: TOOL BAR BUTTON ACTIONS

    @objc func searchButtonAction(){
        if searchBar.text != ""{
            if let stringToSearch:String = searchBar.text{
                searchForString(string:stringToSearch)
            }
        }

        dismissKeyboard()
    }

    @objc func cancelButtonAction(){
        clearSearchBarActionAndDismiss()
    }

    func clearSearchBarAction(){
        searchBar.text = ""
        self.isFiltered = false
        collection.reloadData()
    }

    func clearSearchBarActionAndDismiss(){
        searchBar.text = ""
        self.isFiltered = false
        dismissKeyboard()
        collection.reloadData()
    }

    func searchForString(string:String){
        self.isFiltered = true
        self.filteredArray = controller.model.contactIndex.filter{$0.contact != nil}
        let letters = CharacterSet.letters
        let digits = CharacterSet.decimalDigits

        for uni in string.unicodeScalars {
            if letters.contains(uni) {
                self.filteredArray = filteredArray.filter{($0.contact?.givenName.contains(string))! || ($0.contact?.familyName.contains(string))!}
            } else if digits.contains(uni) {
                self.filteredArray = filteredArray.filter{($0.contact?.phoneNumbers.filter({$0.value.stringValue.contains(string)})) != []}
            }
        }

        collection.reloadData()
    }

    //MARK: KEYBOARD
    @objc func dismissKeyboard(){
        endEditing(true)
    }

    //MARK: SCROLL ACTION
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dismissKeyboard()
    }
}
