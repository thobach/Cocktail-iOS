//
//  AppDelegate.m
//  cocktail
//
//  Created by Thomas Bachmann on 14.09.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "CocktailTableViewController.h"
#import "CocktailDetailViewController.h"
#import "RandomCocktailViewController.h"
#import "IngredientTableViewController.h"
#import "ShoppingTableViewController.h"
#import "QuizViewController.h"
#import "Cocktail.h"
#import "Ingredient.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // copy sqlite database if not existing
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent: @"cocktaildb.sqlite"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:storeURL.path]) {
        NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"cocktaildb" ofType:@"sqlite"];
        if (defaultStorePath) {
            [fileManager copyItemAtPath:defaultStorePath toPath:storeURL.path error:NULL];
        }
    }
    
    if(false){
        // Ingredient ID: 73
        Ingredient *ingredient73 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient73.name = @"Ingredient73Key";
        ingredient73.name_de = @"Ananas";
        ingredient73.name_en = @"Pineapple";
        ingredient73.category = @"FruitsAndVegtablesKey";
        ingredient73.products = @"Ingredient73ProductsKey";
        // Ingredient ID: 16
        Ingredient *ingredient16 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient16.name = @"Ingredient16Key";
        ingredient16.name_de = @"Ananassaft";
        ingredient16.name_en = @"Pineapple Juice";
        ingredient16.category = @"JuicesKey";
        ingredient16.products = @"Ingredient16ProductsKey";
        // Ingredient ID: 39
        Ingredient *ingredient39 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient39.name = @"Ingredient39Key";
        ingredient39.name_de = @"Aperol";
        ingredient39.name_en = @"Aperol";
        ingredient39.category = @"AlcoholBelow29PercentKey";
        ingredient39.products = @"Ingredient39ProductsKey";
        // Ingredient ID: 40
        Ingredient *ingredient40 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient40.name = @"Ingredient40Key";
        ingredient40.name_de = @"Apricot Brandy";
        ingredient40.name_en = @"Apricot Brandy";
        ingredient40.category = @"AlcoholBelow29PercentKey";
        ingredient40.products = @"Ingredient40ProductsKey";
        // Ingredient ID: 23
        Ingredient *ingredient23 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient23.name = @"Ingredient23Key";
        ingredient23.name_de = @"Bananensirup";
        ingredient23.name_en = @"Banana Syrup";
        ingredient23.category = @"SyrupsKey";
        ingredient23.products = @"Ingredient23ProductsKey";
        // Ingredient ID: 79
        Ingredient *ingredient79 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient79.name = @"Ingredient79Key";
        ingredient79.name_de = @"Bitter Lemon";
        ingredient79.name_en = @"Bitter Lemon";
        ingredient79.category = @"SodasKey";
        ingredient79.products = @"Ingredient79ProductsKey";
        // Ingredient ID: 24
        Ingredient *ingredient24 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient24.name = @"Ingredient24Key";
        ingredient24.name_de = @"Blue Curaçao";
        ingredient24.name_en = @"Blue Curaçao";
        ingredient24.category = @"AlcoholBelow29PercentKey";
        ingredient24.products = @"Ingredient24ProductsKey";
        // Ingredient ID: 59
        Ingredient *ingredient59 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient59.name = @"Ingredient59Key";
        ingredient59.name_de = @"Blue Curacao Sirup";
        ingredient59.name_en = @"Blue Curaçao Syrup";
        ingredient59.category = @"SyrupsKey";
        ingredient59.products = @"Ingredient59ProductsKey";
        // Ingredient ID: 77
        Ingredient *ingredient77 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient77.name = @"Ingredient77Key";
        ingredient77.name_de = @"Blutorangensaft";
        ingredient77.name_en = @"Blood Orange Juice";
        ingredient77.category = @"JuicesKey";
        ingredient77.products = @"Ingredient77ProductsKey";
        // Ingredient ID: 25
        Ingredient *ingredient25 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient25.name = @"Ingredient25Key";
        ingredient25.name_de = @"Cachaça";
        ingredient25.name_en = @"Cachaça";
        ingredient25.category = @"AlcoholAbove30PercentKey";
        ingredient25.products = @"Ingredient25ProductsKey";
        // Ingredient ID: 26
        Ingredient *ingredient26 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient26.name = @"Ingredient26Key";
        ingredient26.name_de = @"Cherry Brandy";
        ingredient26.name_en = @"Cherry Brandy";
        ingredient26.category = @"AlcoholBelow29PercentKey";
        ingredient26.products = @"Ingredient26ProductsKey";
        // Ingredient ID: 114
        Ingredient *ingredient114 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient114.name = @"Ingredient114Key";
        ingredient114.name_de = @"Crushed Ice";
        ingredient114.name_en = @"Crushed Ice";
        ingredient114.category = @"OtherKey";
        ingredient114.products = @"Ingredient114ProductsKey";
        // Ingredient ID: 22
        Ingredient *ingredient22 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient22.name = @"Ingredient22Key";
        ingredient22.name_de = @"Cola";
        ingredient22.name_en = @"Cola";
        ingredient22.category = @"SodasKey";
        ingredient22.products = @"Ingredient22ProductsKey";
        // Ingredient ID: 15
        Ingredient *ingredient15 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient15.name = @"Ingredient15Key";
        ingredient15.name_de = @"Cranberrysaft";
        ingredient15.name_en = @"Cranberry Juice";
        ingredient15.category = @"JuicesKey";
        ingredient15.products = @"Ingredient15ProductsKey";
        // Ingredient ID: 21
        Ingredient *ingredient21 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient21.name = @"Ingredient21Key";
        ingredient21.name_de = @"Cream of Coconut";
        ingredient21.name_en = @"Cream of Coconut";
        ingredient21.category = @"DairyKey";
        ingredient21.products = @"Ingredient21ProductsKey";
        // Ingredient ID: 85
        Ingredient *ingredient85 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient85.name = @"Ingredient85Key";
        ingredient85.name_de = @"Creme de Cacao braun";
        ingredient85.name_en = @"Creme de Cacao Brown";
        ingredient85.category = @"AlcoholBelow29PercentKey";
        ingredient85.products = @"Ingredient85ProductsKey";
        // Ingredient ID: 84
        Ingredient *ingredient84 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient84.name = @"Ingredient84Key";
        ingredient84.name_de = @"Creme de Cacao weiß";
        ingredient84.name_en = @"White Creme de Cacao";
        ingredient84.category = @"AlcoholBelow29PercentKey";
        ingredient84.products = @"Ingredient84ProductsKey";
        // Ingredient ID: 27
        Ingredient *ingredient27 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient27.name = @"Ingredient27Key";
        ingredient27.name_de = @"Cremelikör";
        ingredient27.name_en = @"Cream Liqueur";
        ingredient27.category = @"AlcoholBelow29PercentKey";
        ingredient27.products = @"Ingredient27ProductsKey";
        // Ingredient ID: 113
        Ingredient *ingredient113 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient113.name = @"Ingredient113Key";
        ingredient113.name_de = @"Eiswürfel";
        ingredient113.name_en = @"Ice cubes";
        ingredient113.category = @"OtherKey";
        ingredient113.products = @"Ingredient113ProductsKey";
        // Ingredient ID: 71
        Ingredient *ingredient71 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient71.name = @"Ingredient71Key";
        ingredient71.name_de = @"Erdbeersirup";
        ingredient71.name_en = @"Strawberry Syrup";
        ingredient71.category = @"SyrupsKey";
        ingredient71.products = @"Ingredient71ProductsKey";
        // Ingredient ID: 2
        Ingredient *ingredient2 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient2.name = @"Ingredient2Key";
        ingredient2.name_de = @"Gin";
        ingredient2.name_en = @"Gin";
        ingredient2.category = @"AlcoholAbove30PercentKey";
        ingredient2.products = @"Ingredient2ProductsKey";
        // Ingredient ID: 17
        Ingredient *ingredient17 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient17.name = @"Ingredient17Key";
        ingredient17.name_de = @"Grapefruitsaft";
        ingredient17.name_en = @"Grapefruit Juice";
        ingredient17.category = @"JuicesKey";
        ingredient17.products = @"Ingredient17ProductsKey";
        // Ingredient ID: 3
        Ingredient *ingredient3 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient3.name = @"Ingredient3Key";
        ingredient3.name_de = @"Grenadinesirup";
        ingredient3.name_en = @"Grenadine Syrup";
        ingredient3.category = @"SyrupsKey";
        ingredient3.products = @"Ingredient3ProductsKey";
        // Ingredient ID: 96
        Ingredient *ingredient96 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient96.name = @"Ingredient96Key";
        ingredient96.name_de = @"Grüner Pfefferminzlikör";
        ingredient96.name_en = @"Green Peppermint Liqueur";
        ingredient96.category = @"AlcoholBelow29PercentKey";
        ingredient96.products = @"Ingredient96ProductsKey";
        // Ingredient ID: 28
        Ingredient *ingredient28 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient28.name = @"Ingredient28Key";
        ingredient28.name_de = @"Kaffeelikör";
        ingredient28.name_en = @"Coffee Liqueur";
        ingredient28.category = @"AlcoholBelow29PercentKey";
        ingredient28.products = @"Ingredient28ProductsKey";
        // Ingredient ID: 65
        Ingredient *ingredient65 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient65.name = @"Ingredient65Key";
        ingredient65.name_de = @"Karamelsirup";
        ingredient65.name_en = @"Caramel Syrup";
        ingredient65.category = @"SyrupsKey";
        ingredient65.products = @"Ingredient65ProductsKey";
        // Ingredient ID: 48
        Ingredient *ingredient48 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient48.name = @"Ingredient48Key";
        ingredient48.name_de = @"Kirschlikör";
        ingredient48.name_en = @"Cherry Brandy";
        ingredient48.category = @"AlcoholBelow29PercentKey";
        ingredient48.products = @"Ingredient48ProductsKey";
        // Ingredient ID: 18
        Ingredient *ingredient18 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient18.name = @"Ingredient18Key";
        ingredient18.name_de = @"Kirschsaft";
        ingredient18.name_en = @"Cherry Juice";
        ingredient18.category = @"JuicesKey";
        ingredient18.products = @"Ingredient18ProductsKey";
        // Ingredient ID: 29
        Ingredient *ingredient29 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient29.name = @"Ingredient29Key";
        ingredient29.name_de = @"Kokoslikör";
        ingredient29.name_en = @"Coconut Liqueur";
        ingredient29.category = @"AlcoholBelow29PercentKey";
        ingredient29.products = @"Ingredient29ProductsKey";
        // Ingredient ID: 74
        Ingredient *ingredient74 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient74.name = @"Ingredient74Key";
        ingredient74.name_de = @"Kokossirup";
        ingredient74.name_en = @"Coconut Syrup";
        ingredient74.category = @"SyrupsKey";
        ingredient74.products = @"Ingredient74ProductsKey";
        // Ingredient ID: 10
        Ingredient *ingredient10 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient10.name = @"Ingredient10Key";
        ingredient10.name_de = @"Limette";
        ingredient10.name_en = @"Lime";
        ingredient10.category = @"FruitsAndVegtablesKey";
        ingredient10.products = @"Ingredient10ProductsKey";
        // Ingredient ID: 30
        Ingredient *ingredient30 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient30.name = @"Ingredient30Key";
        ingredient30.name_de = @"Limettensaft";
        ingredient30.name_en = @"Lime Juice";
        ingredient30.category = @"JuicesKey";
        ingredient30.products = @"Ingredient30ProductsKey";
        // Ingredient ID: 31
        Ingredient *ingredient31 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient31.name = @"Ingredient31Key";
        ingredient31.name_de = @"Limettensirup";
        ingredient31.name_en = @"Lime Syrup";
        ingredient31.category = @"SyrupsKey";
        ingredient31.products = @"Ingredient31ProductsKey";
        // Ingredient ID: 7
        Ingredient *ingredient7 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient7.name = @"Ingredient7Key";
        ingredient7.name_de = @"Mandelsirup";
        ingredient7.name_en = @"Almond Syrup";
        ingredient7.category = @"SyrupsKey";
        ingredient7.products = @"Ingredient7ProductsKey";
        // Ingredient ID: 60
        Ingredient *ingredient60 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient60.name = @"Ingredient60Key";
        ingredient60.name_de = @"Maracujasirup";
        ingredient60.name_en = @"Passion Fruit Syrup";
        ingredient60.category = @"SyrupsKey";
        ingredient60.products = @"Ingredient60ProductsKey";
        // Ingredient ID: 32
        Ingredient *ingredient32 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient32.name = @"Ingredient32Key";
        ingredient32.name_de = @"Melonenlikör";
        ingredient32.name_en = @"Melon Liqueur";
        ingredient32.category = @"AlcoholBelow29PercentKey";
        ingredient32.products = @"Ingredient32ProductsKey";
        // Ingredient ID: 11
        Ingredient *ingredient11 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient11.name = @"Ingredient11Key";
        ingredient11.name_de = @"Minzezweig";
        ingredient11.name_en = @"Mint Sprig";
        ingredient11.category = @"OtherKey";
        ingredient11.products = @"Ingredient11ProductsKey";
        // Ingredient ID: 55
        Ingredient *ingredient55 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient55.name = @"Ingredient55Key";
        ingredient55.name_de = @"Minzsirup";
        ingredient55.name_en = @"Mint Syrup";
        ingredient55.category = @"SyrupsKey";
        ingredient55.products = @"Ingredient55ProductsKey";
        // Ingredient ID: 14
        Ingredient *ingredient14 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient14.name = @"Ingredient14Key";
        ingredient14.name_de = @"Orangensaft";
        ingredient14.name_en = @"Orange Juice";
        ingredient14.category = @"JuicesKey";
        ingredient14.products = @"Ingredient14ProductsKey";
        // Ingredient ID: 76
        Ingredient *ingredient76 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient76.name = @"Ingredient76Key";
        ingredient76.name_de = @"Papaya-Saft";
        ingredient76.name_en = @"Papaya Juice";
        ingredient76.category = @"JuicesKey";
        ingredient76.products = @"Ingredient76ProductsKey";
        // Ingredient ID: 118
        Ingredient *ingredient118 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient118.name = @"Ingredient118Key";
        ingredient118.name_de = @"Pfeffer";
        ingredient118.name_en = @"Pepper";
        ingredient118.category = @"OtherKey";
        ingredient118.products = @"Ingredient118ProductsKey";
        // Ingredient ID: 19
        Ingredient *ingredient19 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient19.name = @"Ingredient19Key";
        ingredient19.name_de = @"Pfirsichlikör";
        ingredient19.name_en = @"Peach Liqueur";
        ingredient19.category = @"AlcoholBelow29PercentKey";
        ingredient19.products = @"Ingredient19ProductsKey";
        // Ingredient ID: 119
        Ingredient *ingredient119 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient119.name = @"Ingredient119Key";
        ingredient119.name_de = @"Preiselbeernektar";
        ingredient119.name_en = @"Cowberry Nectar";
        ingredient119.category = @"";
        ingredient119.products = @"Ingredient119ProductsKey";
        // Ingredient ID: 12
        Ingredient *ingredient12 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient12.name = @"Ingredient12Key";
        ingredient12.name_de = @"Rohrzucker";
        ingredient12.name_en = @"Cane sugar";
        ingredient12.category = @"SugarKey";
        ingredient12.products = @"Ingredient12ProductsKey";
        // Ingredient ID: 33
        Ingredient *ingredient33 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient33.name = @"Ingredient33Key";
        ingredient33.name_de = @"Rohrzuckersirup";
        ingredient33.name_en = @"Cane Sugar Syrup";
        ingredient33.category = @"SyrupsKey";
        ingredient33.products = @"Ingredient33ProductsKey";
        // Ingredient ID: 13
        Ingredient *ingredient13 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient13.name = @"Ingredient13Key";
        ingredient13.name_de = @"Rum (braun)";
        ingredient13.name_en = @"Rum (brown)";
        ingredient13.category = @"AlcoholAbove30PercentKey";
        ingredient13.products = @"Ingredient13ProductsKey";
        // Ingredient ID: 75
        Ingredient *ingredient75 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient75.name = @"Ingredient75Key";
        ingredient75.name_de = @"Rum (gold)";
        ingredient75.name_en = @"Rum (Gold)";
        ingredient75.category = @"AlcoholAbove30PercentKey";
        ingredient75.products = @"Ingredient75ProductsKey";
        // Ingredient ID: 8
        Ingredient *ingredient8 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient8.name = @"Ingredient8Key";
        ingredient8.name_de = @"Rum (weiß)";
        ingredient8.name_en = @"Rum (white)";
        ingredient8.category = @"AlcoholAbove30PercentKey";
        ingredient8.products = @"Ingredient8ProductsKey";
        // Ingredient ID: 34
        Ingredient *ingredient34 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient34.name = @"Ingredient34Key";
        ingredient34.name_de = @"Rum 73%";
        ingredient34.name_en = @"Rum 73%";
        ingredient34.category = @"AlcoholAbove30PercentKey";
        ingredient34.products = @"Ingredient34ProductsKey";
        // Ingredient ID: 35
        Ingredient *ingredient35 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient35.name = @"Ingredient35Key";
        ingredient35.name_de = @"Sahne";
        ingredient35.name_en = @"Cream";
        ingredient35.category = @"DairyKey";
        ingredient35.products = @"Ingredient35ProductsKey";
        // Ingredient ID: 117
        Ingredient *ingredient117 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient117.name = @"Ingredient117Key";
        ingredient117.name_de = @"Salz";
        ingredient117.name_en = @"Salt";
        ingredient117.category = @"OtherKey";
        ingredient117.products = @"Ingredient117ProductsKey";
        // Ingredient ID: 9
        Ingredient *ingredient9 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient9.name = @"Ingredient9Key";
        ingredient9.name_de = @"Soda";
        ingredient9.name_en = @"Soda";
        ingredient9.category = @"SodasKey";
        ingredient9.products = @"Ingredient9ProductsKey";
        // Ingredient ID: 72
        Ingredient *ingredient72 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient72.name = @"Ingredient72Key";
        ingredient72.name_de = @"Stielkirsche";
        ingredient72.name_en = @"Cherry";
        ingredient72.category = @"FruitsAndVegtablesKey";
        ingredient72.products = @"Ingredient72ProductsKey";
        // Ingredient ID: 116
        Ingredient *ingredient116 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient116.name = @"Ingredient116Key";
        ingredient116.name_de = @"Tabascosauce";
        ingredient116.name_en = @"Tabasco Sauce";
        ingredient116.category = @"OtherKey";
        ingredient116.products = @"Ingredient116ProductsKey";
        // Ingredient ID: 36
        Ingredient *ingredient36 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient36.name = @"Ingredient36Key";
        ingredient36.name_de = @"Tequila (weiß)";
        ingredient36.name_en = @"Tequila (white)";
        ingredient36.category = @"AlcoholAbove30PercentKey";
        ingredient36.products = @"Ingredient36ProductsKey";
        // Ingredient ID: 82
        Ingredient *ingredient82 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient82.name = @"Ingredient82Key";
        ingredient82.name_de = @"Tomatensaft";
        ingredient82.name_en = @"Tomato Juice";
        ingredient82.category = @"JuicesKey";
        ingredient82.products = @"Ingredient82ProductsKey";
        // Ingredient ID: 80
        Ingredient *ingredient80 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient80.name = @"Ingredient80Key";
        ingredient80.name_de = @"Tonic Water";
        ingredient80.name_en = @"Tonic Water";
        ingredient80.category = @"SodasKey";
        ingredient80.products = @"Ingredient80ProductsKey";
        // Ingredient ID: 37
        Ingredient *ingredient37 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient37.name = @"Ingredient37Key";
        ingredient37.name_de = @"Triple Sec Curaçao";
        ingredient37.name_en = @"Triple Sec Curacao";
        ingredient37.category = @"AlcoholAbove30PercentKey";
        ingredient37.products = @"Ingredient37ProductsKey";
        // Ingredient ID: 78
        Ingredient *ingredient78 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient78.name = @"Ingredient78Key";
        ingredient78.name_de = @"Vodka Zitrone";
        ingredient78.name_en = @"Vodka Lemon";
        ingredient78.category = @"AlcoholAbove30PercentKey";
        ingredient78.products = @"Ingredient78ProductsKey";
        // Ingredient ID: 38
        Ingredient *ingredient38 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient38.name = @"Ingredient38Key";
        ingredient38.name_de = @"Whiskeylikör";
        ingredient38.name_en = @"Whiskey Liqueur";
        ingredient38.category = @"AlcoholAbove30PercentKey";
        ingredient38.products = @"Ingredient38ProductsKey";
        // Ingredient ID: 1
        Ingredient *ingredient1 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient1.name = @"Ingredient1Key";
        ingredient1.name_de = @"Wodka";
        ingredient1.name_en = @"Vodka";
        ingredient1.category = @"AlcoholAbove30PercentKey";
        ingredient1.products = @"Ingredient1ProductsKey";
        // Ingredient ID: 115
        Ingredient *ingredient115 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient115.name = @"Ingredient115Key";
        ingredient115.name_de = @"Worcestershiresauce";
        ingredient115.name_en = @"Worcestershire Sauce";
        ingredient115.category = @"OtherKey";
        ingredient115.products = @"Ingredient115ProductsKey";
        // Ingredient ID: 83
        Ingredient *ingredient83 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient83.name = @"Ingredient83Key";
        ingredient83.name_de = @"Zitronenlimonade";
        ingredient83.name_en = @"Lemonade (Lemon)";
        ingredient83.category = @"SodasKey";
        ingredient83.products = @"Ingredient83ProductsKey";
        // Ingredient ID: 4
        Ingredient *ingredient4 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.managedObjectContext];
        ingredient4.name = @"Ingredient4Key";
        ingredient4.name_de = @"Zitronensaft";
        ingredient4.name_en = @"Lemon Juice";
        ingredient4.category = @"JuicesKey";
        ingredient4.products = @"Ingredient4ProductsKey";
        
        // Cocktail ID: 40
        Cocktail *cocktail37 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail37.name = @"Aperol Sour";
        cocktail37.instructions = @"Cocktail37InstructionsKey";
        cocktail37.ingredients = @"Cocktail37IngredientsKey";
        cocktail37.components = @"Cocktail37ComponentsKey";
        cocktail37.difficulty = @"beginner";
        cocktail37.prepTime = @"2";
        cocktail37.alcLevel = @"6.7";
        cocktail37.calKcal = @"157";
        cocktail37.volCl = @"16";
        cocktail37.glassName = @"Longdrinkglas";
        cocktail37.glassPhotoUrl = @"longdrink.png";
        cocktail37.photoUrl = @"longdrink_big.png";
        cocktail37.tags = @"lecker";
        cocktail37.source = @"Cocktail37SourceKey";
        // Cocktail ID: 41
        Cocktail *cocktail38 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail38.name = @"Apricot Fizz";
        cocktail38.instructions = @"Cocktail38InstructionsKey";
        cocktail38.ingredients = @"Cocktail38IngredientsKey";
        cocktail38.components = @"Cocktail38ComponentsKey";
        cocktail38.difficulty = @"beginner";
        cocktail38.prepTime = @"3";
        cocktail38.alcLevel = @"7.1";
        cocktail38.calKcal = @"173";
        cocktail38.volCl = @"24";
        cocktail38.glassName = @"Hurricaneglas";
        cocktail38.glassPhotoUrl = @"hurricane.png";
        cocktail38.photoUrl = @"hurricane_big.png";
        cocktail38.tags = @"";
        cocktail38.source = @"Cocktail38SourceKey";
        // Cocktail ID: 30
        Cocktail *cocktail27 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail27.name = @"B 52";
        cocktail27.instructions = @"Cocktail27InstructionsKey";
        cocktail27.ingredients = @"Cocktail27IngredientsKey";
        cocktail27.components = @"Cocktail27ComponentsKey";
        cocktail27.difficulty = @"profi";
        cocktail27.prepTime = @"2";
        cocktail27.alcLevel = @"30.5";
        cocktail27.calKcal = @"153";
        cocktail27.volCl = @"5";
        cocktail27.glassName = @"Shooter Glas";
        cocktail27.glassPhotoUrl = @"shooter.png";
        cocktail27.photoUrl = @"B52_iba_small.jpg";
        cocktail27.tags = @"heiß, lecker, alkoholisch, feurig, Shooter, sehr stark";
        cocktail27.source = @"Cocktail27SourceKey";
        // Cocktail ID: 18
        Cocktail *cocktail15 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail15.name = @"Bahama Mama";
        cocktail15.instructions = @"Cocktail15InstructionsKey";
        cocktail15.ingredients = @"Cocktail15IngredientsKey";
        cocktail15.components = @"Cocktail15ComponentsKey";
        cocktail15.difficulty = @"beginner";
        cocktail15.prepTime = @"2";
        cocktail15.alcLevel = @"16.5";
        cocktail15.calKcal = @"258";
        cocktail15.volCl = @"25";
        cocktail15.glassName = @"Hurricaneglas";
        cocktail15.glassPhotoUrl = @"hurricane.png";
        cocktail15.photoUrl = @"15.jpg";
        cocktail15.tags = @"";
        cocktail15.source = @"Cocktail15SourceKey";
        // Cocktail ID: 19
        Cocktail *cocktail16 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail16.name = @"Batida Kirsch";
        cocktail16.instructions = @"Cocktail16InstructionsKey";
        cocktail16.ingredients = @"Cocktail16IngredientsKey";
        cocktail16.components = @"Cocktail16ComponentsKey";
        cocktail16.difficulty = @"beginner";
        cocktail16.prepTime = @"2";
        cocktail16.alcLevel = @"4.3";
        cocktail16.calKcal = @"315";
        cocktail16.volCl = @"27";
        cocktail16.glassName = @"großer Tumbler";
        cocktail16.glassPhotoUrl = @"tumbler_gross.png";
        cocktail16.photoUrl = @"dreamstime_8945972-batida-kirsch.jpg";
        cocktail16.tags = @"Longdrink, lecker, erfrischend, leicht";
        cocktail16.source = @"Cocktail16SourceKey";
        // Cocktail ID: 57
        Cocktail *cocktail84 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail84.name = @"Black Russian";
        cocktail84.instructions = @"Cocktail84InstructionsKey";
        cocktail84.ingredients = @"Cocktail84IngredientsKey";
        cocktail84.components = @"Cocktail84ComponentsKey";
        cocktail84.difficulty = @"beginner";
        cocktail84.prepTime = @"2";
        cocktail84.alcLevel = @"33.6";
        cocktail84.calKcal = @"205";
        cocktail84.volCl = @"14";
        cocktail84.glassName = @"kleiner Tumbler";
        cocktail84.glassPhotoUrl = @"tumbler_klein.png";
        cocktail84.photoUrl = @"black_russian_dreamstime_12849334_small.jpg";
        cocktail84.tags = @"Klassiker, Original, Wodka, Tops";
        cocktail84.source = @"Cocktail84SourceKey";
        // Cocktail ID: 47
        Cocktail *cocktail86 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail86.name = @"Bloody Mary";
        cocktail86.instructions = @"Cocktail86InstructionsKey";
        cocktail86.ingredients = @"Cocktail86IngredientsKey";
        cocktail86.components = @"Cocktail86ComponentsKey";
        cocktail86.difficulty = @"advanced";
        cocktail86.prepTime = @"3";
        cocktail86.alcLevel = @"9.5";
        cocktail86.calKcal = @"123";
        cocktail86.volCl = @"18";
        cocktail86.glassName = @"Weinglas";
        cocktail86.glassPhotoUrl = @"wine.png";
        cocktail86.photoUrl = @"bloodymary_small.jpg";
        cocktail86.tags = @"Tomatensaft, 1921, scharf, Petiot, Paris, Vodka, Pete, 1920";
        cocktail86.source = @"Cocktail86SourceKey";
        // Cocktail ID: 23
        Cocktail *cocktail20 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail20.name = @"Blue Hawaiian";
        cocktail20.instructions = @"Cocktail20InstructionsKey";
        cocktail20.ingredients = @"Cocktail20IngredientsKey";
        cocktail20.components = @"Cocktail20ComponentsKey";
        cocktail20.difficulty = @"beginner";
        cocktail20.prepTime = @"4";
        cocktail20.alcLevel = @"9.8";
        cocktail20.calKcal = @"185";
        cocktail20.volCl = @"32";
        cocktail20.glassName = @"Hurricaneglas";
        cocktail20.glassPhotoUrl = @"hurricane.png";
        cocktail20.photoUrl = @"20.jpg";
        cocktail20.tags = @"";
        cocktail20.source = @"Cocktail20SourceKey";
        // Cocktail ID: 48
        Cocktail *cocktail70 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail70.name = @"Blue Lagoon";
        cocktail70.instructions = @"Cocktail70InstructionsKey";
        cocktail70.ingredients = @"Cocktail70IngredientsKey";
        cocktail70.components = @"Cocktail70ComponentsKey";
        cocktail70.difficulty = @"beginner";
        cocktail70.prepTime = @"2";
        cocktail70.alcLevel = @"10.6";
        cocktail70.calKcal = @"211";
        cocktail70.volCl = @"28";
        cocktail70.glassName = @"Longdrinkglas";
        cocktail70.glassPhotoUrl = @"longdrink.png";
        cocktail70.photoUrl = @"IStock_000005989817XSmall-zorro_klein.jpg";
        cocktail70.tags = @"lecker, Klassiker, erfrischend";
        cocktail70.source = @"Cocktail70SourceKey";
        // Cocktail ID: 25
        Cocktail *cocktail22 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail22.name = @"Brasilian Sunrise";
        cocktail22.instructions = @"Cocktail22InstructionsKey";
        cocktail22.ingredients = @"Cocktail22IngredientsKey";
        cocktail22.components = @"Cocktail22ComponentsKey";
        cocktail22.difficulty = @"beginner";
        cocktail22.prepTime = @"4";
        cocktail22.alcLevel = @"9.4";
        cocktail22.calKcal = @"230";
        cocktail22.volCl = @"24";
        cocktail22.glassName = @"großer Tumbler";
        cocktail22.glassPhotoUrl = @"tumbler_gross.png";
        cocktail22.photoUrl = @"22.jpg";
        cocktail22.tags = @"tequila";
        cocktail22.source = @"Cocktail22SourceKey";
        // Cocktail ID: 24
        Cocktail *cocktail52 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail52.name = @"Caipirinha";
        cocktail52.instructions = @"Cocktail52InstructionsKey";
        cocktail52.ingredients = @"Cocktail52IngredientsKey";
        cocktail52.components = @"Cocktail52ComponentsKey";
        cocktail52.difficulty = @"advanced";
        cocktail52.prepTime = @"3";
        cocktail52.alcLevel = @"40";
        cocktail52.calKcal = @"180";
        cocktail52.volCl = @"26";
        cocktail52.glassName = @"kleiner Tumbler";
        cocktail52.glassPhotoUrl = @"tumbler_klein.png";
        cocktail52.photoUrl = @"21.jpg";
        cocktail52.tags = @"erfrischend, stark, Klassiker, sauer, lecker";
        cocktail52.source = @"Cocktail52SourceKey";
        // Cocktail ID: 20
        Cocktail *cocktail17 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail17.name = @"Cairo Cocktail";
        cocktail17.instructions = @"Cocktail17InstructionsKey";
        cocktail17.ingredients = @"Cocktail17IngredientsKey";
        cocktail17.components = @"Cocktail17ComponentsKey";
        cocktail17.difficulty = @"beginner";
        cocktail17.prepTime = @"2";
        cocktail17.alcLevel = @"9.1";
        cocktail17.calKcal = @"243";
        cocktail17.volCl = @"29";
        cocktail17.glassName = @"großer Tumbler";
        cocktail17.glassPhotoUrl = @"tumbler_gross.png";
        cocktail17.photoUrl = @"17.jpg";
        cocktail17.tags = @"";
        cocktail17.source = @"Cocktail17SourceKey";
        // Cocktail ID: 16
        Cocktail *cocktail13 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail13.name = @"Caribbean Cruise";
        cocktail13.instructions = @"Cocktail13InstructionsKey";
        cocktail13.ingredients = @"Cocktail13IngredientsKey";
        cocktail13.components = @"Cocktail13ComponentsKey";
        cocktail13.difficulty = @"profi";
        cocktail13.prepTime = @"2";
        cocktail13.alcLevel = @"13.7";
        cocktail13.calKcal = @"205";
        cocktail13.volCl = @"16";
        cocktail13.glassName = @"großer Tumbler";
        cocktail13.glassPhotoUrl = @"tumbler_gross.png";
        cocktail13.photoUrl = @"tumbler_gross_big.png";
        cocktail13.tags = @"";
        cocktail13.source = @"Cocktail13SourceKey";
        // Cocktail ID: 35
        Cocktail *cocktail32 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail32.name = @"Chicago Freestyle";
        cocktail32.instructions = @"Cocktail32InstructionsKey";
        cocktail32.ingredients = @"Cocktail32IngredientsKey";
        cocktail32.components = @"Cocktail32ComponentsKey";
        cocktail32.difficulty = @"beginner";
        cocktail32.prepTime = @"2";
        cocktail32.alcLevel = @"17";
        cocktail32.calKcal = @"317";
        cocktail32.volCl = @"27";
        cocktail32.glassName = @"großer Tumbler";
        cocktail32.glassPhotoUrl = @"tumbler_gross.png";
        cocktail32.photoUrl = @"tumbler_gross_big.png";
        cocktail32.tags = @"";
        cocktail32.source = @"Cocktail32SourceKey";
        // Cocktail ID: 42
        Cocktail *cocktail55 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail55.name = @"Cosmopolitan";
        cocktail55.instructions = @"Cocktail55InstructionsKey";
        cocktail55.ingredients = @"Cocktail55IngredientsKey";
        cocktail55.components = @"Cocktail55ComponentsKey";
        cocktail55.difficulty = @"advanced";
        cocktail55.prepTime = @"2";
        cocktail55.alcLevel = @"21";
        cocktail55.calKcal = @"145";
        cocktail55.volCl = @"17";
        cocktail55.glassName = @"Cocktailschale";
        cocktail55.glassPhotoUrl = @"cocktail.png";
        cocktail55.photoUrl = @"cosmopolitan_small.jpg";
        cocktail55.tags = @"Klassiker";
        cocktail55.source = @"Cocktail55SourceKey";
        // Cocktail ID: 29
        Cocktail *cocktail26 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail26.name = @"Cuba Libre";
        cocktail26.instructions = @"Cocktail26InstructionsKey";
        cocktail26.ingredients = @"Cocktail26IngredientsKey";
        cocktail26.components = @"Cocktail26ComponentsKey";
        cocktail26.difficulty = @"beginner";
        cocktail26.prepTime = @"2";
        cocktail26.alcLevel = @"7.6";
        cocktail26.calKcal = @"159";
        cocktail26.volCl = @"26";
        cocktail26.glassName = @"großer Tumbler";
        cocktail26.glassPhotoUrl = @"tumbler_gross.png";
        cocktail26.photoUrl = @"26.jpg";
        cocktail26.tags = @"";
        cocktail26.source = @"Cocktail26SourceKey";
        // Cocktail ID: 32
        Cocktail *cocktail29 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail29.name = @"Daiquiri";
        cocktail29.instructions = @"Cocktail29InstructionsKey";
        cocktail29.ingredients = @"Cocktail29IngredientsKey";
        cocktail29.components = @"Cocktail29ComponentsKey";
        cocktail29.difficulty = @"advanced";
        cocktail29.prepTime = @"2";
        cocktail29.alcLevel = @"22.3";
        cocktail29.calKcal = @"121";
        cocktail29.volCl = @"13";
        cocktail29.glassName = @"Cocktailschale";
        cocktail29.glassPhotoUrl = @"cocktail.png";
        cocktail29.photoUrl = @"29.jpg";
        cocktail29.tags = @"";
        cocktail29.source = @"Cocktail29SourceKey";
        // Cocktail ID: 51
        Cocktail *cocktail73 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail73.name = @"Fifth Avenue";
        cocktail73.instructions = @"Cocktail73InstructionsKey";
        cocktail73.ingredients = @"Cocktail73IngredientsKey";
        cocktail73.components = @"Cocktail73ComponentsKey";
        cocktail73.difficulty = @"advanced";
        cocktail73.prepTime = @"3";
        cocktail73.alcLevel = @"16";
        cocktail73.calKcal = @"240";
        cocktail73.volCl = @"16";
        cocktail73.glassName = @"Cocktailschale";
        cocktail73.glassPhotoUrl = @"cocktail.png";
        cocktail73.photoUrl = @"iStock_000004256948XSmall.jpg";
        cocktail73.tags = @"lecker, Brandl, Klassiker, Cocktailschale, original, süß, Schokolade, cremig, sahnig";
        cocktail73.source = @"Cocktail73SourceKey";
        // Cocktail ID: 49
        Cocktail *cocktail71 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail71.name = @"Gin Tonic";
        cocktail71.instructions = @"Cocktail71InstructionsKey";
        cocktail71.ingredients = @"Cocktail71IngredientsKey";
        cocktail71.components = @"Cocktail71ComponentsKey";
        cocktail71.difficulty = @"beginner";
        cocktail71.prepTime = @"1";
        cocktail71.alcLevel = @"14.3";
        cocktail71.calKcal = @"331";
        cocktail71.volCl = @"27";
        cocktail71.glassName = @"Longdrinkglas";
        cocktail71.glassPhotoUrl = @"longdrink.png";
        cocktail71.photoUrl = @"Gin-tonic_klein.jpg";
        cocktail71.tags = @"lecker, Longdrink, Klassiker, herb";
        cocktail71.source = @"Cocktail71SourceKey";
        // Cocktail ID: 56
        Cocktail *cocktail82 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail82.name = @"Grasshopper";
        cocktail82.instructions = @"Cocktail82InstructionsKey";
        cocktail82.ingredients = @"Cocktail82IngredientsKey";
        cocktail82.components = @"Cocktail82ComponentsKey";
        cocktail82.difficulty = @"beginner";
        cocktail82.prepTime = @"2";
        cocktail82.alcLevel = @"12";
        cocktail82.calKcal = @"338";
        cocktail82.volCl = @"17";
        cocktail82.glassName = @"Cocktailschale";
        cocktail82.glassPhotoUrl = @"cocktail.png";
        cocktail82.photoUrl = @"dreamstime_12851464-grasshopper_small.jpg";
        cocktail82.tags = @"süß, grün, After-Dinner Cocktail, alkoholisch, Klassiker, Original";
        cocktail82.source = @"Cocktail82SourceKey";
        // Cocktail ID: 43
        Cocktail *cocktail56 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail56.name = @"Kamikaze";
        cocktail56.instructions = @"Cocktail56InstructionsKey";
        cocktail56.ingredients = @"Cocktail56IngredientsKey";
        cocktail56.components = @"Cocktail56ComponentsKey";
        cocktail56.difficulty = @"beginner";
        cocktail56.prepTime = @"2";
        cocktail56.alcLevel = @"24.1";
        cocktail56.calKcal = @"158";
        cocktail56.volCl = @"16";
        cocktail56.glassName = @"Cocktailschale";
        cocktail56.glassPhotoUrl = @"cocktail.png";
        cocktail56.photoUrl = @"cocktail_big.png";
        cocktail56.tags = @"Klassiker";
        cocktail56.source = @"Cocktail56SourceKey";
        // Cocktail ID: 27
        Cocktail *cocktail60 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail60.name = @"Long Island Ice Tea";
        cocktail60.instructions = @"Cocktail60InstructionsKey";
        cocktail60.ingredients = @"Cocktail60IngredientsKey";
        cocktail60.components = @"Cocktail60ComponentsKey";
        cocktail60.difficulty = @"beginner";
        cocktail60.prepTime = @"4";
        cocktail60.alcLevel = @"13.1";
        cocktail60.calKcal = @"332";
        cocktail60.volCl = @"28";
        cocktail60.glassName = @"Cocktailglas / Highballglas";
        cocktail60.glassPhotoUrl = @"highball.png";
        cocktail60.photoUrl = @"24.jpg";
        cocktail60.tags = @"Klassiker";
        cocktail60.source = @"Cocktail60SourceKey";
        // Cocktail ID: 15
        Cocktail *cocktail12 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail12.name = @"Magic Queen";
        cocktail12.instructions = @"Cocktail12InstructionsKey";
        cocktail12.ingredients = @"Cocktail12IngredientsKey";
        cocktail12.components = @"Cocktail12ComponentsKey";
        cocktail12.difficulty = @"beginner";
        cocktail12.prepTime = @"2";
        cocktail12.alcLevel = @"11.9";
        cocktail12.calKcal = @"254";
        cocktail12.volCl = @"29";
        cocktail12.glassName = @"großer Tumbler";
        cocktail12.glassPhotoUrl = @"tumbler_gross.png";
        cocktail12.photoUrl = @"tumbler_gross_big.png";
        cocktail12.tags = @"";
        cocktail12.source = @"Cocktail12SourceKey";
        // Cocktail ID: 36
        Cocktail *cocktail58 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail58.name = @"Mai Tai";
        cocktail58.instructions = @"Cocktail58InstructionsKey";
        cocktail58.ingredients = @"Cocktail58IngredientsKey";
        cocktail58.components = @"Cocktail58ComponentsKey";
        cocktail58.difficulty = @"beginner";
        cocktail58.prepTime = @"2";
        cocktail58.alcLevel = @"25.7";
        cocktail58.calKcal = @"234";
        cocktail58.volCl = @"31";
        cocktail58.glassName = @"kleiner Tumbler";
        cocktail58.glassPhotoUrl = @"tumbler_klein.png";
        cocktail58.photoUrl = @"rum_maitai.jpg";
        cocktail58.tags = @"Klassiker, Rum, Original";
        cocktail58.source = @"Cocktail58SourceKey";
        // Cocktail ID: 38
        Cocktail *cocktail35 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail35.name = @"Margarita";
        cocktail35.instructions = @"Cocktail35InstructionsKey";
        cocktail35.ingredients = @"Cocktail35IngredientsKey";
        cocktail35.components = @"Cocktail35ComponentsKey";
        cocktail35.difficulty = @"advanced";
        cocktail35.prepTime = @"2";
        cocktail35.alcLevel = @"27.3";
        cocktail35.calKcal = @"138";
        cocktail35.volCl = @"15";
        cocktail35.glassName = @"Margarita Glas";
        cocktail35.glassPhotoUrl = @"margarita.png";
        cocktail35.photoUrl = @"35.jpg";
        cocktail35.tags = @"";
        cocktail35.source = @"Cocktail35SourceKey";
        // Cocktail ID: 1
        Cocktail *cocktail59 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail59.name = @"Mojito";
        cocktail59.instructions = @"Cocktail59InstructionsKey";
        cocktail59.ingredients = @"Cocktail59IngredientsKey";
        cocktail59.components = @"Cocktail59ComponentsKey";
        cocktail59.difficulty = @"beginner";
        cocktail59.prepTime = @"3";
        cocktail59.alcLevel = @"8.5";
        cocktail59.calKcal = @"135";
        cocktail59.volCl = @"39";
        cocktail59.glassName = @"Longdrinkglas";
        cocktail59.glassPhotoUrl = @"longdrink.png";
        cocktail59.photoUrl = @"1.jpg";
        cocktail59.tags = @"Klassiker";
        cocktail59.source = @"Cocktail59SourceKey";
        // Cocktail ID: 46
        Cocktail *cocktail64 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail64.name = @"Orgasm ";
        cocktail64.instructions = @"Cocktail64InstructionsKey";
        cocktail64.ingredients = @"Cocktail64IngredientsKey";
        cocktail64.components = @"Cocktail64ComponentsKey";
        cocktail64.difficulty = @"beginner";
        cocktail64.prepTime = @"2";
        cocktail64.alcLevel = @"27.1";
        cocktail64.calKcal = @"226";
        cocktail64.volCl = @"15";
        cocktail64.glassName = @"kleiner Tumbler";
        cocktail64.glassPhotoUrl = @"tumbler_klein.png";
        cocktail64.photoUrl = @"tumbler_klein_big.png";
        cocktail64.tags = @"Klassiker";
        cocktail64.source = @"Cocktail64SourceKey";
        // Cocktail ID: 17
        Cocktail *cocktail72 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail72.name = @"Piña Colada";
        cocktail72.instructions = @"Cocktail72InstructionsKey";
        cocktail72.ingredients = @"Cocktail72IngredientsKey";
        cocktail72.components = @"Cocktail72ComponentsKey";
        cocktail72.difficulty = @"advanced";
        cocktail72.prepTime = @"4";
        cocktail72.alcLevel = @"14.2";
        cocktail72.calKcal = @"288";
        cocktail72.volCl = @"36";
        cocktail72.glassName = @"großer Tumbler";
        cocktail72.glassPhotoUrl = @"tumbler_gross.png";
        cocktail72.photoUrl = @"14.jpg";
        cocktail72.tags = @"Klassiker, lecker";
        cocktail72.source = @"Cocktail72SourceKey";
        // Cocktail ID: 26
        Cocktail *cocktail23 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail23.name = @"Planter's Punch";
        cocktail23.instructions = @"Cocktail23InstructionsKey";
        cocktail23.ingredients = @"Cocktail23IngredientsKey";
        cocktail23.components = @"Cocktail23ComponentsKey";
        cocktail23.difficulty = @"beginner";
        cocktail23.prepTime = @"2";
        cocktail23.alcLevel = @"15";
        cocktail23.calKcal = @"242";
        cocktail23.volCl = @"22";
        cocktail23.glassName = @"großer Tumbler";
        cocktail23.glassPhotoUrl = @"tumbler_gross.png";
        cocktail23.photoUrl = @"23.jpg";
        cocktail23.tags = @"";
        cocktail23.source = @"Cocktail23SourceKey";
        // Cocktail ID: 34
        Cocktail *cocktail31 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail31.name = @"Pussy Foot";
        cocktail31.instructions = @"Cocktail31InstructionsKey";
        cocktail31.ingredients = @"Cocktail31IngredientsKey";
        cocktail31.components = @"Cocktail31ComponentsKey";
        cocktail31.difficulty = @"beginner";
        cocktail31.prepTime = @"2";
        cocktail31.alcLevel = @"0";
        cocktail31.calKcal = @"136";
        cocktail31.volCl = @"27";
        cocktail31.glassName = @"großer Tumbler";
        cocktail31.glassPhotoUrl = @"tumbler_gross.png";
        cocktail31.photoUrl = @"tumbler_gross_big.png";
        cocktail31.tags = @"alkoholfrei, süß, lecker";
        cocktail31.source = @"Cocktail31SourceKey";
        // Cocktail ID: 44
        Cocktail *cocktail61 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail61.name = @"Red Risk";
        cocktail61.instructions = @"Cocktail61InstructionsKey";
        cocktail61.ingredients = @"Cocktail61IngredientsKey";
        cocktail61.components = @"Cocktail61ComponentsKey";
        cocktail61.difficulty = @"beginner";
        cocktail61.prepTime = @"2";
        cocktail61.alcLevel = @"0";
        cocktail61.calKcal = @"218";
        cocktail61.volCl = @"31";
        cocktail61.glassName = @"Hurricaneglas";
        cocktail61.glassPhotoUrl = @"hurricane.png";
        cocktail61.photoUrl = @"hurricane_big.png";
        cocktail61.tags = @"lecker, CarosLiebling, alkoholfrei";
        cocktail61.source = @"Cocktail61SourceKey";
        // Cocktail ID: 21
        Cocktail *cocktail18 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail18.name = @"Sex on the Beach";
        cocktail18.instructions = @"Cocktail18InstructionsKey";
        cocktail18.ingredients = @"Cocktail18IngredientsKey";
        cocktail18.components = @"Cocktail18ComponentsKey";
        cocktail18.difficulty = @"beginner";
        cocktail18.prepTime = @"3";
        cocktail18.alcLevel = @"9.4";
        cocktail18.calKcal = @"188";
        cocktail18.volCl = @"25";
        cocktail18.glassName = @"Longdrinkglas";
        cocktail18.glassPhotoUrl = @"longdrink.png";
        cocktail18.photoUrl = @"18.jpg";
        cocktail18.tags = @"Vodka, chucka, Wodka, sexy, lecker, alkoholfrei";
        cocktail18.source = @"Cocktail18SourceKey";
        // Cocktail ID: 22
        Cocktail *cocktail39 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail39.name = @"Swimming Pool";
        cocktail39.instructions = @"Cocktail39InstructionsKey";
        cocktail39.ingredients = @"Cocktail39IngredientsKey";
        cocktail39.components = @"Cocktail39ComponentsKey";
        cocktail39.difficulty = @"advanced";
        cocktail39.prepTime = @"2";
        cocktail39.alcLevel = @"0";
        cocktail39.calKcal = @"247";
        cocktail39.volCl = @"27";
        cocktail39.glassName = @"Hurricaneglas";
        cocktail39.glassPhotoUrl = @"hurricane.png";
        cocktail39.photoUrl = @"19.jpg";
        cocktail39.tags = @"alkoholfrei, fruchtig, lecker, sahnig, tropisch, gut, Grindig";
        cocktail39.source = @"Cocktail39SourceKey";
        // Cocktail ID: 2
        Cocktail *cocktail67 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail67.name = @"Tequila Sunrise";
        cocktail67.instructions = @"Cocktail67InstructionsKey";
        cocktail67.ingredients = @"Cocktail67IngredientsKey";
        cocktail67.components = @"Cocktail67ComponentsKey";
        cocktail67.difficulty = @"beginner";
        cocktail67.prepTime = @"2";
        cocktail67.alcLevel = @"10.9";
        cocktail67.calKcal = @"147";
        cocktail67.volCl = @"21";
        cocktail67.glassName = @"Longdrinkglas";
        cocktail67.glassPhotoUrl = @"longdrink.png";
        cocktail67.photoUrl = @"2.jpg";
        cocktail67.tags = @"Longdrink";
        cocktail67.source = @"Cocktail67SourceKey";
        // Cocktail ID: 28
        Cocktail *cocktail25 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail25.name = @"Watermelon Man";
        cocktail25.instructions = @"Cocktail25InstructionsKey";
        cocktail25.ingredients = @"Cocktail25IngredientsKey";
        cocktail25.components = @"Cocktail25ComponentsKey";
        cocktail25.difficulty = @"beginner";
        cocktail25.prepTime = @"2";
        cocktail25.alcLevel = @"9.8";
        cocktail25.calKcal = @"241";
        cocktail25.volCl = @"27";
        cocktail25.glassName = @"großer Tumbler";
        cocktail25.glassPhotoUrl = @"tumbler_gross.png";
        cocktail25.photoUrl = @"25.jpg";
        cocktail25.tags = @"";
        cocktail25.source = @"Cocktail25SourceKey";
        // Cocktail ID: 31
        Cocktail *cocktail28 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail28.name = @"White Russian";
        cocktail28.instructions = @"Cocktail28InstructionsKey";
        cocktail28.ingredients = @"Cocktail28IngredientsKey";
        cocktail28.components = @"Cocktail28ComponentsKey";
        cocktail28.difficulty = @"advanced";
        cocktail28.prepTime = @"2";
        cocktail28.alcLevel = @"25.2";
        cocktail28.calKcal = @"195";
        cocktail28.volCl = @"15";
        cocktail28.glassName = @"Cocktailschale";
        cocktail28.glassPhotoUrl = @"cocktail.png";
        cocktail28.photoUrl = @"white-russian.jpg";
        cocktail28.tags = @"big lebowsky, lebowski, dude, lebovsky";
        cocktail28.source = @"Cocktail28SourceKey";
        // Cocktail ID: 45
        Cocktail *cocktail62 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail62.name = @"Young, Fresh and Beautiful";
        cocktail62.instructions = @"Cocktail62InstructionsKey";
        cocktail62.ingredients = @"Cocktail62IngredientsKey";
        cocktail62.components = @"Cocktail62ComponentsKey";
        cocktail62.difficulty = @"beginner";
        cocktail62.prepTime = @"2";
        cocktail62.alcLevel = @"4.7";
        cocktail62.calKcal = @"163";
        cocktail62.volCl = @"26";
        cocktail62.glassName = @"Hurricaneglas";
        cocktail62.glassPhotoUrl = @"hurricane.png";
        cocktail62.photoUrl = @"young_fresh_beautiful.jpg";
        cocktail62.tags = @"lecker, leicht, CarosLiebling, alkoholisch";
        cocktail62.source = @"Cocktail62SourceKey";
        // Cocktail ID: 33
        Cocktail *cocktail41 = [NSEntityDescription insertNewObjectForEntityForName:@"Cocktail" inManagedObjectContext:self.managedObjectContext];
        cocktail41.name = @"Zombie";
        cocktail41.instructions = @"Cocktail41InstructionsKey";
        cocktail41.ingredients = @"Cocktail41IngredientsKey";
        cocktail41.components = @"Cocktail41ComponentsKey";
        cocktail41.difficulty = @"advanced";
        cocktail41.prepTime = @"3";
        cocktail41.alcLevel = @"21.6";
        cocktail41.calKcal = @"336";
        cocktail41.volCl = @"26";
        cocktail41.glassName = @"Longdrinkglas";
        cocktail41.glassPhotoUrl = @"longdrink.png";
        cocktail41.photoUrl = @"30.jpg";
        cocktail41.tags = @"stark, fruchtig, Klassiker, man merkt nicht dass so viel alk drin ist, sehr stark";
        cocktail41.source = @"Cocktail41SourceKey";
        
        [self saveContext];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    UIViewController *viewController1;
    UIViewController *viewController2;
    UIViewController *ingredientsViewController;
    UIViewController *shoppingViewController;
    UIViewController *quizViewController;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        UITableViewController *viewController1a  = [[CocktailTableViewController alloc] initWithNibName:@"CocktailTableViewController_iPhone" bundle:nil];
        viewController1 = [[UINavigationController alloc] initWithRootViewController:viewController1a];
        ((UINavigationController *)viewController1).navigationBar.tintColor = [UIColor colorWithRed:0.812 green:0.0 blue:0.376 alpha:1];
        
        UIViewController *viewController2a = [[RandomCocktailViewController alloc] initWithNibName:@"RandomCocktailViewController_iPhone" bundle:nil];
        viewController2 = [[UINavigationController alloc] initWithRootViewController:viewController2a];
        ((UINavigationController *)viewController2).navigationBar.tintColor = [UIColor colorWithRed:0.812 green:0.0 blue:0.376 alpha:1];
        
        UIViewController *innerIngredientsViewController = [[IngredientTableViewController alloc] initWithNibName:@"IngredientTableViewController_iPhone" bundle:nil];
        ingredientsViewController = [[UINavigationController alloc] initWithRootViewController:innerIngredientsViewController];
        ((UINavigationController *)ingredientsViewController).navigationBar.tintColor = [UIColor colorWithRed:0.812 green:0.0 blue:0.376 alpha:1];
        
        UIViewController *innerShoppingViewController = [[ShoppingTableViewController alloc] initWithNibName:@"ShoppingTableViewController_iPhone" bundle:nil];
        shoppingViewController = [[UINavigationController alloc] initWithRootViewController:innerShoppingViewController];
        ((UINavigationController *)shoppingViewController).navigationBar.tintColor = [UIColor colorWithRed:0.812 green:0.0 blue:0.376 alpha:1];
        
        UIViewController *innerQuizViewController = [[QuizViewController alloc] initWithNibName:@"QuizViewController_iPhone" bundle:nil];
        quizViewController = [[UINavigationController alloc] initWithRootViewController:innerQuizViewController];
        ((UINavigationController *)quizViewController).navigationBar.tintColor = [UIColor colorWithRed:0.812 green:0.0 blue:0.376 alpha:1];
        
    } else {
        
        // master view
        UITableViewController *cocktailTableViewController  = [[CocktailTableViewController alloc] initWithNibName:@"CocktailTableViewController_iPad" bundle:nil];
        UINavigationController *cocktailTableNavigationViewController = [[UINavigationController alloc] initWithRootViewController:cocktailTableViewController];
        cocktailTableNavigationViewController.navigationBar.tintColor = [UIColor colorWithRed:0.812 green:0.0 blue:0.376 alpha:1];
        
        // detail view
        CocktailDetailViewController *cocktailDetailViewController = [[CocktailDetailViewController alloc] initWithNibName:@"CocktailDetailCell_iPad" bundle:nil];
        UINavigationController *cocktailDetailNavigationViewController = [[UINavigationController alloc] initWithRootViewController:cocktailDetailViewController];
        cocktailDetailNavigationViewController.navigationBar.tintColor = [UIColor colorWithRed:0.812 green:0.0 blue:0.376 alpha:1];
        ((CocktailTableViewController *)cocktailTableViewController).detailView = cocktailDetailViewController;
        
        // split view
        viewController1 = [[UISplitViewController alloc] init];
        ((UISplitViewController *)viewController1).viewControllers = [NSArray arrayWithObjects: cocktailTableNavigationViewController, cocktailDetailNavigationViewController, nil];
        
        UIViewController *viewController2a = [[RandomCocktailViewController alloc] initWithNibName:@"RandomCocktailViewController_iPad" bundle:nil];
        viewController2 = [[UINavigationController alloc] initWithRootViewController:viewController2a];
        ((UINavigationController *)viewController2).navigationBar.tintColor = [UIColor colorWithRed:0.812 green:0.0 blue:0.376 alpha:1];
        
        UIViewController *innerIngredientsViewController = [[IngredientTableViewController alloc] initWithNibName:@"IngredientTableViewController_iPad" bundle:nil];
        ingredientsViewController = [[UINavigationController alloc] initWithRootViewController:innerIngredientsViewController];
        ((UINavigationController *)ingredientsViewController).navigationBar.tintColor = [UIColor colorWithRed:0.812 green:0.0 blue:0.376 alpha:1];
        
        UIViewController *innerShoppingViewController = [[ShoppingTableViewController alloc] initWithNibName:@"ShoppingTableViewController_iPad" bundle:nil];
        shoppingViewController = [[UINavigationController alloc] initWithRootViewController:innerShoppingViewController];
        ((UINavigationController *)shoppingViewController).navigationBar.tintColor = [UIColor colorWithRed:0.812 green:0.0 blue:0.376 alpha:1];
        
        UIViewController *innerQuizViewController = [[QuizViewController alloc] initWithNibName:@"QuizViewController_iPad" bundle:nil];
        quizViewController = [[UINavigationController alloc] initWithRootViewController:innerQuizViewController];
        ((UINavigationController *)quizViewController).navigationBar.tintColor = [UIColor colorWithRed:0.812 green:0.0 blue:0.376 alpha:1];
        
    }
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, ingredientsViewController, shoppingViewController, quizViewController, nil];
    
    // set tint color for new devices >= ios5
    if ([[UIBarButtonItem class] respondsToSelector:@selector(appearance)]){
        [[UIBarButtonItem appearance] setTintColor:[UIColor grayColor]];
    }
    
    // add shake support
    application.applicationSupportsShakeToEdit = YES;
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self saveContext];
}

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
 {
 }
 */

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
 {
 }
 */

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]){
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"cocktaildb" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"cocktaildb.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end

