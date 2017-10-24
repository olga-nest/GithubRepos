//
//  RepoClass.m
//  GithubRepos
//
//  Created by Olga on 10/23/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

#import "RepoClass.h"

@implementation RepoClass

- (instancetype)initWithName: (NSString *) repoName
{
    self = [super init];
    if (self) {
        _repoName = repoName;
    }
    return self;
}

@end
