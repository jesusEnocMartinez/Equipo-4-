import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { ListarComponent } from './Persona/listar/listar.component';
import { InsertComponent } from './Persona/insert/insert.component';
import { UpdateComponent } from './Persona/update/update.component';
// tslint:disable-next-line: import-spacing
import {FormsModule}from '@angular/forms';
// tslint:disable-next-line: import-spacing
import {ServiceService} from '../app/Service/service.service';
// tslint:disable-next-line: import-spacing
import {HttpClientModule}from '@angular/common/http';



@NgModule({
  declarations: [
    AppComponent,
    ListarComponent,
    InsertComponent,
    UpdateComponent,

  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule
  ],
  providers: [ServiceService],
  bootstrap: [AppComponent]
})
export class AppModule { }
