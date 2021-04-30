import { Component, ViewChild } from '@angular/core';
import { MatDrawer } from '@angular/material/sidenav/drawer';
import { timeStamp } from 'node:console';
import *  as SRC from '../assets/conf.json';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
})
export class AppComponent {
  public title = 'chinchalinchin web industries';
  public src : any = null;
  public previousSrc : any = null;
  public nextSrc : any = null;
  public SRCS : any = []

  @ViewChild("drawer")
  public drawer : MatDrawer | undefined;

  public ngOnInit(){
    this.initSrcs();
    this.nextSrc = this.SRCS[1];
  }

  public initSrcs(){
    let src_keys=Object.keys(SRC.default);
    let src_values=Object.values(SRC.default);
    for(let el of src_keys){
      let index=src_keys.indexOf(el);
      this.SRCS.push(src_values[index]);
    }
  }
  public setSource(source: any) : void {
    this.src=source.src; 
    this.setNavigationSources(source);
    if(this.drawer){ this.drawer.close(); }
  }

  public setNavigationSources(source: any): void {
    let current_index : number = this.SRCS.indexOf(source)
    let length : number = this.SRCS.length;
    if (current_index == length -1){
      this.nextSrc = null;
      this.previousSrc = this.SRCS[length-2]
    }
    else if(current_index == 0){
      this.nextSrc = this.SRCS[1]
      this.previousSrc = null;
    }
    else{
      this.nextSrc = this.SRCS[current_index+1];
      this.previousSrc = this.SRCS[current_index-1];
    }
  }
}
