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
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        if (error){
            NSLog(@"%@", error.domain);
            //NSLog(@"%@", error);
        }
        
        id parsedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@"%@",parsedData);
        
        [self parseData:parsedData];
        
    }] resume];
    
    NSLog(@"thread dataTaskRequest - Session was started");
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.jokes.count;
}

-(void) parseData:(NSArray *)jokes {
    /*
    site
    name
    desc
    link
    elementPureHtml
     */
}
/*
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityCellID"];
 City *aCity = self.cities[indexPath.row];
 
 //Настройте ячейку в соответствии с названием города
 cell.textLabel.text = aCity.name;
 
 return cell;
 }
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 City *selectedCity = self.cities[indexPath.row];
 
 //начать переход на другой вьюконтроллер и послать вдогонку город
 [self performSegueWithIdentifier:@"Show City" sender:selectedCity];
 }
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 //Проверим название перехода
 if ([segue.identifier isEqualToString:@"Show City"]){
 City *cityToPresent = sender;
 CityDetailedViewController *controller = segue.destinationViewController;
 
 controller.city = cityToPresent;
 }
 }
 */


@end
