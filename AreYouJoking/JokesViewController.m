//
//  JokesViewController.m
//  AreYouJoking
//
//  Created by Юрий Куприянов on 17.10.15.
//  Copyright © 2015 YMK Soft. All rights reserved.
//

#import "JokesViewController.h"
#import "Joke.h"
#import "JokeDtailtedViewController.h"

@interface JokesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *jokes;

@end

@implementation JokesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if(!self.jokes) self.jokes = [NSMutableArray new];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(self.jokes.count == 0) {
        [self updateData];
    }
}


-(void) updateData {
    
    NSString *urlString = @"http://www.umori.li/api/get?site=bash.im&name=bash&num=100";
    
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
        
        //NSLog(@"%@",parsedData);
        
        [self parseData:parsedData];
        
    }] resume];
    
    //NSLog(@"thread dataTaskRequest - Session was started");
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.jokes.count;
}

-(void) parseData:(NSMutableArray *)jokesDic {
    
    for (NSDictionary *pInfo in jokesDic) {
        
        Joke *pJoke = [Joke jokeFromDictionary:pInfo];
        
        [self.jokes addObject:pJoke];
        
        //NSLog(@"%@",pJoke.sourceSite);
     
    }
    
    //NSLog(@"parsed OK");
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.tableView reloadData];
        //NSLog(@"reload OK");
    }];
    
    
}
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
     //NSLog(@"query");
     
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jokeCellID"];
 
     Joke *aJoke = self.jokes[indexPath.row];
 
     //Настройте ячейку в соответствии с названием города
     cell.textLabel.text = aJoke.html;
     cell.detailTextLabel.text = aJoke.sourceSite;
    
     return cell;
 }

/*

 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
     Joke  *aJoke = self.jokes[indexPath.row];
 
     //начать переход на другой вьюконтроллер и послать вдогонку город
     [self performSegueWithIdentifier:@"Joke Show" sender:aJoke];
     
 }
 */

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
     
     //Проверим название перехода
     if ([segue.destinationViewController isKindOfClass:[JokeDtailtedViewController class]]) {
         
         
         JokeDtailtedViewController *controller = segue.destinationViewController;
         
         UITableViewCell *aCell = sender;
         
         NSIndexPath *path = [self.tableView indexPathForCell:aCell];
         
         Joke *aJoke = self.jokes[path.row];
         
         controller.joke = aJoke;
     }
 }



@end
