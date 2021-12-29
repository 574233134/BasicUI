//
//  Student+CoreDataProperties.m
//  
//
//  Created by 李梦珂 on 2019/1/22.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Student"];
}

@dynamic name;
@dynamic age;
@dynamic sex;
@dynamic height;

@end
