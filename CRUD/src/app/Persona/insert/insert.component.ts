import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ServiceService } from 'src/app/Service/service.service'
import { Persona } from '../Modelo/Persona';
@Component({
  selector: 'app-insert',
  templateUrl: './insert.component.html',
  styleUrls: ['./insert.component.css']
})
export class InsertComponent implements OnInit {
  persona:Persona=new Persona();
  constructor(private router:Router,private service:ServiceService ) { }
  ngOnInit() {
  }
  Guardar(persona:Persona){
    this.service.createpersona(this.persona)
    .subscribe(data=>{
      alert("se agrego con exito......!!!!!");
    this.router.navigate(["listar"]);
    })
  }
}
