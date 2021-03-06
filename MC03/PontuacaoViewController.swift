//
//  PontuacaoViewController.swift
//  LabelsTest
//
//  Created by Lucas Leal Mendonça on 15/05/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit

class PontuacaoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tipoJogo : Int = 0
    var recebe : Int = 0
    var pontos = [0, 1, 2];
    var pBookWorm : NSMutableArray?;
    var pScrambled : NSMutableArray?;
    var pontos2 = [100, 200, 1000, 9, 412];
    var pontos3 = [9185, 55555, 1, 124];
    @IBOutlet weak var tv: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tv.delegate = self;
        tv.dataSource = self;
        pontos[0] = recebe;
        pBookWorm = NSMutableArray();
        pScrambled = NSMutableArray();
        for pontuacao in PontuacaoManager.sharedInstance.fetchSortedPontuacoes(){
            if(pontuacao.categoria == "Bookworm"){
                pBookWorm?.addObject(pontuacao);
            } else if (pontuacao.categoria == "Scrambled"){
                pScrambled?.addObject(pontuacao);
            }
        }
        var nib : UINib = UINib(nibName: "PontuacaoTableViewCell", bundle: nil);
        tv.registerNib(nib, forCellReuseIdentifier: "PontCell");
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var celula = tv.dequeueReusableCellWithIdentifier("PontCell", forIndexPath: indexPath) as! PontuacaoTableViewCell;
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "dd/MM/yyyy - HH:mm";
        
        
        if(tipoJogo == 0){
            celula.data.text! = dateFormatter.stringFromDate(((pBookWorm!.objectAtIndex(indexPath.row)) as! Pontuacao).data);
            celula.pontos.text = String(((pBookWorm!.objectAtIndex(indexPath.row)) as! Pontuacao).pontos.integerValue);
            celula.fundo.image = UIImage(named: "greenTitle")
        } else if (tipoJogo == 1){
            celula.data.text! = dateFormatter.stringFromDate(((pScrambled!.objectAtIndex(indexPath.row)) as! Pontuacao).data);
            celula.pontos.text = String(((pScrambled!.objectAtIndex(indexPath.row)) as! Pontuacao).pontos.integerValue);
            celula.fundo.image = UIImage(named: "blueTitle")
        } else if (tipoJogo == 999){
            celula.data.text! = "NOT IMPLEMENTED";
            celula.pontos.text = "\(pontos3[indexPath.row])";
        }
        
        return celula;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tipoJogo == 0){
            return pBookWorm!.count;
        } else if (tipoJogo == 1){
            return pScrambled!.count;
        } else if (tipoJogo == 999){
            return pontos3.count;
        } else {
            return 0;
        }
    }
    
    @IBAction func btnHome(sender: UIButton) {
//        if self.navigationController?.viewControllers.count > 1 {
//            self.navigationController?.popViewControllerAnimated(true)
//        }
//        else{
//            let home = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
//            self.presentViewController(home, animated: true, completion: nil)
//        }
        self.navigationController?.popToRootViewControllerAnimated(true)

    }
    
    // MARK: - Change game type
    
    @IBAction func btnTipoJogo(sender: UIButton) {
        tipoJogo = sender.tag
        self.tv.reloadData()
    }
    
}
