//
//  Food.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation

enum RecommendedLevel {case Good, Caution, Bad}

class Food {
    var Id: String
    var Name: String
    var Categories: String
    var SatFats: Int
    var Ingredients: String
    var Brand: String
    
    init() {
        Id = ""
        Name = ""
        Categories = ""
        SatFats = 0
        Ingredients = ""
        Brand = ""
    }
    
    convenience init(id: String, name: String?, categories: String?, satfats: Int?, ingredients: String?, brand: String?) {
        self.init()
        Id = id
        Name = name ?? ""
        Categories = categories ?? ""
        SatFats = satfats ?? 0
        Ingredients = ingredients ?? ""
        Brand = brand ?? ""
    }

    func checkType(type:String) -> RecommendedLevel{
        if(type.contains("Dairy")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Dairies")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Meat")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Meats")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Fat")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Fats")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Egg")){
            return RecommendedLevel.Caution
        }
        if(type.contains("Eggs")){
            return RecommendedLevel.Caution
        }
        if(type.contains("Cheese")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Poultry")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Poultries")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Beef")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Beefs")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Chicken")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Chickens")){
            return RecommendedLevel.Bad
        }
        return RecommendedLevel.Good
    }
    
    func getVeganPhrases()->[String]{
        return Food.nonVeganPhrases
    }
    
    func isFoodGood(food : Food) -> RecommendedLevel{
        if food.SatFats>1{
            return RecommendedLevel.Bad
        }
        for str in food.Categories.split(separator: ","){
            if checkType(type: String(str)) == RecommendedLevel.Bad{
                return RecommendedLevel.Bad
            }
        }
        
        for ingredient in Food.nonVeganPhrases{
            if(food.Ingredients.contains(ingredient)){
                return RecommendedLevel.Bad
            }
        }
        
        if food.Ingredients.count < 1 && food.Categories.count < 1{
         return RecommendedLevel.Caution
        }
        return RecommendedLevel.Good
    }
    
    func getFoodFromID(id: String, parentVC:SlidingStackVC)->Void{
        let barcodeSearch = "https://world.openfoodfacts.org/api/v0/product/"+id+".json"
        var foodinfo: Food = Food(id: "",name: "",categories: "",satfats: 0,ingredients: "", brand: "")
        //let barcodeSearch = "https://world.openfoodfacts.org/api/v0/product/3181232127608.json"
        let eurl = barcodeSearch.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = NSURL(string: eurl ?? "")
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //printing the json in console
                //print(jsonObj!.value(forKey: "products")!)
                
                //converting the element to a dictionary
                if let foodDict = jsonObj!.value(forKey: "product") as? NSDictionary {
                    let satfat : Int = 0;
                    var categories : String = ""
                    var id : String = ""
                    var ingrdientsList = ""
                    var brand = ""
                    
                    if let types = foodDict.value(forKey: "categories") {
                        categories=types as! String;
                    }
                    if let types = foodDict.value(forKey: "ingredients_text") {
                        ingrdientsList=types as! String;
                    }
                    if let ID = foodDict.value(forKey: "_id") {
                        id=ID as! String;
                    }
                    if let Brand = foodDict.value(forKey: "brands") {
                        brand=Brand as! String;
                    }
                    //not sure how to get this
                    //                            if let nutrientArray = foodDict.value(forKey: "nutriments") as! NSArray{
                    //                                for nutrient in nutrientArray{
                    //                                    if let nutrientDict = nutrient as? NSDictionary {
                    //                                        if let sf = nutrientDict.value(forKey: "saturated-fat_serving") {
                    //                                        satfat = sf as! Int
                    //                                            print(sf);
                    //                                        }
                    //                                    }
                    //                                }
                    //                            }
                    //getting the name from the dictionary
                    if let name = foodDict.value(forKey: "product_name") {
                        let fooditem = Food(id:id,name:(name as! String), categories: categories, satfats: satfat, ingredients: ingrdientsList, brand:brand)
                        //print(name as! String + ": " + categories + "\n")
                        //adding the name to the array
                        foodinfo = fooditem
                        
                    }
                    
                }
                OperationQueue.main.addOperation({
                    //calling another function after fetching the json
                    // push unknown if we're unbale to get any info from the barcode
                    if foodinfo.Ingredients.count<1 && foodinfo.Categories.count<1{
                        parentVC.pushSubView(newSubView: FoodSelectedSVC(food: foodinfo, unknown: true))
                    }
                        
                    else if(foodinfo.isFoodGood(food: foodinfo)==RecommendedLevel.Good){
                        parentVC.pushSubView(newSubView: FoodSelectedSVC(food: foodinfo, ingredients:[""], types:[""]))
                    }
                    else if(foodinfo.isFoodGood(food: foodinfo)==RecommendedLevel.Bad){
                        var badingredients = [""]
                        var badTypes = [""]
                        for str in foodinfo.Ingredients.components(separatedBy: ","){
                            for phrases in foodinfo.getVeganPhrases(){
                                if String(str).lowercased().contains(phrases){
                                    badingredients.append(String(str))
                                    break;
                                }
                            }
                        }
                        for str in foodinfo.Categories.components(separatedBy: ","){
                            if foodinfo.checkType(type: String(str)) == RecommendedLevel.Bad{
                                badTypes.append(String(str))
                            }
                        }
                        parentVC.pushSubView(newSubView: FoodSelectedSVC(food: foodinfo, ingredients:badingredients, types:badTypes))
                    }
                        // push unknown if we don't get either good or bad back from the call
                    else
                    {
                        parentVC.pushSubView(newSubView: FoodSelectedSVC(food: foodinfo, unknown: true))
                    }
                    parentVC.reload()
                })
                
            }
        }).resume()
        
    }
    
    static var nonVeganPhrases :[String] = [
        "abalone",
        "acetate",
        "acetylated hydrogenated lard glyceride",
        "acetylated lanolin",
        "acetylated lanolin alcohol",
        "acetylated lanolin ricinoleate",
        "acetylated tallow",
        "acidophilus milk",
        "adrenaline",
        "adrenals of cattle",
        "adrenals of hogs",
        "adrenals of sheep",
        "afterbirth",
        "alanine",
        "albumen",
        "albumin",
        "alcloxa",
        "aldioxa",
        "aliphatic alcohol",
        "allantoin",
        "alligator",
        "alligator skin",
        "alpha-hydroxy acids",
        "ambergris",
        "amerachol",
        "amerchol l101",
        "aminiuccinate acid",
        "amino acids",
        "aminosuccinate acid",
        "ammonium caseinate",
        "ammonium hydrolyzed protein",
        "amniotic fluid",
        "ampd isoteric hydrolyzed animal protein",
        "amylase",
        "angora",
        "animal bones",
        "animal collagen amino acids",
        "animal fat",
        "animal fats and oils",
        "animal hair",
        "animal keratin amino acids",
        "animal oil",
        "animal placenta",
        "animal protein derivative",
        "animal tissue extract",
        "arachidonic acid",
        "arachidyl proprionate",
        "aspartic acid",
        "aspic",
        "astrakhan",
        "back bacon",
        "back fat",
        "bacon",
        "batyl alcohol",
        "batyl isostearate",
        "bear",
        "beef",
        "beef heart",
        "beef liver",
        "beef tongue",
        "belly bacon",
        "benzyltrimonium hydrolyzed animal protein",
        "biotin vitamin h vitamin b factor",
        "bison",
        "blood",
        "blood plasma fractionation",
        "blood tongue",
        "boar bristles",
        "boiled ham",
        "bone ash",
        "bone char",
        "bone char(coal)/boneblack",
        "bone charcoal",
        "bone earth",
        "bone meal",
        "bone phosphate",
        "bone soup",
        "bone/bonemeal",
        "boneblack",
        "bonito",
        "bovine serum albumin",
        "brain extract",
        "bratwurst",
        "brawn",
        "breakfast bacon",
        "bresaola",
        "bristle",
        "bruehwurst",
        "buffalo",
        "buffalo milk",
        "bushmeat",
        "butter",
        "butter fat",
        "butter solids",
        "buttermilk",
        "buttermilk powder",
        "c30-46 piscine oil",
        "calciferol",
        "calciferool",
        "calcium caseinate",
        "calf liver",
        "calfskin",
        "calfskin extract",
        "camel milk",
        "canadian bacon",
        "cantharides tincture",
        "capiz",
        "capryl betaine",
        "caprylamine oxide",
        "caprylic acid",
        "caprylic triglyceride",
        "carbamide",
        "caribou",
        "carmine",
        "carmine cochineal carminic acid",
        "carmine/carminic acid",
        "carmine: cochineal. carminic acid",
        "carminic",
        "carminic acid",
        "carotene provitamin a beta carotene",
        "casein",
        "casein caseinate sodium caseinate",
        "caseinate",
        "caseinogen",
        "cashmere",
        "castor castoreum",
        "castoreum",
        "catgut",
        "catharidin",
        "cera flava",
        "cerebrosides",
        "certain additives",
        "ceteth-02",
        "ceteth-1",
        "ceteth-10",
        "ceteth-2",
        "ceteth-30",
        "ceteth-4",
        "ceteth-6",
        "cetyl alcohol",
        "cetyl lactate",
        "cetyl myristate",
        "cetyl palmitate",
        "chamois",
        "cheese",
        "chicken",
        "chicken",
        "chicken breast",
        "chicken liver",
        "chicken loaf",
        "chipped ham",
        "chitin",
        "chitosan",
        "cholecalciferol",
        "cholesterin",
        "cholesterol",
        "choline bitartrate",
        "chondroitin",
        "chopped ham",
        "chorizo",
        "chymotrypsin",
        "civet",
        "clarified butter",
        "clotted cream",
        "cochineal",
        "cold cuts",
        "coleth-24",
        "collagen",
        "collagen hydrolysate",
        "colors dyes",
        "condensed milk",
        "confectioners glaze",
        "cooked ham",
        "cooked meats",
        "corned beef",
        "cornish game hen",
        "cortico steroid",
        "corticosteroid",
        "cortisone",
        "cortisone corticosteroid",
        "cortisone: see cortico steroid.",
        "cotechino",
        "cottage cheese",
        "cream",
        "cream",
        "curds",
        "custard",
        "cysteine, l-form",
        "cystine",
        "dark meat",
        "dashi",
        "dea-oleth-10 phosphate",
        "deer",
        "deer meat",
        "delactosed whey",
        "deli meats",
        "demineralized whey",
        "deoxyribonucleic acid",
        "desamido animal collagen",
        "desamidocollagen",
        "devon",
        "dexpanthenol",
        "dicapryloyl cystine",
        "diethylene tricaseinamide",
        "diglycerides",
        "dihydrocholesterol",
        "dihydrocholesterol octyledecanoate",
        "dihydrocholeth-15",
        "dihydrocholeth-30",
        "dihydrogenated tallow benzylmoniumchloride",
        "dihydrogenated tallow methylamine",
        "dihydrogenated tallow phthalate",
        "dihydroxyethyl tallow amine oxide",
        "dimethyl hydrogenated tallowamine",
        "dimethyl stearamine",
        "dimethyl tallowamine",
        "disodium hydrogenatedtallowglutamate",
        "disodium tallamido mea-sulfosuccinate",
        "disodium tallowaminodipropionate",
        "ditallowdimonium chloride",
        "dna",
        "down",
        "dried buttermilk",
        "dried egg yolk",
        "dry milk solids",
        "dry whole milk",
        "duck",
        "duck bacon",
        "duck liver",
        "duodenum substances",
        "duodenum substances",
        "dutch loaf",
        "dyes",
        "e120",
        "e441",
        "e542",
        "e904",
        "e913",
        "edible bone phosphate",
        "egg",
        "egg albumen",
        "egg albumen/albumin",
        "egg yolk",
        "egg yolk extract",
        "egg yolks",
        "eggs",
        "elastin",
        "elastin",
        "elk bacon",
        "embryo extract",
        "emu",
        "emu oil",
        "epiderm oil r",
        "ergisterol",
        "ergocalciferol",
        "ergosterol",
        "estradiol",
        "estradiol benzoate",
        "estrogen",
        "estrogen estradiol",
        "estrogen/estradiol",
        "estrone",
        "ethyl ester of hydrolyzed animal protein",
        "ethyl morrhuatelipineate",
        "ethylarachidonate",
        "ethylene dehydrogenated tallowamide",
        "evaporated milk",
        "ewe milk",
        "fat-free milk",
        "fat-free yogurt",
        "fats",
        "fatty acids",
        "fd and c colors",
        "feathers",
        "felt",
        "fermented camel milk",
        "fermented cream",
        "fermented milk",
        "fletan oil",
        "fur",
        "gel",
        "gelatin",
        "gelatin gel",
        "gelatin(e)",
        "gelbwurst",
        "ghee",
        "gizzards",
        "glucosamine",
        "glucose tyrosinase",
        "glucuronic acid",
        "glutamic acid",
        "glycerides",
        "glycerin glycerol",
        "glycerol",
        "glyceryl lanolate",
        "glyceryls",
        "glycogen",
        "glycreth-26",
        "goat",
        "goat cheese",
        "goat milk",
        "goose",
        "goose insulating feathers",
        "goose liver",
        "ground beef",
        "grouse",
        "guanine",
        "guanine pearl essence",
        "guanine/pearl essence",
        "guinea hen",
        "gypsy bacon",
        "hair from hogs",
        "ham",
        "ham and cheese loaf",
        "head cheese",
        "heavy cream",
        "heptylundecanol",
        "hide",
        "hide glue",
        "homogenized milk",
        "horse",
        "horse hair",
        "horseflesh",
        "horsehair",
        "hot dog",
        "human placental protein",
        "human umbilical extract",
        "hyaluronic acid",
        "hydrlyzed human placental protein",
        "hydrocortisone",
        "hydrogenated animal glyceride",
        "hydrogenated ditallow amine",
        "hydrogenated honey",
        "hydrogenated laneth-20",
        "hydrogenated laneth-25",
        "hydrogenated laneth-5",
        "hydrogenated lanolin",
        "hydrogenated lanolin alcohol",
        "hydrogenated lard glyceride",
        "hydrogenated shark-liver oil",
        "hydrogenated tallow acid",
        "hydrogenated tallow betaine",
        "hydrogenated tallow glyceride",
        "hydrolyzed animal elastin",
        "hydrolyzed animal keratin",
        "hydrolyzed animal protein",
        "hydrolyzed casein",
        "hydrolyzed elastin",
        "hydrolyzed keratin",
        "hydrolyzed milk protein",
        "hydrolyzed silk",
        "hydroxylated lanolin",
        "ice cream",
        "imidazolidinyl urea",
        "insulin",
        "iron caseinate",
        "isinglass",
        "isobutylated lanolin",
        "isopropyl lanolate",
        "isopropyl myristate",
        "isopropyl tallowatelsopropyl lanolate",
        "isopropylpalmitate",
        "isostearic hydrolyzed animal protein",
        "isostearoyl hydrolyzed animal protein",
        "jagdwurst",
        "jowl",
        "kangaroo",
        "katsuobushi (okaka)",
        "keratin",
        "keratinamino acids",
        "l-cysteine",
        "l-form",
        "l-form: see cysteine.",
        "l-lactic acid",
        "lacotse-reduced milk",
        "lactalbumin",
        "lactalbumin",
        "lactic yeasts",
        "lacticacid",
        "lactoferrin",
        "lactoglobulin",
        "lactose",
        "lactose-free milk",
        "lactulose",
        "lamb",
        "lamb bacon",
        "laneth",
        "laneth-10",
        "laneth-11",
        "laneth-12",
        "laneth-13",
        "laneth-14",
        "laneth-15",
        "laneth-16",
        "laneth-17",
        "laneth-18",
        "laneth-19",
        "laneth-20",
        "laneth-21",
        "laneth-22",
        "laneth-23",
        "laneth-24",
        "laneth-25",
        "laneth-26",
        "laneth-27",
        "laneth-28",
        "laneth-29",
        "laneth-30",
        "laneth-31",
        "laneth-32",
        "laneth-33",
        "laneth-34",
        "laneth-35",
        "laneth-36",
        "laneth-37",
        "laneth-38",
        "laneth-39",
        "laneth-40",
        "laneth-5",
        "laneth-6",
        "laneth-7",
        "laneth-8",
        "laneth-9",
        "laneth-9 acetate",
        "laneth10 acetate",
        "lanogene",
        "lanoinamidedea",
        "lanolin",
        "lanolin acid",
        "lanolin acid: see lanolin.",
        "lanolin alcohol",
        "lanolin alcohols",
        "lanolin alcohols: see lanolin.",
        "lanolin lanolin acids wool fat wool wax",
        "lanolin linoleate",
        "lanolin oil",
        "lanolin ricinoleate",
        "lanolin wax",
        "lanolin(e)",
        "lanolin: lanolin acid",
        "lanosterol",
        "lanosterol: see lanolin.",
        "lanosterols",
        "lard",
        "lard glyceride",
        "lauroyl hydrolyzed animal protein",
        "leather",
        "leather suede calfskin sheepskinalligator skin other types of skin",
        "lecithin cholinebitartrate",
        "leucine",
        "linoleic acid",
        "lipase",
        "lipids",
        "lipoids lipids",
        "liver",
        "liver extract",
        "liverwurst",
        "low fat milk",
        "low fat yogurt",
        "lunasponge",
        "luncehon loaf",
        "lunch meats",
        "luncheon meats",
        "lysine",
        "magnesium caseinate",
        "malted milk",
        "mammarian extract",
        "marrow soup",
        "mayonnaise",
        "mea-hydrolyzed animal protein",
        "meat",
        "meat loaf",
        "meatball",
        "mechanically separated chicken",
        "methionine",
        "mettwurst",
        "milk",
        "milk chocolate",
        "milk derivative",
        "milk of mammals",
        "milk protein",
        "milk skin",
        "milk sugar",
        "milkfat",
        "milkpowder",
        "minced beef",
        "minced meat",
        "mink oil",
        "minkamidopropyl diethylamine",
        "mohair",
        "mono and di-glycerides",
        "monoglycerides glycerides",
        "monoglycerides glycerides (see glycerin)",
        "moose",
        "mortadella",
        "mullet",
        "muscle extract",
        "musk",
        "musk (oil)",
        "musk ambrette",
        "mussel",
        "mussels",
        "mutton",
        "mutton",
        "myristal ether sulfate",
        "myristate acid",
        "myristic acid",
        "myristoyl hydrolyzed animal protein",
        "myristyl",
        "myristyls",
        "natural butter flavor",
        "natural flavorings",
        "natural red 4",
        "natural sources",
        "neck",
        "nonfat milk",
        "note:",
        "nougat",
        "nucleicacids",
        "ocenol",
        "octyl dodecanol",
        "oleamidopropyl dimethylamine hydrolyzed animal protein",
        "oleic acid",
        "oleoic oil",
        "oleostearin",
        "oleostearine",
        "oleoyl hydrolyzed animal protein",
        "oleths",
        "oleyl arachidate",
        "oleyl betatine",
        "oleyl imidazoline",
        "oleyl lanolate",
        "oleyl myristate",
        "oleyl oleate",
        "oleyl stearate",
        "oleylalcohol ocenol",
        "oleylimidazoline",
        "opossum",
        "organ meat",
        "organ meats",
        "organs",
        "ostrich",
        "ovalbumin",
        "ovarian extract",
        "ox bile",
        "oxgall",
        "palmitamide",
        "palmitamine",
        "palmitate",
        "palmitic acid",
        "palmitoyl hydrolyzed milk protein",
        "palmitoyl hydrolyzedanimal protein",
        "pancetta",
        "panthenol dexpanthenol vitamin b-complex factor provitamin b-5",
        "panthenyl",
        "paracasein",
        "partridge",
        "pasteurized milk",
        "pearl essence",
        "pentahydrosqualene",
        "pepsin",
        "perhydrosqualene",
        "pharmaceutical glaze",
        "pheasant",
        "picnic shoulder",
        "pigskin extract",
        "placenta",
        "placenta placenta polypeptides protein afterbirth",
        "placenta polypeptides protein",
        "placental enzymes",
        "placental extract",
        "placental protein",
        "plaice",
        "pogy oil",
        "pollock",
        "poltethylene cetyl ether",
        "polyglycerol",
        "polyglyceryl-2lanolin alcohol ether",
        "polypeptides",
        "polypeptides protein",
        "polysorbates",
        "polytetylene glycerol/glycol/peg",
        "porcine pancreas",
        "pork",
        "pork fat",
        "pork roll",
        "potassium caseinate",
        "potassium tallowate",
        "potassium undecylenoyl hydrolyzed animal protein",
        "poultry",
        "ppg-12-peg-50 lanolin",
        "ppg-2,-5, -10. -20, -30 lanolinalcohol ethers",
        "ppg-30 lanolin ether",
        "pregnenolone acetate",
        "pristane",
        "progesterone",
        "propolis",
        "prosciutto",
        "provitamin a",
        "provitamin b-5",
        "provitamin d-2",
        "purcelline oil syn",
        "quail",
        "quaternium 27",
        "rabbit",
        "red meat",
        "reduced fat milk",
        "reduced fat yogurt",
        "rennet",
        "rennet casein",
        "rennet rennin",
        "rennin",
        "resinous glaze",
        "reticulin",
        "retinol",
        "ribonucleic acid",
        "rna ribonucleic acid",
        "roast beef",
        "roast pork",
        "sable",
        "sable brushes",
        "saccharide hydrolysate",
        "saccharide isomerate",
        "salami",
        "salceson",
        "sausage",
        "sausages",
        "serum albumin",
        "serum proteins",
        "sheep milk",
        "sheepskin",
        "shellac",
        "shellac resinous glaze",
        "shellac wax",
        "shoulder",
        "shrimph",
        "side bacon",
        "silk",
        "silk amino acids",
        "silk powder",
        "silk silk powder",
        "skim milk",
        "slab bacon",
        "slab bacon",
        "sliced meats",
        "smoked ham",
        "snail",
        "snails",
        "snake",
        "snapper",
        "sodium / tea-lauroyl hydrolyzed animal protein",
        "sodium / tea-undecylenoyl hydrolyzed animal protein",
        "sodium caseinate",
        "sodium caseinate",
        "sodium coco-hydrolyzed animal protein",
        "sodium soya hydrolyzed animal protein",
        "sodium tallow sulfate",
        "sodium tallowate",
        "sodium undecylenate",
        "sodiumsteroyl lactylate",
        "soluble  collagen",
        "sour cream",
        "sour milk",
        "sour milk solids",
        "soured milk",
        "soya hydroxyethyl imidazoline",
        "sperm oil",
        "sperm whale intestines",
        "spermaceti",
        "spermaceticetyl palmitate sperm oil",
        "spleen extract",
        "sponge (luna and sea)",
        "squab",
        "squalane",
        "squalene",
        "squirrel",
        "steak",
        "stearamide",
        "stearamine",
        "stearamine oxide",
        "stearates",
        "stearic acid",
        "stearic hydrazide",
        "stearin",
        "stearone",
        "stearoxytrimethylsilane",
        "stearoyl lactylic acid",
        "stearyl acetate",
        "stearyl alcohol sterols",
        "stearyl betaine",
        "stearyl caprylate",
        "stearyl citrate",
        "stearyl glycyrrhetinate",
        "stearyl heptanoate",
        "stearyl imidazoline",
        "stearyl octanoate",
        "stearyl stearate",
        "stearyldimethyl amine",
        "steroids sterols",
        "sterols",
        "stewing steak",
        "streaky bacon",
        "suede",
        "sweet dairy whey",
        "sweet whey",
        "sweetbreads",
        "sweetened condensed milk",
        "tallow",
        "tallow acid",
        "tallow amide",
        "tallow amine",
        "tallow amine oxide",
        "tallow fatty alcohol",
        "tallow glycerides",
        "tallow hydroxyethal imidazoline",
        "tallow imidazoline",
        "tallow tallow fatty alcohol stearic acid",
        "tallow trimonium chloride - tallow",
        "tallowamidopropylamine oxide",
        "talloweth-6",
        "tallowmide dea and mea",
        "tallowmidopropyl hydroxysultaine",
        "tallowminopropylamine",
        "tallowmphoacete",
        "tea-abietoyl hydrolyzedanimal protein",
        "tea-coco hydrolyzed animal protein",
        "tea-lauroyl animal collagen amino acids",
        "tea-lauroyl animal keratin amino acids",
        "tea-myristol hydrolyzed animal protein",
        "tea-undecylenoyl hydrolyzed animal protein",
        "testicular extract",
        "threonine",
        "thuringian sausage",
        "tongue",
        "triethonium hydrolyzed animal protein ethosulfate",
        "trilaneth-4phosphate",
        "triterpene alcohols",
        "trypsin",
        "turkey",
        "turkey",
        "turkey bacon",
        "turkey breast",
        "turtle",
        "turtle oil",
        "turtle oilsea turtle oil",
        "tyrosine",
        "un-homogenized milk",
        "urea",
        "urea carbamide",
        "uric acid",
        "uric acid from cows",
        "uricacid",
        "urine",
        "veal",
        "veal loaf",
        "venison",
        "vitamin a",
        "vitamin b-complex factor",
        "vitamin d ergocalciferol vitamin d",
        "vitamin d3",
        "vitamin h",
        "vitaminb",
        "vitaminb factor",
        "volaise",
        "whey",
        "whey powder",
        "whey protein",
        "whipped cream",
        "whipped topping",
        "white meat",
        "whole milk",
        "whole milk yogurt",
        "wild boar",
        "wild meat",
        "wool",
        "wool fat",
        "wool wax",
        "wool wax alcohols",
        "yoghurt",
        "yogurt",
        "zinc caseinate",
        "zinc hydrolyzed animal protein"
    ]
}
