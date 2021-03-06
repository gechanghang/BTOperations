//
//  BTGroupOperation.m
//  BTOperations
//
//  Created by BYTE on 2017/10/22.
//

#import "BTGroupOperation.h"
#import "BTOperationQueue.h"
@interface BTGroupOperation()<BTOperationQueueDelegate>
@property (nonatomic, strong, readwrite) BTOperationQueue *internalQueue;
@property (nonatomic, strong, readwrite) NSBlockOperation *startOperation;
@property (nonatomic, strong, readwrite) NSBlockOperation *finishOperation;
@end
@implementation BTGroupOperation

- (instancetype)initWithOperations:(NSArray *)operations {
    if (self = [super init]) {
        [self.internalQueue addOperation:self.startOperation];
        self.internalQueue.delegate = self;
        self.internalQueue.suspended = YES;
        for (NSOperation *operation in operations) {
            [self.internalQueue addOperation:operation];
        }
    }
    return self;
}

- (void)execute {
    self.internalQueue.suspended = NO;
    [self.internalQueue addOperation:self.finishOperation];
}

#pragma mark - BTOperationQueueDelegate
- (void)operationQueue:(BTOperationQueue *)operationQueue operationDidFinish:(NSOperation *)operation {
    if (operation == self.finishOperation) {
        [self finish];
    }
}

#pragma mark - setter/getter
- (BTOperationQueue *)internalQueue {
    if (!_internalQueue) {
        _internalQueue = [[BTOperationQueue alloc] init];
    }
    return _internalQueue;
}

- (NSBlockOperation *)startOperation {
    if (!_startOperation) {
        _startOperation = [NSBlockOperation blockOperationWithBlock:^{
            
        }];
    }
    return _startOperation;
}

- (NSBlockOperation *)finishOperation {
    if (!_finishOperation) {
        _finishOperation = [NSBlockOperation blockOperationWithBlock:^{
            
        }];
    }
    return _finishOperation;
}

@end
