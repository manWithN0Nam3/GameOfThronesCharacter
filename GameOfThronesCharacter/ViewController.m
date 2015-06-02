//
//  ViewController.m
//  GameOfThronesCharacter
//
//  Created by Alex Santorineos on 6/2/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "ViewController.h"
#import "RetiredGOT.h"
#import "AppDelegate.h"
#import "GOT.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *retiredArray;
@property NSArray *array2;
@property NSManagedObjectContext *moc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    self.moc = appDelegate.managedObjectContext;

//key
    [self load];

    [self.tableView reloadData];
//key

[RetiredGOT retrieveSuperheroesWithCompletion:^(NSArray *array) {
    self.retiredArray = array;
    [self populateRetiredGOTIfEmpty];
}];
    [self load];


    NSLog(@"%@",self.retiredArray);
}

-(void)load{

    //request data from entity "Superhero"
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"GOT"];

//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"character" ascending:YES];
//    request.sortDescriptors = @[sortDescriptor];
    //puts all info from request on array
    self.array2 = [self.moc executeFetchRequest:request error:nil];
    [self.tableView reloadData];
}

-(void)populateRetiredGOTIfEmpty{
    if (self.array2.count == 0 ) {
        //going through data from RetiredSuperHero Class
        for (RetiredGOT *rGot in self.retiredArray) {
            NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:@"GOT" inManagedObjectContext:self.moc];
            [object setValue:rGot.actor forKey:@"actor"];
            [object setValue:rGot.character forKey:@"character"];

            [self.moc save:nil];
        }
        [self load];
    }
    
}
- (IBAction)onButtonTapped:(UIBarButtonItem *)sender {

    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"add new Character" message:@"👩‍👩‍👧😷😜" preferredStyle:UIAlertControllerStyleAlert];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"character name";
    }];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"actor";
    }];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *textField0 = alertController.textFields[0];
        UITextField *textField1 = alertController.textFields[1];
//        UITextField *textField2 = alertController.textFields[2];
//        UITextField *textField3 = alertController.textFields[3];

        NSString *characterTextField = textField0.text;
        NSString *actorTextField = textField1.text;
//        NSString *playedByTextField = textField2.text;
//        NSString *maleOrFemaleTextField = textField3.text;

         NSManagedObject *got = [NSEntityDescription insertNewObjectForEntityForName:@"GOT" inManagedObjectContext:self.moc];
        [got setValue:characterTextField forKey:@"character"];
        [got setValue:actorTextField forKey:@"actor"];
        [self.moc save:nil];
        [self load];
    }];

    [alertController addAction:save];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
//    [self.tableView reloadData];
    [self load];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.array2.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOne"];
    GOT *rGot = [self.array2 objectAtIndex:indexPath.row];
    cell.textLabel.text = rGot.character;
//    cell.detailTextLabel.text = rGot.actor;


    return cell;

}

@end
