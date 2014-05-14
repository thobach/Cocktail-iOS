//
//  ShoppingTableViewController.h
//  cocktail
//
//  Created by Thomas Bachmann on 19.09.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingTableViewController : UITableViewController<NSFetchedResultsControllerDelegate, UITableViewDelegate, UINavigationControllerDelegate>
{
    // The master content.
    NSArray         *listContent;
}

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsControllerCocktail;
@property (nonatomic, assign) IBOutlet UITableViewCell *tvCell;

@end
