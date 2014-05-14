//
//  QuizViewController.h
//  cocktail
//
//  Created by Thomas Bachmann on 20.09.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cocktail.h"

@interface QuizViewController : UIViewController<NSFetchedResultsControllerDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property(nonatomic, assign) Cocktail *cocktail;
@end
