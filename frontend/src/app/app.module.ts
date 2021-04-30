import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import { NoopAnimationsModule } from '@angular/platform-browser/animations';

import { MatSidenavModule } from '@angular/material/sidenav';
import { MatButtonModule } from '@angular/material/button';
import { MatDividerModule } from '@angular/material/divider';
import { MatGridListModule } from '@angular/material/grid-list';
import { MatRippleModule } from '@angular/material/core';

import {MatIconModule} from '@angular/material/icon';


import { SafePipe } from './pipes/safe.pipe';

@NgModule({
  declarations: [
    AppComponent,
    SafePipe
  ],
  imports: [
    BrowserModule,
    MatSidenavModule,
    MatButtonModule,
    MatDividerModule,
    MatGridListModule,
    MatIconModule,
    MatRippleModule,
    NoopAnimationsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
