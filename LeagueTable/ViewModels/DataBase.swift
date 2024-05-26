//
//  DataBase.swift
//  SportsApp
//
//  Created by ahmed on 20/05/2024.
//

import Foundation
import CoreData
import UIKit

class DataBase : DataBaseProtocol{
    func deleteLeagueFromFavorite(league: LeagueItem?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Unable to access AppDelegate")
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteLeague")
        fetchRequest.predicate = NSPredicate(format: "league_name = %@", league?.league_name ?? "")
        do {
            let result = try managedContext.fetch(fetchRequest)
            if let objectToDelete = result.first as? NSManagedObject {
                managedContext.delete(objectToDelete)
                try managedContext.save()
            }
        } catch let error as NSError {
            print("Error deleting object: \(error), \(error.userInfo)")
        }
    }
    
    func saveLeagueToDataBase(league : LeagueItem){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Unable to access AppDelegate")
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteLeague", in: managedContext)
        let leagueData = NSManagedObject(entity: entity!, insertInto: managedContext)
        leagueData.setValue(String(league.league_key ?? 0), forKey: "league_key")
        leagueData.setValue(league.league_logo, forKey: "league_logo")
        leagueData.setValue(league.league_name, forKey: "league_name")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func fetchFavoriteLeagues() -> [LeagueItem]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Unable to access AppDelegate")
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteLeague")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            var leagueList = [LeagueItem]()
            for data in result as! [NSManagedObject] {
                let currLeague = LeagueItem(
                    league_name: data.value(forKey: "league_name") as? String,
                    league_logo: data.value(forKey: "league_logo") as? String,
                    league_key: Int(data.value(forKey: "league_key") as! String))
                leagueList.append(currLeague)
            }
            return leagueList
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func checkIfFavorite(league: LeagueItem) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Unable to access AppDelegate")
            return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteLeague")
        
        let predicate = NSPredicate(format: "league_key == %@", String(league.league_key!))
        fetchRequest.predicate = predicate
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            print(result)
            return !result.isEmpty
        } catch {
            print("Error fetching favorite league: \(error)")
            return false
        }
    }
    
    func deleteAll() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Unable to access AppDelegate")
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
       
       let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeague")
       
       do {
           let nsManagedLeagues = try managedContext.fetch(fetchRequest)
           for element in nsManagedLeagues {
               managedContext.delete(element)
           }
           try managedContext.save()
           print("Deleted all records!")
       } catch let error as NSError {
           print("Error deleting all records: \(error), \(error.userInfo)")
       }
   }

   


}
