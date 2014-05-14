//
//  SecondViewController.m
//  cocktail
//
//  Created by Thomas Bachmann on 14.09.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RandomCocktailViewController.h"
#import "CocktailDetailViewController.h"
#import "AppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>

@interface RandomCocktailViewController ()

@end

@implementation RandomCocktailViewController

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize cocktail = _cocktail;

- (NSFetchedResultsController *) fetchedResultsController{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    if(_fetchedResultsController){
        return _fetchedResultsController;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Cocktail" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescription = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescription, nil];
    [fetchRequest setSortDescriptors: sortDescriptors];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:appDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:@"Cocktail"];
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Random Cocktail", @"Random Cocktail");
        self.tabBarItem.image = [UIImage imageNamed:@"tab_shaker_small_white"];
        
        UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        navLabel.backgroundColor = [UIColor clearColor];
        navLabel.textColor = [UIColor whiteColor];
        navLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        navLabel.font = [UIFont fontWithName:@"TeenLight-Regular" size:26];
        navLabel.textAlignment = UITextAlignmentCenter;
        navLabel.text = NSLocalizedString(@"Random Cocktails", @"Random Cocktails");
        self.navigationItem.titleView = navLabel;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // load all cocktails
    NSError *error;
    if(![self.fetchedResultsController performFetch:&error]){
        NSLog(@"Could not retrieve cocktails from databases");
    }
    // show navigation bar
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark shaking
-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    int count = [[self.fetchedResultsController fetchedObjects] count];
    int randomIndex = arc4random() % count;
    NSIndexPath *path = [NSIndexPath indexPathForRow:randomIndex inSection:0];
    self.cocktail = [self.fetchedResultsController objectAtIndexPath: path];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake){
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"shaker" ofType:@"wav"];
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
        AudioServicesPlaySystemSound (soundID);
        
        CocktailDetailViewController *detailViewController;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            detailViewController = [[CocktailDetailViewController alloc] initWithNibName:@"CocktailDetailCell_iPhone" bundle:nil];
        } else {
            detailViewController = [[CocktailDetailViewController alloc] initWithNibName:@"CocktailDetailCell_iPad" bundle:nil];
        }
        detailViewController.cocktail = self.cocktail;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

@end
