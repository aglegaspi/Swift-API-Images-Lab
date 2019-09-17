import Foundation

struct Pokemon: Codable {
    let name: String
    let mageUrlHiRes: String
    let types: [String]
    let set: String
    let weaknesses: Weaknesses
}

struct Weaknesses: Codable {
    let type: String
    let value: String
}

/*
 
 "name": "Cubone",

 "imageUrlHiRes": "https://images.pokemontcg.io/dp6/90_hires.png",
 "types": [
    "Fighting"
    ],
 "set": "Legends Awakened",

 "weaknesses": [
     {
     "type": "Water",
     "value": "+10"
     }
 ]
 
 */
