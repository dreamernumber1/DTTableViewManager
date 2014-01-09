//
//  ReorderTableViewController.m
//  TableViewFactory
//
//  Created by Denys Telezhkin on 10/16/12.
//  Copyright (c) 2012 Denys Telezhkin. All rights reserved.
//

#import "ReorderTableViewController.h"
#import "DTTableViewSectionModel.h"
#import "Example.h"

@implementation ReorderTableViewController

-(void)addExampleCells
{
    DTTableViewMemoryStorage * storage = [self memoryStorage];
    
    [storage addTableItem:[Example exampleWithText:@"Section 1 cell" andDetails:@""] toSection:0];
    [storage addTableItem:[Example exampleWithText:@"Section 1 cell" andDetails:@""] toSection:0];
    [storage addTableItem:[Example exampleWithText:@"Section 2 cell" andDetails:@""] toSection:1];
    [storage addTableItem:[Example exampleWithText:@"Section 3 cell" andDetails:@""] toSection:2];
    [storage addTableItem:[Example exampleWithText:@"Section 3 cell" andDetails:@""] toSection:2];
    [storage addTableItem:[Example exampleWithText:@"Section 3 cell" andDetails:@""] toSection:2];
    
    [storage setSectionHeaderModels:@[@"Section 1", @"Section 2", @" Section 3"]];
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    [self.tableView setEditing:editing animated:animated];
}

#pragma  mark - view activity

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Reorder";
    
    [self addExampleCells];
    
    self.navigationItem.rightBarButtonItem = [self editButtonItem];
}

#pragma mark - TableView delegate methods

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
toIndexPath:(NSIndexPath *)destinationIndexPath
{
    DTTableViewMemoryStorage * storage = [self memoryStorage];

    DTTableViewSectionModel * fromSection = [storage sections][sourceIndexPath.section];
    DTTableViewSectionModel * toSection = [storage sections][destinationIndexPath.section];
    id tableItem = fromSection.objects[sourceIndexPath.row];

    [fromSection.objects removeObjectAtIndex:sourceIndexPath.row];
    [toSection.objects insertObject:tableItem atIndex:destinationIndexPath.row];
}

@end
