//
//  ViewController.swift
//  tabelviewtest
//
//  Created by Sunny on 2019/7/16.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate ,UITableViewDropDelegate
{
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        session.localContext = tableView
        return dragItems(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        return dragItems(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: String.self)
    }
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinaionIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        for item in coordinator.items {
            if let sourceIndexPath = item.sourceIndexPath {
                if let str = item.dragItem.localObject as? String {
                    tableView.performBatchUpdates({
                        myEmoji.remove(at: sourceIndexPath.item)
                        myEmoji.insert(str, at: destinaionIndexPath.item)
                        tableView.deleteRows(at: [sourceIndexPath], with:UITableView.RowAnimation.right)
                        tableView.insertRows(at: [destinaionIndexPath], with: UITableView.RowAnimation.right)
                    })
                    coordinator.drop(item.dragItem, toRowAt: destinaionIndexPath)
                }
            }else {
                let placeHolderContext = coordinator.drop(item.dragItem, to: UITableViewDropPlaceholder(insertionIndexPath: destinaionIndexPath, reuseIdentifier: "cc", rowHeight: 50))
                item.dragItem.itemProvider.loadObject(ofClass: String.self ) { (provider, error ) in
                    DispatchQueue.main.async {
                        if let rstr = provider {
                            placeHolderContext.commitInsertion(dataSourceUpdates: { insertionIndexPath in
                                self.myEmoji.insert(rstr, at: insertionIndexPath.item)
                            })
                        }else {
                            placeHolderContext.deletePlaceholder()
                        }
                    }
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if let indexPath = destinationIndexPath, indexPath.section == 0 {
            let isSelf = (session.localDragSession?.localContext as? UITableView) == tableView
            return UITableViewDropProposal(operation: isSelf ? .move : .copy, intent: .insertAtDestinationIndexPath)
        }else {
            return UITableViewDropProposal(operation: .cancel)
        }
    }
    
    private func dragItems(at indexPath: IndexPath ) -> [UIDragItem] {
        if let str = (tableView.cellForRow(at: indexPath))?.textLabel!.text {
            let dragItem = UIDragItem(itemProvider: NSItemProvider(object: str as NSItemProviderWriting))
            dragItem.localObject = str
            return [dragItem]
        }else {
            return []
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return myEmoji.count
        case 1:
            return dic.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath)
            cell.textLabel?.text = myEmoji[indexPath.row]
            return cell
        }else if indexPath.section == 1 {
            let pcell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            pcell.textLabel?.text = dic[indexPath.row]
            return pcell
        }else{
            let selecet = tableView.dequeueReusableCell(withIdentifier: "cc", for: indexPath)
            return selecet
        }
    }
    
    @IBOutlet weak var button: UIButton!
       
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dragDelegate = self
        tableView.dragInteractionEnabled = true
        tableView.dropDelegate = self
        button.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        button.layer.cornerRadius = 15
        
    }

    @IBOutlet weak var tableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    var myEmoji = "🚗✈️🚖🛵🚑".map{ String($0) }
    var dic = ["person","age","sex"]
    
}

