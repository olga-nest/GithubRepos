//
//  RepoClass.h
//  GithubRepos
//
//  Created by Olga on 10/23/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepoClass : NSObject

@property (nonatomic) NSString *repoName;
@property (nonatomic) NSString *urlString;

- (instancetype)initWithName: (NSString *) repoName andUrlString: (NSString *) urlString;

@end
