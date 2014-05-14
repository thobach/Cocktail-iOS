//
//  QuizViewController.m
//  cocktail
//
//  Created by Thomas Bachmann on 20.09.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuizViewController.h"
#import "AppDelegate.h"

@interface QuizViewController ()

@end

@implementation QuizViewController
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
        // Custom initialization
        UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        navLabel.backgroundColor = [UIColor clearColor];
        navLabel.textColor = [UIColor whiteColor];
        navLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        navLabel.font = [UIFont fontWithName:@"TeenLight-Regular" size:26];
        navLabel.textAlignment = UITextAlignmentCenter;
        navLabel.text = NSLocalizedString(@"Quiz", @"Quiz");
        self.navigationItem.titleView = navLabel;
        self.title = NSLocalizedString(@"Quiz", @"Quiz");
        
        self.tabBarItem.image = [UIImage imageNamed:@"tab_about_small_white"];
        
        // load all cocktails
        NSError *error;
        if(![self.fetchedResultsController performFetch:&error]){
            NSLog(@"Could not retrieve cocktails from databases");
        }
    }
    return self;
}

-(void)reload
{
    int count = [[self.fetchedResultsController fetchedObjects] count];
    int randomIndex = arc4random() % count;
    NSIndexPath *path = [NSIndexPath indexPathForRow:randomIndex inSection:0];
    self.cocktail = [self.fetchedResultsController objectAtIndexPath: path];
    
    int randomIndexFalse1 = arc4random() % count;
    while(randomIndexFalse1 == randomIndex){
        randomIndexFalse1 = arc4random() % count;
    }
    path = [NSIndexPath indexPathForRow:randomIndexFalse1 inSection:0];
    Cocktail *cocktailFalse1 = [self.fetchedResultsController objectAtIndexPath: path];
    
    int randomIndexFalse2 = arc4random() % count;
    while(randomIndexFalse2 == randomIndex || randomIndexFalse2 == randomIndexFalse1){
        randomIndexFalse2 = arc4random() % count;
    }
    path = [NSIndexPath indexPathForRow:randomIndexFalse2 inSection:0];
    Cocktail *cocktailFalse2 = [self.fetchedResultsController objectAtIndexPath: path];
    
    int solutionPosition = arc4random() % 3;
    int falseAnswerPosition1 = arc4random() % 3;
    while(solutionPosition == falseAnswerPosition1){
        falseAnswerPosition1 = arc4random() % 3;
    }
    int falseAnswerPosition2 = arc4random() % 3;
    while(solutionPosition == falseAnswerPosition2 || falseAnswerPosition1 == falseAnswerPosition2){
        falseAnswerPosition2 = arc4random() % 3;
    }
    
    // ingredients
    UILabel *label = (UILabel *)[self.view viewWithTag:1];
    label.text = NSLocalizedString(self.cocktail.ingredients,nil);
    
    // solution
    UIButton *button = (UIButton *)[self.view viewWithTag:solutionPosition+2];
    [button setTitle:self.cocktail.name forState:UIControlStateNormal];
    // reset target
    [button removeTarget:self action:@selector(solution) forControlEvents:UIControlEventTouchUpInside];
    [button removeTarget:self action:@selector(falseAnswer) forControlEvents:UIControlEventTouchUpInside];
    // add new target
    [button addTarget:self action:@selector(solution) forControlEvents:UIControlEventTouchUpInside];
    
    // false answer 1
    button = (UIButton *)[self.view viewWithTag:falseAnswerPosition1+2];
    [button setTitle:cocktailFalse1.name forState:UIControlStateNormal];
    // reset target
    [button removeTarget:self action:@selector(solution) forControlEvents:UIControlEventTouchUpInside];
    [button removeTarget:self action:@selector(falseAnswer) forControlEvents:UIControlEventTouchUpInside];
    // add new target
    [button addTarget:self action:@selector(falseAnswer) forControlEvents:UIControlEventTouchUpInside];
    
    // false answer 2
    button = (UIButton *)[self.view viewWithTag:falseAnswerPosition2+2];
    [button setTitle:cocktailFalse2.name forState:UIControlStateNormal];
    // reset target
    [button removeTarget:self action:@selector(solution) forControlEvents:UIControlEventTouchUpInside];
    [button removeTarget:self action:@selector(falseAnswer) forControlEvents:UIControlEventTouchUpInside];
    // add new target
    [button addTarget:self action:@selector(falseAnswer) forControlEvents:UIControlEventTouchUpInside];
    
    [self autoLayout];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self reload];
}

-(void)solution
{
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"CorrectKey",nil) message:[NSString stringWithFormat:NSLocalizedString(@"CorrectAnswerKey",nil), self.cocktail.name] delegate: self cancelButtonTitle:NSLocalizedString(@"NextQuestionKey",nil) otherButtonTitles: nil] show];
    NSLog(@"solution clicked");
}

-(void)falseAnswer
{
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"IncorrectKey",nil) message:[NSString stringWithFormat:NSLocalizedString(@"FalseAnswerKey",nil), self.cocktail.name] delegate: self cancelButtonTitle:NSLocalizedString(@"NextQuestionKey",nil) otherButtonTitles: nil] show];
    NSLog(@"false answer clicked");
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self reload];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // question
    UILabel *label = (UILabel *) [self.view viewWithTag:5];
    label.text = NSLocalizedString(@"WhoAmIKey",nil);
    
    // solution
    UIButton *button = (UIButton *)[self.view viewWithTag:2];
    
    
    // false answer 1
    button = (UIButton *)[self.view viewWithTag:3];
    
    
    // false answer 2
    button = (UIButton *)[self.view viewWithTag:4];
    
    
    // Do any additional setup after loading the view from its nib.
    [self reload];
    
    // show navigation bar
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
}

-(void)autoLayout
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        int yPosition = 0;
        int distance = 0;
        
        UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
        
        CGSize maximumLabelSize;
        if(UIInterfaceOrientationIsLandscape(deviceOrientation)){
            maximumLabelSize = CGSizeMake(440,9999);
            yPosition = 2;
            distance = 8;
        } else {
            maximumLabelSize = CGSizeMake(280,9999);
            yPosition = 15;
            distance = 18;
        }
        
        // who am i
        UILabel *label = (UILabel *)[self.view viewWithTag:5];
        CGSize expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
        CGRect newFrame = label.frame;
        newFrame.size.height = expectedLabelSize.height;
        newFrame.origin.y = yPosition + distance;
        label.frame = newFrame;
        int whoAmIHeight = expectedLabelSize.height;
        yPosition += whoAmIHeight + distance;
        
        // ingredients
        label = (UILabel *)[self.view viewWithTag:1];
        expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
        newFrame = label.frame;
        newFrame.size.height = expectedLabelSize.height;
        newFrame.origin.y = yPosition + distance;
        label.frame = newFrame;
        int ingredientsHeight = expectedLabelSize.height;
        yPosition += ingredientsHeight + distance;
        
        // solution 1
        UIButton *button = (UIButton *)[self.view viewWithTag:2];
        newFrame = button.frame;
        newFrame.origin.y = yPosition + distance;
        button.frame = newFrame;
        int solution1Height = newFrame.size.height;
        yPosition += solution1Height + distance;
        
        // solution 2
        button = (UIButton *)[self.view viewWithTag:3];
        newFrame = button.frame;
        newFrame.origin.y = yPosition + distance;
        button.frame = newFrame;
        int solution2Height = newFrame.size.height;
        yPosition += solution2Height + distance;
        
        // solution 2
        button = (UIButton *)[self.view viewWithTag:4];
        newFrame = button.frame;
        newFrame.origin.y = yPosition + distance;
        button.frame = newFrame;
        int solution3Height = newFrame.size.height;
        yPosition += solution3Height + distance;
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self autoLayout];
}

@end
