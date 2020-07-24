import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ListarComponent } from './Persona/listar/listar.component';
import { InsertComponent } from './Persona/insert/insert.component';
import { UpdateComponent } from './Persona/update/update.component';


const routes: Routes = [
{path: 'listar', component: ListarComponent},
{path: 'insert', component: InsertComponent},
{path: 'update', component: UpdateComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
