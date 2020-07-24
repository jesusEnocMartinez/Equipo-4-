import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ServiceService } from 'src/app/Service/service.service';
import { Persona } from 'src/app/Persona/Modelo/Persona';

@Component({
  selector: 'app-update',
  templateUrl: './update.component.html',
  styleUrls: ['./update.component.css']
})
export class UpdateComponent implements OnInit {
  persona: Persona = new Persona();
  constructor(private router: Router, private service: ServiceService) { }

  ngOnInit() {
    this.Editar();
  }
  Editar() {
    const clave = localStorage.getItem('clave');
    this.service.getpersonaclave(+clave)
    .subscribe(data => {
      this.persona = data;
    });


  }
  Actualizar(persona: Persona) {
    this.service.Updatepersona(persona)
    .subscribe(data => {
      this.persona = data;
      alert('Se Actualizo con Exito...!!!');
      this.router.navigate(['listar']);
    });
}

}
