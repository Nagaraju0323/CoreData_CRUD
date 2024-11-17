//
//  Protocol.swift
//  Swift.Org_Conepts
//
//  Created by Nagaraju on 14/11/24.
//

//protocol
//protocol optinal
//protocol inheritence
//protocol compostion
//protocol opque and place holder
import Foundation

//MARK: - protocol inheritence
protocol musicAlbum {
    var albumname:String { set get }
    var rating:String {set get}
    var singer:String {set get}
    func albumDescription() -> Self
}

class Album:musicAlbum {
    var albumname: String
    var rating: String
    var singer: String
    
    required init(albumname: String, rating: String, singer: String) {
        self.albumname = albumname
        self.rating = rating
        self.singer = singer
    }
    
    func albumDescription() -> Self {
        return Self(albumname:albumname,rating:rating,singer:singer)
    }
}

class Album2:musicAlbum {
    var albumname: String
    var rating: String
    var singer: String
    
    required init(albumname: String, rating: String, singer: String) {
        self.albumname = albumname
        self.rating = rating
        self.singer = singer
    }
    
    func albumDescription() -> Self {
        return Self(albumname:albumname,rating:rating,singer:singer)
    }
}

//MARK: - protocol with composition
protocol productDesciption {
    var price: Int { get }
    mutating func productDesc() -> [String]
}

protocol ProductDetails {
    var code: Int { get }
    mutating func prodDetails() -> Int
}

struct Keyboard: ProductDetails {
    var code: Int
    func prodDetails() -> Int {
        return code
    }
}

struct laptop:ProductDetails,productDesciption {
    var code: Int
    var price: Int
    var result = [String]()
    func prodDetails() -> Int {
        return code
    }
    mutating func productDesc() -> [String] {
        result.append(contentsOf: ["\(price)","\(code)"])
        return result
        
    }
}

//MARK: - protocol Extension

protocol AirTicket {
    func roouteDetails()
}

extension AirTicket {
    func roouteDetails() {
        
    }
}

//MARK: - protocol Optinals

@objc protocol optionaloptinalProtocol {
    @objc optional func loadMethod()
}


//MARK: - protocol Opaque
protocol Animal {
    func makeSound() -> String
}

struct Cat:Animal {
    func makeSound() -> String {
        return "Meow"
    }
}

struct Dog:Animal{
    func makeSound() -> String {
        return "Boow"
    }
}


class factoryAnimal {
    func animalSelected(_ isSelected:Bool) -> Animal {
        if isSelected == true
        {return Cat()} else {  return Dog() }
    }
}

//MARK: - protocol Asssociated Type 
protocol ItemsDetails {
    associatedtype code
    var itemsCode : code { get }
    mutating func itemsProductDetails() -> code
}


struct mobine : ItemsDetails {
    typealias code = Int
    var itemsCode: code
    mutating func itemsProductDetails() -> Int {
        return itemsCode
    }
}



