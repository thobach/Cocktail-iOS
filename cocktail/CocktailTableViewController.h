//
//  CocktailTableViewController.h
//  cocktail
//
//  Created by Thomas Bachmann on 14.09.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CocktailDetailViewController.h"

@interface CocktailTableViewController : UITableViewController<NSFetchedResultsControllerDelegate, UITableViewDelegate, UINavigationControllerDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
{
    // The master content.
    NSArray         *listContent;           
    // The content filtered as a result of a search.
    NSMutableArray  *filteredListContent;   
    
    // The saved state of the search UI if a memory warning removed the view.
    NSString        *savedSearchTerm;
    BOOL            searchWasActive;
}

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsControllerIngredients;
@property (nonatomic, assign) IBOutlet UITableViewCell *tvCell;
@property (nonatomic, retain) CocktailDetailViewController *detailView;

@property (nonatomic, retain) NSArray *listContent;
@property (nonatomic, retain) NSMutableArray *filteredListContent;

@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) BOOL searchWasActive;
@property (nonatomic) BOOL filtered;
@property (nonatomic) BOOL noCocktailsFound;

@end
