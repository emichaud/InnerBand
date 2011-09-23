//
//  ArrayTest.m
//  iBoost
//
//  iBoost - The iOS Booster!
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "GHUnit.h"
#import "Macros.h"
#import "NSArray+Boost.h"
#import "NSMutableArray+Boost.h"

@interface ArrayTest : GHTestCase
@end

@implementation ArrayTest

- (void)setUpClass {
    // Run at start of all tests in the class
}

- (void)tearDownClass {
    // Run at end of all tests in the class
}

- (void)setUp {
    // Run before each test method
}

- (void)tearDown {
    // Run after each test method
}   

- (void)testUnretainingArray {
	NSMutableArray *array = [NSMutableArray arrayUnretaining];
	
	[array addObject:BOX_INT(5)];
}

- (void)testStacks {
    NSMutableArray *array = [NSMutableArray array];
    
    GHAssertEquals(0U, array.count, nil);

    [array pushObject:BOX_INT(1)];
    
    GHAssertEquals(1U, array.count, nil);
    GHAssertEquals(1, UNBOX_INT([array lastObject]), nil);

    [array pushObject:BOX_INT(2)];

    GHAssertEquals(2U, array.count, nil);
    GHAssertEquals(2, UNBOX_INT([array lastObject]), nil);
    
    NSInteger popped = UNBOX_INT([array popObject]);

    GHAssertEquals(1U, array.count, nil);
    GHAssertEquals(2, popped, nil);

    popped = UNBOX_INT([array popObject]);
    
    GHAssertEquals(0U, array.count, nil);
    GHAssertEquals(1, popped, nil);
}

- (void)testQueues {
    NSMutableArray *array = [NSMutableArray array];
    
    GHAssertEquals(0U, array.count, nil);
    
    [array unshiftObject:BOX_INT(1)];
    
    GHAssertEquals(1U, array.count, nil);
    GHAssertEquals(1, UNBOX_INT([array firstObject]), nil);
    
    [array unshiftObject:BOX_INT(2)];
    
    GHAssertEquals(2U, array.count, nil);
    GHAssertEquals(2, UNBOX_INT([array firstObject]), nil);
    
    NSInteger shifted = UNBOX_INT([array shiftObject]);
    
    GHAssertEquals(1U, array.count, nil);
    GHAssertEquals(2, shifted, nil);
    
    shifted = UNBOX_INT([array shiftObject]);
    
    GHAssertEquals(0U, array.count, nil);
    GHAssertEquals(1, shifted, nil);
}

- (void)testDeleteIfEmpty {
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *emptyArray = [NSMutableArray array];

    // nothing there
    [array deleteIf: (ib_enum_bool_t)^(id obj) { return YES; }];
    
    GHAssertEqualObjects(emptyArray, array, nil);
}

- (void)testDeleteIfByNumber {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:BOX_INT(1), BOX_INT(2), BOX_INT(3), BOX_INT(4), BOX_INT(5), nil];
    NSMutableArray *oddArray = [NSMutableArray arrayWithObjects:BOX_INT(1), BOX_INT(3), BOX_INT(5), nil];
    
    // remove the evens
    [array deleteIf: (ib_enum_bool_t)^(id obj) { return (UNBOX_INT(obj) % 2 == 0); }];
    
    GHAssertEqualObjects(oddArray, array, nil);
}

- (void)testMapByNumber {
    NSArray *array = [NSMutableArray arrayWithObjects:BOX_INT(1), BOX_INT(2), BOX_INT(3), BOX_INT(4), BOX_INT(5), nil];
    NSArray *doubledArray = [NSMutableArray arrayWithObjects:BOX_INT(2), BOX_INT(4), BOX_INT(6), BOX_INT(8), BOX_INT(10), nil];
    
    // remove the evens
    NSArray *mappedArray = [array map: (ib_enum_id_t)^(id obj) { return BOX_INT((UNBOX_INT(obj) * 2)); }];
    
    GHAssertEqualObjects(doubledArray, mappedArray, nil);
}

@end
