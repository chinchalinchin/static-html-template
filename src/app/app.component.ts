import { Component, ViewChild } from '@angular/core';
import { MatDrawer } from '@angular/material/sidenav/drawer';

const SRC = [
  {
    src: '/assets/00_thedream.html',
    name: 'the dream'
  },
  {
    src: '/assets/01_monday_10_21.html',
    name: 'monday, october 21'
  },
  {
    src: '/assets/02_tuesday_10_22.html',
    name: 'tuesday, october 22'
  },
  {
    src: '/assets/03_wednesday_10_23.html',
    name: 'wednesday, october 23'
  },
  {
    src: '/assets/04_thursday_10_24.html',
    name: 'thursday, october 24'
  },
  {
    src: '/assets/05_friday_10_25.html',
    name: 'friday, october 25'
  }
]

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
})
export class AppComponent {
  public title = 'the-long-goodbye';
  public src : any = null;
  public SRCS : any = SRC

  @ViewChild("drawer")
  public drawer : MatDrawer | undefined;

  public setChapter(chapter: any) : void {
    this.src=chapter.src; 
    if(this.drawer){ this.drawer.close(); }
  }
}
