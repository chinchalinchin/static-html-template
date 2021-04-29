import { Component, ViewChild } from '@angular/core';
import { MatDrawer } from '@angular/material/sidenav/drawer';
import *  as SRC from '../assets/conf.json';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
})
export class AppComponent {
  public title = 'static-html-template';
  public src : any = null;
  public SRCS : any = []

  @ViewChild("drawer")
  public drawer : MatDrawer | undefined;

  public ngOnInit(){
    let src_keys=Object.keys(SRC.default);
    let src_values=Object.values(SRC.default);
    for(let el of src_keys){
      let index=src_keys.indexOf(el);
      this.SRCS.push(src_values[index]);
    }

  }
  public setSource(source: any) : void {
    this.src=source.src; 
    if(this.drawer){ this.drawer.close(); }
  }
}
