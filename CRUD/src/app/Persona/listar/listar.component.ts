import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import {ServiceService} from '../../Service/service.service';
import { Persona } from '../Modelo/Persona';


@Component({
  selector: 'app-listar',
  templateUrl: './listar.component.html',
  styleUrls: ['./listar.component.css']
})
export class ListarComponent implements OnInit {
    personas: Persona[];
  constructor(private service: ServiceService , private router: Router) { }

  ngOnInit() {
    this.service.getPersonas()
    .subscribe(data => {
      this.personas = data;
    });
  }
Editar(persona: Persona): void {
localStorage.setItem('clave', persona.clave.toString());
this.router.navigate(['update']);
}
Delete(persona: Persona) {
  this.service.deletePersona(persona)
  .subscribe(data=> {
    this.personas = this.personas.filter(p => p! == persona);
    alert("Usuario eliminado...");
  });
}
}
