import { Component, ViewChild } from '@angular/core';
import { MatDrawer } from '@angular/material/sidenav/drawer';
import *  as SRC from '../assets/conf.json';
import { StaticService } from './services/static.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
})
export class AppComponent {
  public title_1 = 'chinchalinchin';
  public title_2 = 'industries'
  public src : any = null;
  public previousSrc : any = null;
  public nextSrc : any = null;
  public SRCS : any = [];
  public displayHTML : any = null;
  public fresh : boolean = true;

  @ViewChild("drawer")
  public drawer : MatDrawer | undefined;

  constructor(private staticService: StaticService){

  }
  public ngOnInit(){
    this.initSrcs();
  }

  public initSrcs(){
    let src_keys=Object.keys(SRC.default);
    let src_values=Object.values(SRC.default);
    for(let el of src_keys){
      let index=src_keys.indexOf(el);
      this.SRCS.push(src_values[index]);
    }
  }

  public begin(): void{
    this.fresh = false;
    this.setSource(this.SRCS[0]);
  }

  public setSource(source: any) : void {
    if(source){ 
      this.src=source.src; 
      this.staticService.getStaticHTML(source).subscribe((data)=>{
        this.displayHTML = data;
      })
    }
    else { this.src = null; } 
    this.setNavigationSources(source);
    if(this.drawer){ this.drawer.close(); }
  }

  public setNavigationSources(source: any): void {
    if(!source){
      this.previousSrc = null;
      this.nextSrc = null;
    }
    else{
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
}
