//
//  main.m
//  add_new_command
//
//  Created by daole on 2018/11/12.
//  Copyright © 2018 daole. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    for (int i =0 ; i< argc; i++) {
        printf("arg %d is %s \n",i,argv[i]);
    }
    if (argc<3) {
        printf("需要更多参数，第一个参数是命令名称，第二个参数是命令内容.\n 该指令会在~/.bash_profile 文件末尾追加一个新的指令\n");
    }
    char *homeDir = malloc(strlen(getenv("HOME")) +1);
    strcpy(homeDir, getenv("HOME"));
    char *bash_directoryPath = strcat(homeDir, "/.bash_profile");
    FILE *bashprofile = fopen(bash_directoryPath, "a+");
    if (bashprofile==NULL) {
        printf("~/.bash_profile 文件不存在");
        return 0;
    }

    char *startCommand = "\n";
    char *middleCommand = "(){ \n";
    char *endCommand = "\n}\n";
    char *command = malloc(2000);//生成一个可变的字符串
    strcat(command, startCommand);
    strcat(command, argv[1]);
    strcat(command, middleCommand);
    strcat(command, argv[2]);
    strcat(command, endCommand);
    free(command);
    fputs(command,bashprofile);
    fclose(bashprofile);

    printf("run source command \n");
    char *sourcestartCommand = "source ";
    char *bash_directoryPathSourceCommand = bash_directoryPath;
    char *source_command = malloc(2000);//生成一个可变的字符串
    strcat(source_command, sourcestartCommand);
    strcat(source_command, bash_directoryPathSourceCommand);

    system(source_command);
    free(source_command);
    printf("指令添加完成\n");
    
    return 0;
}
