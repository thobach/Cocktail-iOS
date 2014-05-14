//
//  CocktailTableViewController.m
//  cocktail
//
//  Created by Thomas Bachmann on 14.09.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CocktailTableViewController.h"
#import "CocktailDetailViewController.h"
#import "IngredientTableViewController.h"
#import "AboutViewController.h"
#import "AppDelegate.h"
#import "Cocktail.h"
#import "Ingredient.h"

@interface CocktailTableViewController ()

@end

@implementation CocktailTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize fetchedResultsControllerIngredients = _fetchedResultsControllerIngredients;
@synthesize detailView = _detailView;
@synthesize tvCell = _tvCell;
@synthesize listContent, filteredListContent, savedSearchTerm, searchWasActive;
@synthesize filtered = _filtered;
@synthesize noCocktailsFound = _noCocktailsFound;


- (NSFetchedResultsController *) fetchedResultsController
{
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

- (NSFetchedResultsController *) fetchedResultsControllerIngredients
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    if(_fetchedResultsControllerIngredients){
        return _fetchedResultsControllerIngredients;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Ingredient" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"available == \"1\""];
    [fetchRequest setPredicate:searchPredicate];
    
    NSSortDescriptor *sortDescription = [[NSSortDescriptor alloc] initWithKey:NSLocalizedString(@"sortIngredientKey",nil) ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescription, nil];
    [fetchRequest setSortDescriptors: sortDescriptors];
    
    _fetchedResultsControllerIngredients = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:appDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:@"IngredientAvailable"];
    
    _fetchedResultsControllerIngredients.delegate = self;
    
    return _fetchedResultsControllerIngredients;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        UIButton *button1 = [[UIButton alloc] init];
        button1.frame=CGRectMake(0,0,45,30);
        [button1 setBackgroundImage:[UIImage imageNamed: @"tab_about_small_white.png"] forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(about) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
        
        //UIBarButtonItem *btnFilter = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tab_about_small_white.png"] style:UIBarButtonItemStylePlain target:self action:@selector(about)];
        //self.navigationItem.rightBarButtonItem = btnFilter;
        
        UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        navLabel.backgroundColor = [UIColor clearColor];
        navLabel.textColor = [UIColor whiteColor];
        navLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        navLabel.font = [UIFont fontWithName:@"TeenLight-Regular" size:26];
        navLabel.textAlignment = UITextAlignmentCenter;
        navLabel.text = NSLocalizedString(@"Cocktails", @"Cocktails");
        self.navigationItem.titleView = navLabel;
        self.title = NSLocalizedString(@"Cocktails", @"Cocktails");
        
        self.tabBarItem.image = [UIImage imageNamed:@"tab_cocktails_small_white"];
    }
    return self;
}

-(void)about
{
    AboutViewController *aboutViewController = [[AboutViewController alloc] initWithNibName:@"About_iPhone" bundle:nil];
    [self.navigationController pushViewController:aboutViewController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // show navigation bar
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    // load all cocktails
    NSError *error;
    if(![self.fetchedResultsController performFetch:&error]){
        NSLog(@"Could not retrieve cocktails from databases");
    }
    self.listContent = [self.fetchedResultsController fetchedObjects];
    
    // create a filtered list that will contain products for the search results table.
    self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.listContent count]];
    
    // setup search placeholder
    self.searchDisplayController.searchBar.placeholder = NSLocalizedString(@"CocktailSeachPlaceholderKey", nil);
    
    // restore search settings if they were saved in didReceiveMemoryWarning.
    if (self.savedSearchTerm)
    {
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setText:savedSearchTerm];
        self.savedSearchTerm = nil;
    }
    
    // register observer for filter notification
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(filter) name:@"FilterCocktails" object:nil];
    [defaultCenter addObserver:self selector:@selector(filterUpdated) name:@"FilterUpdated" object:nil];
    
    [self.tableView reloadData];
    self.tableView.scrollEnabled = YES;
}

-(void)filter
{
    // show filter icon
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"filter.png"] style:UIBarButtonItemStylePlain target:self action:@selector(clearFilter)];
    
    self.filtered = true;
    [self.tableView reloadData];
}

-(void)clearFilter
{
    // hide filter icon
    self.navigationItem.rightBarButtonItem = nil;
    
    self.filtered = false;
    [self.tableView reloadData];
}

-(void)filterUpdated
{
    if(self.filtered){
        [self.tableView reloadData];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    self.filteredListContent = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
    // save the state of the search UI so that it can be restored if the view is re-created
    self.searchWasActive = [self.searchDisplayController isActive];
    self.savedSearchTerm = [self.searchDisplayController.searchBar text];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *list;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        list = self.filteredListContent;
    } else {
        list = self.listContent;
    }
    
    if(self.filtered){
        int rows = 0;
        NSError *error;
        if(![self.fetchedResultsControllerIngredients performFetch:&error]){
            NSLog(@"Could not retrieve available ingredients from databases");
        }
        NSArray *availableIngredients = [self.fetchedResultsControllerIngredients fetchedObjects];
        for(Cocktail *cocktail in list){
            bool ingredientsComplete = true;
            for(NSString *namePart in [NSLocalizedString(cocktail.ingredients,nil) componentsSeparatedByString:@", "]){
                bool ingredientFound = false;
                for (Ingredient *ingredient in availableIngredients){
                    NSComparisonResult result = [namePart compare:NSLocalizedString(ingredient.name,nil) options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [NSLocalizedString(ingredient.name,nil) length])];
                    if(result == NSOrderedSame){
                        ingredientFound = true;
                        break;
                    }
                }
                if(!ingredientFound){
                    ingredientsComplete = false;
                    break;
                }
            }
            if(ingredientsComplete){
                rows++;
            }
        }
        if(rows == 0){
            // row that tells that there are no cocktails available
            self.noCocktailsFound = true;
            return 1;
        } else {
            self.noCocktailsFound = false;
            return rows;
        }
    } else {
        self.noCocktailsFound = false;
        return [list count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(self.noCocktailsFound){
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
        cell.textLabel.text = NSLocalizedString(@"NotFoundKey",nil);
        cell.textLabel.numberOfLines = 0;
        return cell;
    } else {
        
        static NSString *CellIdentifier = @"CocktailNameCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            [[NSBundle mainBundle] loadNibNamed:@"CocktailCell_iPhone" owner:self options:nil];
            cell = _tvCell;
            self.tvCell = nil;
        }
        
        // determine which Cocktail should be displayed
        NSArray *list;
        Cocktail *cocktail;
        if (tableView == self.searchDisplayController.searchResultsTableView) {
            list = self.filteredListContent;
            cocktail = [self.filteredListContent objectAtIndex:indexPath.row];
        } else {
            list = self.listContent;
            cocktail = [self.listContent objectAtIndex:indexPath.row];
        }
        
        if(self.filtered){
            int rows = -1;
            NSArray *availableIngredients = [self.fetchedResultsControllerIngredients fetchedObjects];
            for(Cocktail *potentialCocktail in list){
                bool ingredientsComplete = true;
                for(NSString *namePart in [NSLocalizedString(potentialCocktail.ingredients,nil) componentsSeparatedByString:@", "]){
                    bool ingredientFound = false;
                    for (Ingredient *ingredient in availableIngredients){
                        NSComparisonResult result = [namePart compare:NSLocalizedString(ingredient.name,nil) options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [NSLocalizedString(ingredient.name,nil) length])];
                        if(result == NSOrderedSame){
                            ingredientFound = true;
                            break;
                        }
                    }
                    if(!ingredientFound){
                        ingredientsComplete = false;
                        break;
                    }
                }
                if(ingredientsComplete){
                    rows++;
                }
                if(rows == indexPath.row){
                    cocktail = potentialCocktail;
                    break;
                }
            }
        } else {
            cocktail = [list objectAtIndex:indexPath.row];
        }
        
        // Configure the cell...
        UILabel *label = (UILabel *)[cell viewWithTag:3];
        label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:label.font.pointSize];
        label.text = cocktail.name;
        
        label = (UILabel *)[cell viewWithTag:4];
        label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:label.font.pointSize];
        label.text = NSLocalizedString(cocktail.ingredients,nil);
        
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:2];
        imageView.image = [UIImage imageNamed:cocktail.photoUrl];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.noCocktailsFound){
        // jump to house bar if helper text was selected
        self.tabBarController.selectedIndex = 2;
    } else {
        
        CocktailDetailViewController *detailViewController;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            detailViewController = [[CocktailDetailViewController alloc] initWithNibName:@"CocktailDetailCell_iPhone" bundle:nil];
        } else {
            detailViewController = self.detailView;
        }
        
        // determine which Cocktail was clicked
        if (tableView == self.searchDisplayController.searchResultsTableView) {
            detailViewController.cocktail = [self.filteredListContent objectAtIndex:indexPath.row];
        } else {
            if(self.filtered){
                Cocktail *cocktail;
                int rows = -1;
                NSArray *availableIngredients = [self.fetchedResultsControllerIngredients fetchedObjects];
                for(Cocktail *potentialCocktail in self.listContent){
                    bool ingredientsComplete = true;
                    for(NSString *namePart in [NSLocalizedString(potentialCocktail.ingredients,nil) componentsSeparatedByString:@", "]){
                        bool ingredientFound = false;
                        for (Ingredient *ingredient in availableIngredients){
                            NSComparisonResult result = [namePart compare:NSLocalizedString(ingredient.name,nil) options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [NSLocalizedString(ingredient.name,nil) length])];
                            if(result == NSOrderedSame){
                                ingredientFound = true;
                                break;
                            }
                        }
                        if(!ingredientFound){
                            ingredientsComplete = false;
                            break;
                        }
                    }
                    if(ingredientsComplete){
                        rows++;
                    }
                    if(rows == indexPath.row){
                        cocktail = potentialCocktail;
                        break;
                    }
                }
                
                detailViewController.cocktail = cocktail;
            } else {
                detailViewController.cocktail = [self.listContent objectAtIndex:indexPath.row];
            }
        }
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            [self.navigationController pushViewController:detailViewController animated:YES];
        } else {
            [detailViewController viewWillAppear:TRUE];
        }
    }
}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText
{
    /*
     Update the filtered array based on the search text.
     */
    [self.filteredListContent removeAllObjects]; // First clear the filtered array.
    
    /*
     Search the main list for cocktails whose name matches searchText; add items that match to the filtered array.
     */
    for (Cocktail *cocktail in listContent) {
        
        bool matched = false;
        
        // match by whole name
        NSComparisonResult result = [cocktail.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (result == NSOrderedSame) {
            [self.filteredListContent addObject:cocktail];
            matched = true;
        }
        
        // match by each word of the name
        if(!matched){
            for(NSString *namePart in [cocktail.name componentsSeparatedByString:@" "]){
                NSComparisonResult result = [namePart compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
                // search by name
                if (result == NSOrderedSame) {
                    [self.filteredListContent addObject:cocktail];
                    matched = true;
                }
            }
        }
        
        // match by each ingredient
        if(!matched) {
            for(NSString *namePart in [NSLocalizedString(cocktail.ingredients,nil) componentsSeparatedByString:@", "]){
                NSComparisonResult result = [namePart compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
                if(result == NSOrderedSame){
                    [self.filteredListContent addObject:cocktail];
                    matched = true;
                }
            }
        }
        
        // match by each tag
        if(!matched) {
            for(NSString *namePart in [cocktail.tags componentsSeparatedByString:@", "]){
                NSComparisonResult result = [namePart compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
                if(result == NSOrderedSame){
                    [self.filteredListContent addObject:cocktail];
                    matched = true;
                }
            }
        }
    }
}


#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

@end
