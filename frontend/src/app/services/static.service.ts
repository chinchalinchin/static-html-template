import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class StaticService {

  constructor(private http: HttpClient) { }

  public getStaticHTML(source: any){
    return this.http.get(source.src, {responseType: "text"});
  }
}
