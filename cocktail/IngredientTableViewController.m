//
//  IngredientTableViewController.m
//  cocktail
//
//  Created by Thomas Bachmann on 18.09.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IngredientTableViewController.h"
#import "AppDelegate.h"
#import "Ingredient.h"

@interface IngredientTableViewController ()

@end

@implementation IngredientTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize tvCell = _tvCell;
@synthesize listContent, filteredListContent, savedSearchTerm, searchWasActive;

- (NSFetchedResultsController *) fetchedResultsController{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    if(_fetchedResultsController){
        return _fetchedResultsController;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Ingredient" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescription = [[NSSortDescriptor alloc] initWithKey:NSLocalizedString(@"sortIngredientKey",nil) ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescription, nil];
    [fetchRequest setSortDescriptors: sortDescriptors];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:appDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *btnFilter = [[UIBarButtonItem alloc] initWithTitle:@"Filter Cocktails" style:UIBarButtonItemStyleBordered target:self action:@selector(filter)];    
        self.navigationItem.rightBarButtonItem = btnFilter;
        
        UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        navLabel.backgroundColor = [UIColor clearColor];
        navLabel.textColor = [UIColor whiteColor];
        navLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        navLabel.font = [UIFont fontWithName:@"TeenLight-Regular" size:26];
        navLabel.textAlignment = UITextAlignmentCenter;
        navLabel.text = NSLocalizedString(@"House Bar", nil);
        self.navigationItem.titleView = navLabel;
        self.title = NSLocalizedString(@"House Bar", nil);
        
        self.tabBarItem.image = [UIImage imageNamed:@"tab_housebar_small_white"];
    }
    return self;
}

-(void)filter
{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter postNotificationName:@"FilterCocktails" object:nil];
    self.tabBarController.selectedIndex = 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // show navigation bar
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    // load all ingredients
    NSError *error;
    if(![self.fetchedResultsController performFetch:&error]){
        NSLog(@"Could not retrieve ingredients from databases");
    }
    self.listContent = [self.fetchedResultsController fetchedObjects];
    
    // create a filtered list that will contain products for the search results table.
    self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.listContent count]];
    
    // setup search placeholder
    self.searchDisplayController.searchBar.placeholder = NSLocalizedString(@"HouseBarSeachPlaceholderKey", nil);
    
    // restore search settings if they were saved in didReceiveMemoryWarning.
    if (self.savedSearchTerm)
    {
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setText:savedSearchTerm];
        self.savedSearchTerm = nil;
    }
    
    // get notifications on updated house bar
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(updated) name:@"HouseBarUpdated" object:nil];
    
    [self.tableView reloadData];
    self.tableView.scrollEnabled = YES;
}

-(void)updated
{
    [self.tableView reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == self.searchDisplayController.searchResultsTableView){
        return 1;   
    } else {
        return [[Ingredient getSections] count];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section    
{
    if(tableView == self.searchDisplayController.searchResultsTableView){
        return nil;
    } else {
        CGRect headerViewRect = CGRectMake(0.0,0.0,320,24);
        UIView* headerView = [[UIView alloc] initWithFrame:headerViewRect];
        headerView.backgroundColor = [UIColor darkGrayColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0,  5.0, 280 , 14)];
        label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
        label.text = NSLocalizedString([[Ingredient getSections] objectAtIndex:section],nil);
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        [headerView addSubview:label];
        return headerView;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView == self.searchDisplayController.searchResultsTableView){
        return 0;
    } else {
        return 24;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredListContent count];
    } else {
        int count = 0;
        for(Ingredient *ingredient in self.listContent){
            if([ingredient.category isEqualToString:[[Ingredient getSections] objectAtIndex: section]]){
                count++;
            }
        }
        return count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"IngredientNameCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"IngredientCell_iPhone" owner:self options:nil];
        cell = _tvCell;
        self.tvCell = nil;
    }
    
    // determine which Ingredient should be displayed
    Ingredient *ingredient;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        ingredient = [self.filteredListContent objectAtIndex: indexPath.row];
    } else {
        int sectionCount = -1;
        for(Ingredient *potentialIngredient in self.listContent){
            if([potentialIngredient.category isEqualToString: [[Ingredient getSections] objectAtIndex: indexPath.section]]){
                sectionCount++;
            }
            if(sectionCount == indexPath.row){
                ingredient = potentialIngredient;
                break;
            }
        }
    }
    
    // Configure the cell...
    UILabel *label = (UILabel *)[cell viewWithTag:1];
    label.text = NSLocalizedString(ingredient.name,nil);
    
    label = (UILabel *)[cell viewWithTag:2];
    label.text = NSLocalizedString(ingredient.products,nil);
    
    if([ingredient.available intValue] == 1){
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone]; 
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *list;
    NSArray *otherList;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        list = self.filteredListContent;
        otherList = self.listContent;
    } else {
        list = self.listContent;
        otherList = self.filteredListContent;
    }
    
    NSUInteger index = [[tableView indexPathsForVisibleRows] indexOfObject:indexPath];
    if (index != NSNotFound) {
        
        // mark ingredient as (un)available in currently displayed list
        Ingredient *ingredient;
        int rowCount = -1;
        for(Ingredient *potentialIngredient in list){
            // search table view contains no sections
            if (tableView == self.searchDisplayController.searchResultsTableView) {
                rowCount++;
            } else {
                if([potentialIngredient.category isEqualToString:[[Ingredient getSections] objectAtIndex: indexPath.section]]){
                    rowCount++;
                }
            }
            if(rowCount == indexPath.row){
                ingredient = potentialIngredient;
                break;
            }
        }
        NSNumber *newAvailability;
        if([ingredient.available intValue] == 1){
            newAvailability = ingredient.available = [NSNumber numberWithInt:0];
        } else {
            newAvailability = ingredient.available = [NSNumber numberWithInt:1];
        }
        
        // mark ingredient as (un)available in other non-displayed list
        for(Ingredient *potentialIngredient in otherList){
            if([ingredient.name isEqualToString: potentialIngredient.name]){
                potentialIngredient.available = newAvailability;
                break;
            }
        }
        
        // persist changes
        AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
        [appDelegate saveContext];
        
        // update cocktail list
        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter postNotificationName:@"FilterUpdated" object:nil];
        
        [tableView reloadData];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.tableView reloadData];
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
     Search the main list for ingredients whose name matches searchText; add items that match to the filtered array.
     */
    for (Ingredient *ingredient in listContent) {
        // match by whole name
        NSComparisonResult result = [NSLocalizedString(ingredient.name,nil) compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (result == NSOrderedSame) {
            [self.filteredListContent addObject:ingredient];
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
