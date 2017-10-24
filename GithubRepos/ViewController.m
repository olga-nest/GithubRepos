//
//  ViewController.m
//  GithubRepos
//
//  Created by Olga on 10/23/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate >

@property (nonatomic) NSArray *repos;
@property (nonatomic) NSMutableArray *allRepos;
@property (weak, nonatomic) IBOutlet UITableView *repoTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestDataFromGithab];
    

}

-(void)requestDataFromGithab {
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/olga-nest/repos"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        self.repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]; // 2
        
        if (jsonError) { // 3
            // Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        // If we reach this point, we have successfully retrieved the JSON from the API
        for (NSDictionary *repo in self.repos) { // 4
            
            if (!self.allRepos) {
                self.allRepos = [NSMutableArray new];
            }
            
            NSString *repoName = repo[@"name"];
            RepoClass *repo = [[RepoClass alloc]initWithName:repoName];
            [self.allRepos addObject:repo];
            NSLog(@"repo: %@", repo.repoName);
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            NSLog(@"NSOperationQueue mainQueue, array count %lu", self.allRepos.count);
            [self.repoTableView reloadData];
            
        }];
    }];
    
    [dataTask resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Number of repos in the array %lu", self.repos.count);
    return self.repos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RepoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    
    NSLog(@"Creating cels, array count %lu", self.allRepos.count);
    
    RepoClass *repo = [self.allRepos objectAtIndex:indexPath.row];
    
    cell.repoLabel.text = repo.repoName;
    NSLog(@"Creating a cell with name %@", repo.repoName);
    
    return cell;
}


@end
