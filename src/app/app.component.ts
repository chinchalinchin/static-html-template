import { Component, ViewChild } from '@angular/core';
import { MatDrawer } from '@angular/material/sidenav/drawer';

const SRC = [
  {
    src: '/assets/00.html',
    name: 'zero'
  },
  {
    src: '/assets/01.html',
    name: 'one'
  },
  {
    src: '/assets/02.html',
    name: 'two'
  },
  {
    src: '/assets/03.html',
    name: 'three'
  },
  {
    src: '/assets/04.html',
    name: 'four'
  },
  {
    src: '/assets/05.html',
    name: 'five'
  }
]

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
})
export class AppComponent {
  public title = 'static-html-template';
  public src : any = null;
  public SRCS : any = SRC

  @ViewChild("drawer")
  public drawer : MatDrawer | undefined;

  public setSource(source: any) : void {
    this.src=source.src; 
    if(this.drawer){ this.drawer.close(); }
  }
}
