//
//  SearchView.m
//  iOS-git-osc
//
//  Created by chenhaoxiang on 14-8-21.
//  Copyright (c) 2014年 chenhaoxiang. All rights reserved.
//

#import "SearchView.h"
#import "ProjectsTableController.h"
#import "ProjectCell.h"
#import "GLGitlab.h"
#import "Tools.h"
#import "ProjectDetailsView.h"
#import "PKRevealController.h"
#import "LastCell.h"

@interface SearchView ()

@end

static NSString * const SearchResultsCellID = @"SearchResultsCell";
static NSString * const LastCellID = @"LastCell";


@implementation SearchView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"项目搜索";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"three_lines"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(showMenu)];
    
    _projects = [NSMutableArray new];
    _searchBar.delegate = self;
    
    [self initSubviews];
    [self setAutoLayout];
    
    //适配iOS7uinavigationbar遮挡tableView的问题
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)showMenu
{
    [_searchBar resignFirstResponder];
    
    [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.revealController.frontViewController.revealController.recognizesPanningOnFrontView = YES;
}

- (void)viewDidUnload
{
    _resultsTableController = nil;
    _searchBar = nil;
    _results = nil;
    [super viewDidUnload];
}

#pragma 搜索

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (_searchBar.text.length == 0) {return;}
    
    [searchBar resignFirstResponder];
    [self doSearch];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}

-(void)doSearch
{
    _resultsTableController.query = _searchBar.text;
    [_resultsTableController reload];
}

- (void)initSubviews
{
    _searchBar = [UISearchBar new];
    _searchBar.placeholder = @"搜索项目";
    _searchBar.showsCancelButton = YES;
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
    [_searchBar becomeFirstResponder];
    
    _resultsTableController = [[ProjectsTableController alloc] initWithProjectsType:7];
    [self addChildViewController:_resultsTableController];
    _results = _resultsTableController.tableView;
    [self.view addSubview:_results];
}

- (void)setAutoLayout
{
    for (UIView *view in [self.view subviews]) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_searchBar]-[_results]|"
                                                                      options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_searchBar, _results)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_searchBar]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_searchBar)]];
}


@end
