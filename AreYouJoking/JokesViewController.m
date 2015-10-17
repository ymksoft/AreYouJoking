//
//  JokesViewController.m
//  AreYouJoking
//
//  Created by Юрий Куприянов on 17.10.15.
//  Copyright © 2015 YMK Soft. All rights reserved.
//

#import "JokesViewController.h"

@interface JokesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *jokes;

@end

@implementation JokesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(self.jokes.count == 0) {
        [self updateData];
    }
}

-(void) updateData {
    
    NSString *urlString = @"http://www.umori.li/api/get?site=bash.im&name=bash&num=10";
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [session dataTaskWithRequest:request];
    
    
    
}

@end
