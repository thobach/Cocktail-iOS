//
//  CocktailDetailViewController.h
//  cocktail
//
//  Created by Thomas Bachmann on 14.09.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cocktail.h"

@interface CocktailDetailViewController : UIViewController<NSFetchedResultsControllerDelegate, UIScrollViewDelegate, UINavigationBarDelegate, UINavigationControllerDelegate>
@property(nonatomic, assign) Cocktail *cocktail;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsControllerIngredients;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsControllerCocktails;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsControllerCocktailsAll;

-(IBAction) shopButtonClicked: (id) sender;

@end
