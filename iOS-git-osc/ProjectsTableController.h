//
//  ProjectsTableController.h
//  iOS-git-osc
//
//  Created by chenhaoxiang on 14-6-30.
//  Copyright (c) 2014年 chenhaoxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectsTableController : UITableViewController <UIScrollViewDelegate>

@property NSMutableArray *projectsArray;
@property BOOL personal;
@property int arrangeType;
//@property BOOL loadingMore;
- (void) reloadType:(int)newArrangeType;

@end