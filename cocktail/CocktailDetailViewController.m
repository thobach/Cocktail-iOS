//
//  CocktailDetailViewController.m
//  cocktail
//
//  Created by Thomas Bachmann on 14.09.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CocktailDetailViewController.h"
#import "AppDelegate.h"
#import "Ingredient.h"

@interface CocktailDetailViewController ()

@end

@implementation CocktailDetailViewController

@synthesize cocktail = _cocktail;
@synthesize fetchedResultsControllerIngredients = _fetchedResultsControllerIngredients;
@synthesize fetchedResultsControllerCocktails = _fetchedResultsControllerCocktails;
@synthesize fetchedResultsControllerCocktailsAll = _fetchedResultsControllerCocktailsAll;

- (NSFetchedResultsController *) fetchedResultsControllerIngredients{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    if(_fetchedResultsControllerIngredients){
        return _fetchedResultsControllerIngredients;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Ingredient" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescription = [[NSSortDescriptor alloc] initWithKey:NSLocalizedString(@"sortIngredientKey",nil) ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescription, nil];
    [fetchRequest setSortDescriptors: sortDescriptors];
    
    _fetchedResultsControllerIngredients = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:appDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:@"Ingredient"];
    
    _fetchedResultsControllerIngredients.delegate = self;
    
    return _fetchedResultsControllerIngredients;
}

- (NSFetchedResultsController *) fetchedResultsControllerCocktails{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    if(_fetchedResultsControllerCocktails){
        return _fetchedResultsControllerCocktails;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Cocktail" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"desired == \"1\""];
    [fetchRequest setPredicate:searchPredicate];
    
    NSSortDescriptor *sortDescription = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescription, nil];
    [fetchRequest setSortDescriptors: sortDescriptors];
    
    _fetchedResultsControllerCocktails = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:appDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    _fetchedResultsControllerCocktails.delegate = self;
    
    return _fetchedResultsControllerCocktails;
}

- (NSFetchedResultsController *) fetchedResultsControllerCocktailsAll{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    if(_fetchedResultsControllerCocktailsAll){
        return _fetchedResultsControllerCocktailsAll;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Cocktail" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescription = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescription, nil];
    [fetchRequest setSortDescriptors: sortDescriptors];
    
    _fetchedResultsControllerCocktailsAll = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:appDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    _fetchedResultsControllerCocktailsAll.delegate = self;
    
    return _fetchedResultsControllerCocktailsAll;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // ingredients label
        UILabel *label = (UILabel *)[self.view viewWithTag:2];
        label.text = NSLocalizedString(@"IngredientsKey",nil);
        
        // instructions label
        label = (UILabel *)[self.view viewWithTag:4];
        label.text = NSLocalizedString(@"InstructionsKey",nil);
        
        // source label
        label = (UILabel *)[self.view viewWithTag:26];
        label.text = NSLocalizedString(@"SourceKey",nil);
        
        // alcohol level label
        label = (UILabel *)[self.view viewWithTag:7];
        label.text = NSLocalizedString(@"AlcoholLevelKey",nil);
        
        // calories label
        label = (UILabel *)[self.view viewWithTag:9];
        label.text = NSLocalizedString(@"CaloriesKey",nil);
        
        // glass label
        label = (UILabel *)[self.view viewWithTag:13];
        label.text = NSLocalizedString(@"GlassKey",nil);
        
        // volume label
        label = (UILabel *)[self.view viewWithTag:15];
        label.text = NSLocalizedString(@"VolumeKey",nil);
        
        // difficulty label
        label = (UILabel *)[self.view viewWithTag:19];
        label.text = NSLocalizedString(@"DifficultyKey",nil);
        
        // prep time label
        label = (UILabel *)[self.view viewWithTag:21];
        label.text = NSLocalizedString(@"PrepTimeKey",nil);
        
        
    }
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(updateShopButton) name:@"ShoppingListCleared" object:nil];
    
    return self;
}

-(void)updateShopButton
{
    UIButton *button = (UIButton *) [self.view viewWithTag:28];
    if([self.cocktail.desired intValue] == 1){
        button.titleLabel.text = NSLocalizedString(@"RemoveFromShoppingListKey",nil);
        [button setTitle:NSLocalizedString(@"RemoveFromShoppingListKey",nil) forState:UIControlStateNormal];
    } else {
        [button setTitle:NSLocalizedString(@"AddToShoppingListKey",nil) forState:UIControlStateNormal];
    }
}

-(void) favorite
{
    self.cocktail.favorite = [NSNumber numberWithInt:1];
    // persist changes
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    [appDelegate saveContext];
    // update favorite list
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter postNotificationName:@"FavoriteUpdated" object:nil];
}

-(IBAction)shopButtonClicked:(id)sender
{
    // unshop
    if([self.cocktail.desired intValue] == 1){
        
        // set cocktail itself as not desired
        self.cocktail.desired = nil;
        // persist changes
        AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
        [appDelegate saveContext];
        // reload data
        NSError *error;
        if(![self.fetchedResultsControllerCocktails performFetch:&error]){
            NSLog(@"Could not retrieve desired cocktails from databases");
        }
        
        // mark all ingredients as not needed (if not needed by any other desired cocktail)
        for(NSString *potentialNotNeededIngredientName in [NSLocalizedString(self.cocktail.ingredients,nil) componentsSeparatedByString:@", "]){
            // find ingredient object of that ingredient name
            for(Ingredient *potentialNotNeededIngredient in [[self fetchedResultsControllerIngredients] fetchedObjects]){
                if([NSLocalizedString(potentialNotNeededIngredient.name,nil) isEqualToString:potentialNotNeededIngredientName]){
                    // check if other desired cocktails needs that ingredient
                    bool needed = false;
                    for(Cocktail *desiredCocktail in [[self fetchedResultsControllerCocktails] fetchedObjects]){
                        // iterate through all ingredients of the desired cocktails
                        for(NSString *neededIngredientName in [NSLocalizedString(desiredCocktail.ingredients,nil) componentsSeparatedByString:@", "]){
                            for(Ingredient *potentialNotNeededIngredient2 in [[self fetchedResultsControllerIngredients] fetchedObjects]){
                                if([NSLocalizedString(potentialNotNeededIngredient2.name,nil) isEqualToString:neededIngredientName]){
                                    if([potentialNotNeededIngredient2.needed intValue] == 1 && [potentialNotNeededIngredient2.name isEqualToString:potentialNotNeededIngredient.name]){
                                        needed = true;
                                    }
                                }
                            }
                        }
                    }
                    if(!needed){
                        potentialNotNeededIngredient.needed = nil;
                    }
                }
            }
        }
    }
    // shop
    else {
        // set cocktail itself as desired
        self.cocktail.desired = [NSNumber numberWithInt:1];
        
        // mark all ingredients as needed
        for(NSString *namePart in [NSLocalizedString(self.cocktail.ingredients,nil) componentsSeparatedByString:@", "]){
            for(Ingredient *ingredient in [[self fetchedResultsControllerIngredients] fetchedObjects]){
                if([NSLocalizedString(ingredient.name,nil) isEqualToString:namePart]){
                    ingredient.needed = [NSNumber numberWithInt:1];
                }
            }
        }
    }
    
    // update button label
    [self updateShopButton];
    
    // persist changes
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    [appDelegate saveContext];
    
    // update shopping list via notification
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter postNotificationName:@"ShoppingListUpdated" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // load ingredients
    NSError *error;
    if(![self.fetchedResultsControllerIngredients performFetch:&error]){
        NSLog(@"Could not retrieve ingredients from databases");
    }
    
    if(self.cocktail == nil){
        // load cocktails
        NSError *error;
        if(![self.fetchedResultsControllerCocktailsAll performFetch:&error]){
            NSLog(@"Could not retrieve cocktails from databases");
        }
        self.cocktail = [[[self fetchedResultsControllerCocktailsAll] fetchedObjects] objectAtIndex:0];
    }
    
    [((UIScrollView *)self.view)setDelegate:self];
    [((UIScrollView *)self.view)setScrollEnabled:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateShopButton];
    
    // heading
    UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    navLabel.backgroundColor = [UIColor clearColor];
    navLabel.textColor = [UIColor whiteColor];
    navLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    if(self.cocktail.name.length < 10){
        navLabel.font = [UIFont fontWithName:@"TeenLight-Regular" size:26];
    } else if(self.cocktail.name.length < 12) {
        navLabel.font = [UIFont fontWithName:@"TeenLight-Regular" size:20];
    } else {
        navLabel.font = [UIFont fontWithName:@"TeenLight-Regular" size:16];
        navLabel.numberOfLines = 2;
    }
    navLabel.textAlignment = UITextAlignmentCenter;
    navLabel.text = self.cocktail.name;
    self.navigationItem.titleView = navLabel;
    
    // photo
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:1];
    imageView.image = [UIImage imageNamed:self.cocktail.photoUrl];
    
    // ingredients
    UILabel *label = (UILabel *)[self.view viewWithTag:3];
    label.text = NSLocalizedString(self.cocktail.components,nil);
    
    // instructions
    label = (UILabel *)[self.view viewWithTag:5];
    label.text = NSLocalizedString(self.cocktail.instructions,nil);
    
    // tags
    label = (UILabel *)[self.view viewWithTag:25];
    label.text = self.cocktail.tags;
    
    // source
    label = (UILabel *)[self.view viewWithTag:27];
    label.text = NSLocalizedString(self.cocktail.source,nil);
    
    // calories
    label = (UILabel *)[self.view viewWithTag:10];
    label.text = [NSString stringWithFormat:@"%@ kcal", self.cocktail.calKcal];
    
    // prep. time
    label = (UILabel *)[self.view viewWithTag:22];
    label.text = [NSString stringWithFormat:@"%@ min", self.cocktail.prepTime];
    
    // difficulty
    label = (UILabel *)[self.view viewWithTag:20];
    label.text = NSLocalizedString(self.cocktail.difficulty,nil);
    
    // volume
    label = (UILabel *)[self.view viewWithTag:16];
    label.text = [NSString stringWithFormat:@"%@ cl", self.cocktail.volCl];
    
    // alc. level
    label = (UILabel *)[self.view viewWithTag:8];
    label.text = [NSString stringWithFormat:@"%@ %%", self.cocktail.alcLevel];
    
    // glass name
    label = (UILabel *)[self.view viewWithTag:14];
    label.text = NSLocalizedString(self.cocktail.glassName,nil);
    
    // glass image
    imageView = (UIImageView *) [self.view viewWithTag:12];
    imageView.image = [UIImage imageNamed:self.cocktail.glassPhotoUrl];
    
    // difficulty image
    imageView = (UIImageView *) [self.view viewWithTag:18];
    if([self.cocktail.difficulty isEqual: @"beginner"]){
        imageView.image = [UIImage imageNamed:@"leicht.png"];
    } else if([self.cocktail.difficulty isEqual: @"advanced"]){
        imageView.image = [UIImage imageNamed:@"mittel.png"];
    } else if([self.cocktail.difficulty isEqual: @"profi"]){
        imageView.image = [UIImage imageNamed:@"professional.png"];
    }
    
    [self autoLayout];
}

-(void)autoLayout
{
    
    int yPosition = 8;
    
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    
    CGSize maximumLabelSize;
    if(UIInterfaceOrientationIsLandscape(deviceOrientation)){
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            maximumLabelSize = CGSizeMake(440,9999);
        } else {
            maximumLabelSize = CGSizeMake(600,9999);
        }
    } else {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            maximumLabelSize = CGSizeMake(280,9999);
        } else {
            maximumLabelSize = CGSizeMake(353,9999);
        }
    }
    
    // photo
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:1];
    CGRect newFrame = imageView.frame;
    newFrame.origin.y = yPosition;
    int imageHeight = newFrame.size.height;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        yPosition += imageHeight;
    }
    
    // ingredientsLabel
    UILabel *label = (UILabel *)[self.view viewWithTag:2];
    CGSize expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
    newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.y = yPosition + 15;
    label.frame = newFrame;
    int ingredientLabelHeight = expectedLabelSize.height;
    yPosition += ingredientLabelHeight + 15;
    
    // ingredients
    label = (UILabel *)[self.view viewWithTag:3];
    expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
    newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.y = yPosition + 5;
    label.frame = newFrame;
    int ingredientHeight = expectedLabelSize.height;
    yPosition += ingredientHeight + 5;
    
    // instructionsLabel
    label = (UILabel *)[self.view viewWithTag:4];
    expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
    newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.y = yPosition + 15;
    label.frame = newFrame;
    int instructionsLabelHeight = expectedLabelSize.height;
    yPosition += instructionsLabelHeight + 15;
    
    // instructions
    label = (UILabel *)[self.view viewWithTag:5];
    expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
    newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.y = yPosition + 5;
    label.frame = newFrame;
    int instructionsHeight = expectedLabelSize.height;
    yPosition += instructionsHeight + 5;
    
    if(self.cocktail.tags.length != 0){
        // tagsLabel
        label = (UILabel *)[self.view viewWithTag:24];
        label.hidden = FALSE;
        expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
        newFrame = label.frame;
        newFrame.size.height = expectedLabelSize.height;
        newFrame.origin.y = yPosition + 15;
        label.frame = newFrame;
        int tagsLabelHeight = expectedLabelSize.height;
        yPosition += tagsLabelHeight + 15;
        
        // tags
        label = (UILabel *)[self.view viewWithTag:25];
        label.hidden = FALSE;
        expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
        newFrame = label.frame;
        newFrame.size.height = expectedLabelSize.height;
        newFrame.origin.y = yPosition + 5;
        label.frame = newFrame;
        int tagsHeight = expectedLabelSize.height;
        yPosition += tagsHeight + 5;
    } else {
        // tagsLabel
        label = (UILabel *)[self.view viewWithTag:24];
        label.hidden = TRUE;
        
        // tags
        label = (UILabel *)[self.view viewWithTag:25];
        label.hidden = TRUE;
    }
    
    if(NSLocalizedString(self.cocktail.source,nil).length != 0){
        // sourceLabel
        label = (UILabel *)[self.view viewWithTag:26];
        label.hidden = FALSE;
        expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
        newFrame = label.frame;
        newFrame.size.height = expectedLabelSize.height;
        newFrame.origin.y = yPosition + 15;
        label.frame = newFrame;
        int sourceLabelHeight = expectedLabelSize.height;
        yPosition += sourceLabelHeight + 15;
        
        // source
        label = (UILabel *)[self.view viewWithTag:27];
        label.hidden = FALSE;
        expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
        newFrame = label.frame;
        newFrame.size.height = expectedLabelSize.height;
        newFrame.origin.y = yPosition + 5;
        label.frame = newFrame;
        int sourceHeight = expectedLabelSize.height;
        yPosition += sourceHeight + 5;
    } else {
        // sourceLabel
        label = (UILabel *)[self.view viewWithTag:26];
        label.hidden = TRUE;
        
        // source
        label = (UILabel *)[self.view viewWithTag:27];
        label.hidden = TRUE;
    }
    
    int firstRowDetails = yPosition + 5;
    
    // icon: alcohol level
    imageView = (UIImageView *)[self.view viewWithTag:6];
    newFrame = imageView.frame;
    newFrame.origin.y = firstRowDetails + 20;
    imageView.frame = newFrame;
    int iconAlcLevelHeight = newFrame.size.height;
    yPosition += iconAlcLevelHeight + 20;
    
    // heading: alcohol level
    label = (UILabel *)[self.view viewWithTag:7];
    expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
    newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.y = firstRowDetails + 20;
    label.frame = newFrame;
    int headingAlcLevelHeight = expectedLabelSize.height;
    
    // value: alcohol level
    label = (UILabel *)[self.view viewWithTag:8];
    expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
    newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.y = firstRowDetails + 20 + headingAlcLevelHeight;
    label.frame = newFrame;
    
    // icon: calories
    imageView = (UIImageView *)[self.view viewWithTag:11];
    newFrame = imageView.frame;
    newFrame.origin.y = firstRowDetails + 20;
    imageView.frame = newFrame;
    int iconCaloriesHeight = newFrame.size.height;
    yPosition = firstRowDetails + iconCaloriesHeight + 20;
    
    // heading: calories
    label = (UILabel *)[self.view viewWithTag:9];
    expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
    newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.y = firstRowDetails + 20;
    label.frame = newFrame;
    int headingCaloriesHeight = expectedLabelSize.height;
    
    // value: calories
    label = (UILabel *)[self.view viewWithTag:10];
    expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
    newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.y = firstRowDetails + 20 + headingCaloriesHeight;
    label.frame = newFrame;
    int secondRowDetails = yPosition;
    
    // icon: glass
    imageView = (UIImageView *)[self.view viewWithTag:12];
    newFrame = imageView.frame;
    newFrame.origin.y = secondRowDetails + 20;
    imageView.frame = newFrame;
    int iconGlassHeight = newFrame.size.height;
    yPosition = secondRowDetails + iconGlassHeight + 20;
    
    // heading: glass
    label = (UILabel *)[self.view viewWithTag:13];
    expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
    newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.y = secondRowDetails + 20;
    label.frame = newFrame;
    int headingGlassHeight = expectedLabelSize.height;
    
    // value: glass
    label = (UILabel *)[self.view viewWithTag:14];
    expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
    newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.y = secondRowDetails + 20 + headingGlassHeight;
    label.frame = newFrame;
    
    // icon: volume
    imageView = (UIImageView *)[self.view viewWithTag:17];
    newFrame = imageView.frame;
    newFrame.origin.y = secondRowDetails + 20;
    imageView.frame = newFrame;
    int iconVolumeHeight = newFrame.size.height;
    yPosition = secondRowDetails + iconVolumeHeight + 20;
    
    // heading: volume
    label = (UILabel *)[self.view viewWithTag:15];
    expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
    newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.y = secondRowDetails + 20;
    label.frame = newFrame;
    int headingVolumeHeight = expectedLabelSize.height;
    
    // value: volume
    label = (UILabel *)[self.view viewWithTag:16];
    expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
    newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.y = secondRowDetails + 20 + headingVolumeHeight;
    label.frame = newFrame;
    int thirdRowDetails = yPosition;
    
    // icon: difficulty level
    imageView = (UIImageView *)[self.view viewWithTag:18];
    newFrame = imageView.frame;
    newFrame.origin.y = thirdRowDetails + 20;
    imageView.frame = newFrame;
    int iconDiffucultyHeight = newFrame.size.height;
    yPosition = thirdRowDetails + iconDiffucultyHeight + 20;
    
    // heading: difficulty level
    label = (UILabel *)[self.view viewWithTag:19];
    expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
    newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.y = thirdRowDetails + 20;
    label.frame = newFrame;
    int headingDiffucultyHeight = expectedLabelSize.height;
    
    // value: difficulty level
    label = (UILabel *)[self.view viewWithTag:20];
    expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
    newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.y = thirdRowDetails + 20 + headingDiffucultyHeight;
    label.frame = newFrame;
    
    // icon: preparation time
    imageView = (UIImageView *)[self.view viewWithTag:23];
    newFrame = imageView.frame;
    newFrame.origin.y = thirdRowDetails + 20;
    imageView.frame = newFrame;
    int iconPrepTimeHeight = newFrame.size.height;
    yPosition = thirdRowDetails + iconPrepTimeHeight + 20;
    
    // heading: preparation time
    label = (UILabel *)[self.view viewWithTag:21];
    expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
    newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.y = thirdRowDetails + 20;
    label.frame = newFrame;
    int headingPrepTimeHeight = expectedLabelSize.height;
    
    // value: preparation time
    label = (UILabel *)[self.view viewWithTag:22];
    expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
    newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.y = thirdRowDetails + 20 + headingPrepTimeHeight;
    label.frame = newFrame;
    
    // setup scroll view container
    if(UIInterfaceOrientationIsLandscape(deviceOrientation)){
        ((UIScrollView *)self.view).contentSize = CGSizeMake(460, yPosition + 20);
    } else {
        ((UIScrollView *)self.view).contentSize = CGSizeMake(320, yPosition + 20);
    }
    
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self autoLayout];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
